%Problem 3.1 Exploring Boston Housing Data with Regression Trees
%unique(Xtrain(:,4));%0 1 unique(Xtrain(:,9)); 1--8,24
clear;clc;
load('housing_data.mat')
tree = fitrtree(Xtrain,ytrain,'categoricalpredictors',[4 9],'MinLeafSize',20,'PredictorNames',feature_names)

%view(tree)
view(tree, 'mode','graph')
inst = [5,18,2.31,1,0.5440,2,64,3.7,1,300,15,390,10];
matlab3_1b = predict(tree,inst)

perf_tr=zeros(25,1);perf_te=zeros(25,1);
for k=1:25
    trees = fitrtree(Xtrain,ytrain,'categoricalpredictors',[4 9],'MinLeafSize',k,'PredictorNames',feature_names);
    ytr_pre=predict(trees,Xtrain);
    yte_pre=predict(trees,Xtest);
    perf_tr(k) = mae(ytr_pre-ytrain);
    %mae is a network performance function. It measures network performance as the mean of absolute errors.
    perf_te(k) = mae(yte_pre-ytest);
end
plot(1:25,perf_tr);hold on;
plot(1:25,perf_te);hold on;
title('matlab3-1c')
xlabel('the minimum observations per leaf ranging from 1 to 25');
ylabel('mean absolute error (MAE) of the training and testing data');
legend('train','test')
save('wty_matlab3_1.mat')
%%
%method 2 to plot
%tree2 = classregtree(Xtrain,ytrain,'categorical',[4 9],'minleaf',20,'names',feature_names)
%view(tree2)
%  tree2([5,18,2.31,1,0.5440,2,64,3.7,1,300,15,390,10])%  22.0476
%eval(tree2,inst)    22.0476
x=0:0.1:4;
plot(x,exp(x)-x)
exp(pi)-pi




