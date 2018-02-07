function [QDAmodel]= wty_QDA_train(X_train, Y_train, numofClass)
% Training QDA
%
% EC 500 Learning from Data
% Fall semester, 2015
% by Prakash Ishwar
%
% Problem 1.1 Gaussian Discriminant Analysis
% Assuming D = dimension of data
% Inputs:
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train; the classes are labeled
% from 1 to numofClass
% numofClass : number of class 
%
% output:
% QDAmodel: the parameters of QDA classifier which has the follwoing fields
% Mu : a numofClass * D matrix, i-th row = mean vector of class i
% Sigma : a D*D*numofClass array, Sigma(:,:,i) = covariance of class i
% pi : a numofClass *1 vector, pi(i) = prior probability of class i

% output:
% Y_predict predicted labels for all the testing data points in X_test

% Write your code here:
num_label=zeros(numofClass,1);
QDAmodel.Mu=zeros(numofClass,size(X_train,2));
QDAmodel.Sigma=zeros(size(X_train,2),size(X_train,2),numofClass);
index=[];
for i=1:numofClass
    index=find(Y_train==i);  
    num_label(i)=size(index,1);   % the number of samples in class i
    QDAmodel.Mu(i,:)=mean(X_train(index,:));  %sum of x for class i
    QDAmodel.Sigma(:,:,i)=cov(X_train(index,:),1);
end
QDAmodel.pi=(num_label/size(X_train,1));
end