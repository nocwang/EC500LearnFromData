clear;clc
load('data_cancer.mat')
X=zscore(X);
Y(Y==0)=2;% LABEL MUST BE POSITIVE INTEGERS for code RDA
numofClass=length(unique(Y));

N=19;
ccr_train=zeros(N,1);
ccr_test=zeros(N,1);

tic

s = RandStream('mt19937ar','Seed',1);
RandStream.setGlobalStream(s);
randorder=randperm(216);
idtrain=randorder(1:150);
idtest=randorder(151:216);

X_train=X(idtrain,:);
Y_train=Y(idtrain);
X_test=X(idtest,:);
Y_test=Y(idtest);

gamma=0.1:0.05:1;
for k=1:19
    [RDAmodel]= wty_RDA_train(X_train, Y_train,gamma(k), numofClass);
    [Y_predict_train] = wty_RDA_test(X_train, RDAmodel, numofClass);
    [Y_predict_test] = wty_RDA_test(X_test, RDAmodel, numofClass);
    ccr_train(k)=sum(Y_train==Y_predict_train)/length(Y_train);
    ccr_test(k)=sum(Y_test==Y_predict_test)/length(Y_test);
    k
end
toc%178.573814 seconds.

h=figure; hold on;
xx = 0.1:0.05:1;
plot(xx,ccr_train,'rx')
hold on
plot(xx,ccr_test,'bo')
% axis([0.1 1]);
xlabel('gamma=0.1:0.1:1')
ylabel('ccr of train & ccr of test')
title('matlab1-1d')
legend('train','test')
figfilename = 'result1_1d_20151009';
saveas(h,figfilename,'jpg');

save('matlab1_1d_20151009.mat')
