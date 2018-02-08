clear;clc;
load('prostateStnd.mat')
N_tr=size(Xtrain,1);
N_te=size(Xtest,1);
log_lamda=-5:10;
%%
%3.4(a)
%http://www.ece.ubc.ca/~xiaohuic/code/LassoShooting/lassoShooting.m
b=zeros(8,length(log_lamda));
mse1_tr=zeros(length(log_lamda),1);mse1_te=zeros(length(log_lamda),1);

sXtr = Xtrain-repmat(mean(Xtrain),size(Xtrain,1),1);
sXte = Xtest-repmat(mean(Xtrain),size(Xtest,1),1);
std_Xtrain=std(Xtrain);%1*202 temp=std(Xtrain); temp(removed_dim);
std_Xtrain(std_Xtrain==0)=1;
sXtr=sXtr./repmat(std_Xtrain, size(Xtrain,1),1);%std(Xtrain);range(Xtrain);
sXte=sXte./repmat(std_Xtrain, size(Xtest,1),1);
sYtr = ytrain-mean(ytrain);

maxIt=100; tol=10^-5; standardize=false;
for d=1:length(log_lamda) 
    b(:,d) = lassoShooting(sXtr, sYtr, exp(log_lamda(d)), maxIt, tol,standardize);%, standardize
    mse1_tr(d)=mse(sYtr-sXtr*b(:,d));
    mse1_te(d)=mse(ytest-mean(ytrain)-sXte*b(:,d));
end
plot(log_lamda, b(1:8,:)./repmat(std_Xtrain', 1,16));
title('matlab3-4ai')
xlabel('log-lamda (-5 to 10)');
ylabel('lasso coefficients of each feature');
legend(names{1:8})


plot(log_lamda, mse1_tr,log_lamda, mse1_te);
title('matlab3-4aii')
xlabel('log-lamda (-5 to 10)');
ylabel('mse-lasso');
legend('mse-tr','mse-te')




%%
%3.4(c)i

w2=zeros(9,length(log_lamda));
mse_tr=zeros(length(log_lamda),1);mse_te=zeros(length(log_lamda),1);

for d=1:length(log_lamda)
    w2(:,d)=ridge(ytrain, Xtrain, exp(log_lamda(d)), 0);
    mse_tr(d)=mse(ytrain-[ones(N_tr,1),Xtrain]*w2(:,d));
    mse_te(d)=mse(ytest-[ones(N_te,1),Xtest]*w2(:,d));
end
plot(log_lamda, w2(2:9,:));
title('matlab3-4ci')
xlabel('log-lamda (-5 to 10)');
ylabel('ridge coefficients of each feature');
legend(names{1:8})
%3.4(c)ii
plot(log_lamda, mse_tr,log_lamda, mse_te);
title('matlab3-4cii')
xlabel('log-lamda (-5 to 10)');
ylabel('mse');
legend('mse-tr','mse-te')