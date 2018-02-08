%%
%2.2c(i)cv_ccr
x=(data_train);%full
y=labels_train;
y(labels_train==17)=1;
y(labels_train~=17)=-1;

x_te=(data_test);
y_te=labels_test;
y_te(labels_test==17)=1;
y_te(labels_test~=17)=-1;

% % Precision = TP / (TP+FP)
% % Recall = TP / (TP+FN)
% % Accuracy = (TP + TN) / (TP + TN + FP + FN)
% Precision = true_positive / (true_positive + false_positive)
% Recall = true_positive / (true_positive + false_negative)
% F-score = 2 * Precision * Recall / (Precision + Recall)

tic;
k_folds=5;
cv_ccr=zeros(21,1);cv_precision=zeros(21,1);cv_recall=zeros(21,1);cv_fscore=zeros(21,1);
for logC=-5:15;
    C=2^logC;
    
    cv = cvpartition(y, 'k', k_folds);
    ccr = zeros(k_folds,1);precision= zeros(k_folds,1);recall=zeros(k_folds,1);fscore=zeros(k_folds,1);
    for k = 1:k_folds
        idx_train = cv.training(k);
        idx_test = cv.test(k);
        %% compute the test ccr for the k'th fold
       % idx_train=[1,2,9321];%y((9321))
        SVMStruct = svmtrain(x(idx_train,:),y(idx_train),'autoscale','false','boxconstraint',C,'kernelcachelimit',100000);%,'kernel_function','linear'
%        Error using seqminoptIseqminoptImpl/createKernelCache (line 447)
% Error evaluating kernel function 'Sparse Arrays are not supported. See SPFUN.'.
        y_predict = svmclassify(SVMStruct,x(idx_test,:));
        y_test=y(idx_test);
        ccr(k) =sum(y_predict==y_test)/length(y_test);
        temp=sum(y_predict==1 & y_test==1);%sum(y_predict+y_test==2)
        precision(k)=temp/sum(y_predict==1);
        recall(k)=temp/sum(y_test==1);
        fscore(k)=2 * precision(k) * recall(k) / (precision(k)+recall(k));
    end
    cv_ccr(logC+6) = mean(ccr);
    cv_precision(logC+6) = mean(precision);
    cv_recall(logC+6) = mean(recall);
    cv_fscore(logC+6) = mean(fscore);   
end
runtime = toc;%6s for one C


h=figure;hold on;
plot(-5:15,cv_ccr)
xlabel('log(C)')
ylabel('cv_ccr')
title('matlab2-2cCV-CCR')
figfilename = 'result2_2c_20151102';
saveas(h,figfilename,'jpg');
%%
%2.2c(ii)best C
[~,whichbest]=max(cv_ccr);
bestC=2^(whichbest-6)
%%
%2.2c(iii)best C to all train
SVMStruct = svmtrain(x,y,'kernel_function','linear','autoscale','false','boxconstraint',bestC*ones(length(y),1),'kernelcachelimit',100000);
y_te_predict = svmclassify(SVMStruct,x_te);
ccr_te =sum(y_te_predict==y_te)/length(y_te)%0.7698
%%
%2.2c(iv)confusionmatrix
[CFmat,order] = confusionmat(y_te,y_te_predict);%,'order',[-1,1]

%%
%2.2d(i)
h=figure;hold on;
plot(-5:15,cv_precision);hold on;
plot(-5:15,cv_recall);hold on;
plot(-5:15,cv_fscore);hold on;
xlabel('log(C)')
ylabel('performance metric values')
legend('cv-precision','cv-recall','cv-fscore')
title('performance metric values of matlab2-2cd')
figfilename = 'result2_2d_20151102';
saveas(h,figfilename,'jpg');
%%
%2.2d(ii) recall
[~,whichbest]=max(cv_recall);
bestC_recall=2^(whichbest-6)
SVMStruct = svmtrain(x,y,'kernel_function','linear','autoscale','false','boxconstraint',bestC_recall*ones(length(y),1),'kernelcachelimit',100000);
y_te_predict_recall = svmclassify(SVMStruct,x_te);
[CFmat_recall,order] = confusionmat(y_te,y_te_predict_recall);%,'order',[-1,1]
%2.2d(ii) fscore
[~,whichbest]=max(cv_fscore);
bestC_fscore=2^(whichbest-6)
SVMStruct = svmtrain(x,y,'kernel_function','linear','autoscale','false','boxconstraint',bestC_fscore*ones(length(y),1),'kernelcachelimit',100000);
y_te_predict_fscore = svmclassify(SVMStruct,x_te);
[CFmat_fscore,order] = confusionmat(y_te,y_te_predict_fscore);

save('matlab2_2cd.mat')

