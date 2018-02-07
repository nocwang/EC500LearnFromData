function [Y_predict] = wty_QDA_test(X_test, QDAmodel, numofClass)
% Testing for QDA
%
% EC 500 Learning from Data
% Fall semester, 2015
% by Prakash Ishwar
%
% Assuming D = dimension of data
% Inputs:
% X_test : test data matrix, each row is a test data point
%
% numofClass : number of class
%
% QDAmodel: the parameters of QDA classifier which has the follwoing fields
%
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigma : D*D*numofClass array, Sigma(:,:,i) = covariance of class i
% QDAmodel.Pi : numofClass *1 vector, Pi(i) = prior probability of class i
%
% Assuming that the classes are labeled  from 1 to numofClass

% Output:
% Y_predict predicted labels for all the testing data points in X_test

% Write your codes here:
h_QDA=zeros(size(X_test,1),numofClass);
%Y_predict=zeros(size(X_test,1),1);
for j=1:numofClass
    temp=inv(QDAmodel.Sigma(:,:,j));
    temp2=log(det(QDAmodel.Sigma(:,:,j)));
    for i=1:size(X_test,1)
        h_QDA(i,j)=0.5*(X_test(i,:)-QDAmodel.Mu(j,:))*temp*(X_test(i,:)-QDAmodel.Mu(j,:))'+0.5*temp2-log(QDAmodel.pi(j));
    end
end
[~,Y_predict]=min(h_QDA,[],2);
end