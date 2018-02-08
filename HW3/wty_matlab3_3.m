%3.3(a)i
clear;clc;
load('quad_data.mat')%plot(xtest,ytest)
xtr15=bsxfun(@power,xtrain,[14:-1:1]);
xte15=bsxfun(@power,xtest,[14:-1:1]);

N_tr=size(xtrain,1);
N_te=size(xtest,1);
degree=[2,6,10,14];
wb=cell(4,1);
ytr_predict=zeros(size(xtrain,1),4);

for d=1:length(degree)
    temp=xtr15(:,15-degree(d):end);
    wb{d}=ridge(ytrain, temp, 0, 0);
    ytr_predict(:,d)=[ones(N_tr,1),temp]*wb{d};
end

plot(xtrain,ytrain,'o');hold on;
plot(xtrain, ytr_predict);hold on;%?? jia hua tu
title('matlab3-3ai')
xlabel('x');
ylabel('y');
legend('data','degree-2','degree-6','degree-10','degree-14')

%3.3(a)ii
w=cell(14,1);
mse_tr=zeros(14,1);mse_te=zeros(14,1);

for d=1:14
    temp=xtr15(:,d:end);
    w{d}=ridge(ytrain, temp, 0, 0);
    mse_tr(d)=mse(ytrain-[ones(N_tr,1),temp]*w{d});
    mse_te(d)=mse(ytest-[ones(N_te,1),xte15(:,d:end)]*w{d});
end
plot(1:14, mse_tr,1:14, mse_te);
title('matlab3-3aii')
xlabel('polynomial degree (1 to 14)');
ylabel('mse');
legend('mse-tr','mse-te')

%3.3(b)i
log_lamda=-25:5;
w2=zeros(11,length(log_lamda));

temp=xtr15(:,5:end);
temp2=xte15(:,5:end);
for d=1:length(log_lamda)
    w2(:,d)=ridge(ytrain, temp, exp(log_lamda(d)), 0);
    mse_tr(d)=mse(ytrain-[ones(N_tr,1),temp]*w2(:,d));
    mse_te(d)=mse(ytest-[ones(N_te,1),temp2]*w2(:,d));
end
plot(log_lamda, mse_tr,log_lamda, mse_te);
title('matlab3-3bi')
xlabel('log-lamda (-25 to 5)');
ylabel('mse');
legend('mse-tr','mse-te')

[~,whichmin]=min(mse_te);

%3.3(b)ii
plot(xtest,ytest,'o');hold on;
plot(xtest,[ones(N_te,1),temp2]*wb{3});hold on;
plot(xtest,[ones(N_te,1),temp2]*w2(:,whichmin));hold on;%log_lamda(whichmin)==-3
title('matlab3-3bii')
xlabel('x');
ylabel('y');
legend('data','degree-10','l2-regularized degree 10')