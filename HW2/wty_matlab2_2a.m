clc;clear;
words=textread('data/vocabulary.txt','%s');
newsgroup_names=textread('data/newsgrouplabels.txt','%s');
labels_train=textread('data/train.label','%d');
labels_test=textread('data/test.label','%d');

stoplist=textread('data/stoplist.txt', '%s');
%vocabulary=textread('data/vocabulary.txt', '%s');
stop_id=find(ismember(words,stoplist)==1);%490
%words(stop_id)=[];

tic
data_train=read_docs('data/train.data',numel(labels_train),numel(words),stop_id);
data_test=read_docs('data/test.data',numel(labels_test),numel(words),stop_id);
toc% 67.056643 seconds.
% data_train=data_train./repmat(temp,1,size(data_train,2));
% data_test=data_test./repmat(sum(data_test,2),1,size(data_test,2));



data_train(:,stop_id)=[];data_test(:,stop_id)=[];%60698
%%
%slow;so make it at "read_docs"
% temp=(sum(data_train,2));
% tic
% for k=1%:size(data_train,1)
%     data_train(k,:)=data_train(k,:)/temp(k);
% end
% toc
% temp2=(sum(data_test,2));
% for k=1:size(data_test,1)
%     data_test(k,:)=data_test(k,:)/temp2(k);
% end
%%
%2.2a(i)cv_ccr
labels_train_1or20=(labels_train==1 | labels_train==20);
x=data_train(labels_train_1or20,:);%x(1,:);
y=labels_train(labels_train_1or20);
labels_test_1or20=(labels_test==1 | labels_test==20);
x_te=data_test(labels_test_1or20,:);
y_te=labels_test(labels_test_1or20);


tic;
k_folds=5;
cv_ccr=zeros(21,1);
for logC=-5:15;
    C=2.^logC;
    
    cv = cvpartition(y, 'k', k_folds);
    ccr = zeros(k_folds,1);
    for k = 1:k_folds
        idx_train = cv.training(k);
        idx_test = cv.test(k);
        % compute the test ccr for the k'th fold
        SVMStruct = svmtrain(x(idx_train,:),y(idx_train),'autoscale','false','boxconstraint',C*ones(length(y(idx_train)),1));%,'kernel_function','linear'
        y_predict = svmclassify(SVMStruct,x(idx_test,:));
        ccr(k) =sum(y_predict==y(idx_test))/length(y(idx_test));
    end
    cv_ccr(logC+6) = mean(ccr);
    % svmStruct = svmtrain(data_train(labels_train_1or20,:),labels_train(labels_train_1or20),'kernel_function','linear','autoscale','false','boxconstraint',C*ones(numel(labels_train(labels_train_1or20)),1));
    
end
runtime = toc;%6s for one C

h=figure;hold on;
plot(-5:15,cv_ccr)
xlabel('log(C)')
ylabel('cv_ccr')
title('matlab2-2aCV-CCR')
figfilename = 'result2_2a_20151030';
saveas(h,figfilename,'jpg');
%%
%2.2a(ii)best C
[~,whichbest]=max(cv_ccr);
bestC=2^(whichbest-6)%128
%%
%2.2a(iii)best C to all train
SVMStruct = svmtrain(x,y,'kernel_function','linear','autoscale','false','boxconstraint',bestC*ones(length(y),1));
y_te_predict = svmclassify(SVMStruct,x_te);
ccr_te =sum(y_te_predict==y_te)/length(y_te)%0.7698

save('matlab2_2a_result.mat')%dataafternorm





