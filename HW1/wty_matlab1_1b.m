clear;clc
load('data_iris.mat')
numofClass=length(unique(Y));

N=10;

meanvector=zeros(N,numofClass,size(X,2));%zeros(10,4)
varQDA=zeros(N,size(X,2),numofClass);%zeros(10,4,3)
varLDA=zeros(N,size(X,2));%zeros(10,4)
ccrLDA=zeros(N,1);
ccrQDA=zeros(N,1);
CFLDA=zeros(N,numofClass,numofClass);
CFQDA=zeros(N,numofClass,numofClass);

tic
for k=1:N
    randorder=randperm(150);
    idtrain=randorder(1:100);
    idtest=randorder(101:150);
    X_train=X(idtrain,:);
    Y_train=Y(idtrain);
    X_test=X(idtest,:);
    Y_test=Y(idtest);

    [LDAmodel]= wty_LDA_train(X_train, Y_train, numofClass);
    [Y_predict_LDA] = wty_LDA_test(X_test, LDAmodel, numofClass);
    meanvector(k,:,:)=LDAmodel.Mu;% 3 * 4
    varLDA(k,:)=diag(LDAmodel.Sigmapooled)';
    
    ccrLDA(k)=sum(Y_test==Y_predict_LDA)/length(Y_test);
    CFLDA(k,:,:) = confusionmat(Y_test,Y_predict_LDA);
    
    [QDAmodel]= wty_QDA_train(X_train, Y_train, numofClass);
    [Y_predict_QDA] = wty_QDA_test(X_test, QDAmodel, numofClass);
    for i=1:numofClass
        varQDA(k,:,i)=diag(QDAmodel.Sigma(:,:,i))';
    end
    
    ccrQDA(k)=sum(Y_test==Y_predict_QDA)/length(Y_test);
    CFQDA(k,:,:) = confusionmat(Y_test,Y_predict_QDA);
end
toc% 0.361320 seconds. 0.154719 seconds.

result1_2b_1=mean(meanvector,1);
result1_2b_1=squeeze(result1_2b_1);

result1_2b_2=mean(varQDA,1);
result1_2b_2=squeeze(result1_2b_2)';

result1_2b_3=mean(varLDA,1);
result1_2b_4=[mean(ccrLDA),std(ccrLDA);mean(ccrQDA),std(ccrQDA)];
[~,b]=max(ccrLDA);
result1_2b_5_1=CFLDA(b,:,:);
result1_2b_5_1=squeeze(result1_2b_5_1);
[~,bb]=min(ccrLDA);
result1_2b_5_2=CFLDA(bb,:,:);
result1_2b_5_2=squeeze(result1_2b_5_2);
save('matlab1_1b_20151009.mat')
