clear;clc
[Document_ID,Word_ID,Word_count]=textread('train.data','%f %f %f');
[Document_ID_te,Word_ID_te,Word_count_te]=textread('test.data','%f %f %f');
% [Label_tr]=textread('train.label','%f');
% [Label_te]=textread('test.label','%f');
%%1_2a_1
NU_uni_tr=unique(Word_ID);
NU_uni_te=unique(Word_ID_te);
NU_uni_en = union(NU_uni_tr,NU_uni_te);
l_NU_uni_tr = length(NU_uni_tr)
l_NU_uni_te = length(NU_uni_te)
l_NU_uni_en = length(NU_uni_en)%

% %%1_2a_2 wrong
% tic
% [a,b]=hist(Document_ID,unique(Document_ID));
% avg_doc_l_tr=mean(a)%130.2108
% [a,b]=hist(Document_ID_te,unique(Document_ID_te));
% avg_doc_l_te=mean(a)%  128.9639
% toc%1.149767 seconds. but wrong

%%1_2a_2
%Use repeated subscripts to accumulate values into a single sparse matrix that would otherwise require one or more loops.
tic
S = sparse(Document_ID,ones(length(Document_ID),1),Word_count);
avg_doc_leng_tr=mean(S)%245.3900
SS = sparse(Document_ID_te,ones(length(Document_ID_te),1),Word_count_te);
avg_doc_leng_te=mean(SS)%239.4296
toc



%%1_2a_3
%C = setdiff(A,B) returns the data in A that is not in B.
NU_uni_te_not_tr = setdiff(NU_uni_te,NU_uni_tr);
l_NU_uni_te_not_tr=length(NU_uni_te_not_tr)
