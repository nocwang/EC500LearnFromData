function [LDAmodel]= wty_LDA_train(X_train, Y_train, numofClass)
% Training LDA
%
% EC 500 Learning from Data
% Fall semester, 2015
% by Prakash Ishwar
%
% Assuming D = dimension of data
% Inputs:
% X_train : training data matrix, each row is a training data point
% Y_train : training labels for rows of X_train
% numofClass : number of class 
% Assuming that the classes are labeled  from 1 to numofClass
%
% Output:
% LDAmodel: the parameters of QDA classifier which has the follwoing fields
% Mu : numofClass * D matrix, i-th row = mean vector of class i
% Sigmapooled : D*D  covariance matrix
% pi : numofClass *1 vector, pi(i) = prior probability of class i

% output:
% Y_predict predicted labels for all the testing data points in X_test

% Write your codes here:

num_label=zeros(numofClass,1);
LDAmodel.Mu=zeros(numofClass,size(X_train,2));
index=[];
for i=1:numofClass
    index=find(Y_train==i);  
    num_label(i)=size(index,1);   % the number of samples in class i
    LDAmodel.Mu(i,:)=mean(X_train(index,:));  %sum of x for class i
end
LDAmodel.Sigmapooled=cov(X_train,1);   
LDAmodel.pi=(num_label/size(X_train,1));
