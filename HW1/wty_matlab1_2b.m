clear;clc
[Document_ID,Word_ID,Word_count]=textread('train.data','%f %f %f');
[Document_ID_te,Word_ID_te,Word_count_te]=textread('test.data','%f %f %f');
[Label_tr]=textread('train.label','%f');
[Label_te]=textread('test.label','%f');
%% to get W
NU_uni_tr=unique(Word_ID);
NU_uni_te=unique(Word_ID_te);
NU_uni_en = union(NU_uni_tr,NU_uni_te);
% l_NU_uni_tr = length(NU_uni_tr);
% l_NU_uni_te = length(NU_uni_te);
W = length(NU_uni_en);%l_NU_uni_en
% Winv=1/W;

%1_2b_1 unique(Document_ID)==11269
beta=zeros(W,20);
tic
for c=1:20
    
    temp=find(Label_tr==c);% temp=find(Label_tr==c);
    
    Doc_nis_c= sparse(ismember(Document_ID,temp));%Doc_is_c= ismember(Document_ID,temp);
    Word_ID_c=Word_ID(Doc_nis_c);
    Word_count_c=Word_count(Doc_nis_c);
    
    S= sparse(Word_ID_c,ones(length(Word_ID_c),1),Word_count_c);%nnz(S)
    %S=full(S);
    uni_Word_ID_c=unique(Word_ID_c);
    for ww=1:length(uni_Word_ID_c)
        w=uni_Word_ID_c(ww);
        beta(w,c)=full(S(w));
    end
    %     temp=sum(beta(:,c),1);
    %     beta(:,c)=beta(:,c)/temp;
end
toc% 1.996486 seconds.
result1_2b_1=nnz(beta)%200778
% save('matlab1_2b_beta_nwc.mat','beta')
% % meanbeta=mean(beta);


%test ccr
sumbeta=sum(beta(:,:),1);
for c=1:20
    beta(:,c)=beta(:,c)/sumbeta(c);
end
Bprod=zeros(1,20);
P_prior=full( sparse(Label_tr,ones(length(Label_tr),1),ones(length(Label_tr),1)));% sum(P_prior)
logbeta=log(beta);%
Label_predict_test=zeros(length(Label_te),1);
temp=[];
tic
for k=1:length(Label_te)
    %Word_Doc_ID_k=Word_ID_te(Document_ID_te==k);
    %Word_count_ID_k=Word_count_te(Document_ID_te==k)';
    Bprod = Word_count_te(Document_ID_te==k)'*logbeta(Word_ID_te(Document_ID_te==k),:);%unique(Word_ID_te(Document_ID_te==k));
    if any(isfinite(Bprod))==0%any(isfinite([log(0),log(0)])) is 0
        temp=[temp,k];
    end
    Bprod = Bprod+log(P_prior');
    [~,Label_predict_test(k)]=max(Bprod);
end
toc%59.499988 seconds.
result1_2b_2=length(temp)

% tic
% Label_predict_test=zeros(length(Label_te),1);
% temp=[];
% for k=1:length(Label_te)
%     Bprod = prod(beta(Word_ID_te(Document_ID_te==k),:));%unique(Word_ID_te(Document_ID_te==k))
%     if any(Bprod)==0
%         temp=[temp,k];
%     end
%     Bprod = Bprod.*P_prior'; %
%     [~,Label_predict_test(k)]=max(Bprod);
% end
% toc%27.056551 seconds. 8.47% to 31.431125 seconds. 8.46% after adding P_prior
%result1_2b_2=length(temp)

result1_2b_3=sum(Label_te==Label_predict_test)/length(Label_te)%ccr_test   0.0949
save('matlab1_2b_20151009.mat')
