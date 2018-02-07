clear;clc
load('data_mnist_test.mat')
load('data_mnist_train.mat')
N_tr=size(X_train,1);
N_te=size(X_test,1);
D=X_train*(X_test');
X_tr=zeros(N_tr,1);
X_te=zeros(N_te,1);
Y_predict=zeros(N_te,1);
d=zeros(N_tr,N_te);


for i=1:N_tr
    X_tr(i)=norm(X_train(i,:))^2;
end


for j=1:N_te
    X_te(j)=norm(X_test(j,:))^2;
end


for j=1:N_te
    d(:,j)=d(:,j)+X_te(j);%[0;0]+1==[1;1]
    for i=1:N_tr
        d(i,j)=d(i,j)+X_tr(i)-2*D(i,j);
    end
    
    [~,index]=min(d(:,j));
    Y_predict(j)=Y_train(index);
end


ccr=sum(Y_test==Y_predict)/length(Y_test);%96.91%
save('matlab1_3d_20151008.mat')