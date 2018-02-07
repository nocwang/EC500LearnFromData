function [Y_predict] = wty_RDA_test(X_test, LDAmodel, numofClass)
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
% Assuming that the classes are labeled  from 1 to numofClass
%
% QDAmodel: the parameters of QDA classifier which has the follwoing fields
% QDAmodel.Mu : numofClass * D matrix, i-th row = mean vector of class i
% QDAmodel.Sigmapooled : D*D  covariance 
% QDAmodel.Pi : numofClass *1 vector, Pi(i) = prior probability of class i

% Output:
% Y_predict predicted labels for all the testing data points in X_test

% Write your code here:
h_LDA=zeros(size(X_test,1),numofClass);
invtemp=inv(LDAmodel.Sigmapooled);
for i=1:size(X_test,1)
    for j=1:numofClass
        temp=LDAmodel.Mu(j,:)*invtemp;
        h_LDA(i,j)=temp*X_test(i,:)'-0.5*temp*LDAmodel.Mu(j,:)'+log(LDAmodel.pi(j));  
    end
end
[~,Y_predict]=max(h_LDA,[],2);

end