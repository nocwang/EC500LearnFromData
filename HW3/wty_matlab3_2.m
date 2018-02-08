clear;clc;
load('linear_data.mat')
x=[ones(18,1),xData];
wb=inv(x'*x)*x'*yData;
y_diff=x*wb-yData;
mse_ols=mse(y_diff);
mae_ols=mae(y_diff);%mae(-[1,2,3])

%%
%(b)

b=zeros(2,4);
mse_robust=zeros(4,1);mae_robust=zeros(4,1);
b(:,1) = robustfit(xData,yData,'cauchy');
b(:,2) = robustfit(xData,yData,'fair');
b(:,3) = robustfit(xData,yData,'huber');% ist is b, 2nd is w.
b(:,4) = robustfit(xData,yData,'talwar');
for k=1:4
    y_diff2=x*b(:,k)-yData;
    mse_robust(k)=mse(y_diff2);
    mae_robust(k)=mae(y_diff2);
end

plot(xData,yData,'o');hold on;
plot(xData,x*wb);hold on;
plot(xData,x*b);hold on;
title('matlab3-2biii')
xlabel('x');
ylabel('y');
legend('data','ols','cauchy','fair','huber','talwar')





