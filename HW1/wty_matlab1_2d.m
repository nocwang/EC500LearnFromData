clear;clc
load('matlab1_2b_beta_nwc.mat','beta')
[Document_ID,Word_ID,Word_count]=textread('train.data','%f %f %f');
[Document_ID_te,Word_ID_te,Word_count_te]=textread('test.data','%f %f %f');
[Label_tr]=textread('train.label','%f');
[Label_te]=textread('test.label','%f');
%% to get alpha/ W
NU_uni_tr=unique(Word_ID);
NU_uni_te=unique(Word_ID_te);
NU_uni_en = union(NU_uni_tr,NU_uni_te);
W = length(NU_uni_en);%l_NU_uni_en
alpha=1/W;

beta_after_alpha=beta+alpha*ones(size(beta),'like',beta);
temp=sum(beta_after_alpha(:,:),1);
for c=1:20
    beta_after_alpha(:,c)=beta_after_alpha(:,c)/temp(c);
end
Bprod=zeros(1,20);
P_prior=full( sparse(Label_tr,ones(length(Label_tr),1),ones(length(Label_tr),1)));% sum(P_prior)
logbeta_after_alpha=log(beta_after_alpha);%
Label_predict_test_d=zeros(length(Label_te),1);

tic
for k=1:length(Label_te)
    Bprod = Word_count_te(Document_ID_te==k)'*logbeta_after_alpha(Word_ID_te(Document_ID_te==k),:);%unique(Word_ID_te(Document_ID_te==k));
    Bprod = Bprod+log(P_prior');
    [~,Label_predict_test_d(k)]=max(Bprod);
end
toc%29.764698 seconds.  59.540153 seconds.
result1_2d_1=sum(Label_te==Label_predict_test_d)/length(Label_te)%   0.6197 to  0.6203 ccr_test_d
[result1_2d_2,order] = confusionmat(Label_te,Label_predict_test_d);


save('matlab1_2d_20151009.mat')