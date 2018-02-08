%%
%2.2b(i)cv_ccr
labels_train_1or20=(labels_train==1 | labels_train==20);
x=data_train(labels_train_1or20,:);
y=labels_train(labels_train_1or20);
labels_test_1or20=(labels_test==1 | labels_test==20);
x_te=data_test(labels_test_1or20,:);
y_te=labels_test(labels_test_1or20);

tic;
k_folds=5;
cv_ccr=zeros(21,17);

for logSIGMA=-13:3;
    SIGMA=2^logSIGMA;
    for logC=-5:15;
        C=2^logC;

        cv = cvpartition(y, 'k', k_folds);
        ccr = zeros(k_folds,1);
        for k = 1:k_folds
            idx_train = cv.training(k);
            idx_test = cv.test(k);
            % compute the test ccr for the k'th fold
            SVMStruct = svmtrain(x(idx_train,:),y(idx_train),'kernel_function','rbf','autoscale','false','boxconstraint',C*ones(length(y(idx_train)),1),'rbf_sigma',SIGMA);
            y_predict = svmclassify(SVMStruct,x(idx_test,:));
            ccr(k) =sum(y_predict==y(idx_test))/length(y(idx_test));
        end
        cv_ccr(logC+6,logSIGMA+14) = mean(ccr);%cv_ccr(10)
        % svmStruct = svmtrain(data_train(labels_train_1or20,:),labels_train(labels_train_1or20),'kernel_function','linear','autoscale','false','boxconstraint',C*ones(numel(labels_train(labels_train_1or20)),1));
    end
end
runtime = toc;
%6s for one C





%%
%2.2a(ii)best C
[maxval maxloc] = max(cv_ccr(:));% 0.7301==  cv_ccr(maxloc)
[maxloc_row maxloc_col] = ind2sub(size(cv_ccr), maxloc)%10th row 12th column
%[maxloc_row2 maxloc_col2] =  ind2sub(size(cv_ccr2), maxloc)
%[whichbesti,whichbestj]=find(cv_ccr==max(max(cv_ccr)));

bestC=2^(maxloc_row-6)%16
bestSIGMA=2^(maxloc_col-14)%0.2500

%%
%2.2b(i)
figfilename = 'matlab2_2b_plot_20151030';h=figure; hold on;
plotx=-13:3;
ploty=-5:15;
[plotX,plotY] = meshgrid(plotx,ploty);
%cv_ccr2=reshape(cv_ccr,size(plotX));
contour(plotX,plotY, cv_ccr)%,20
colorbar
xlabel('log(SIGMA)');ylabel('log(C)');title('Cross-Validation Accuracy');
hold on
plot(maxloc_col-14,maxloc_row-6, 'rx')
text(maxloc_col-14,maxloc_row-6, sprintf('cv-ccr = %.2f %%',maxval), ...
    'HorizontalAlign','right', 'VerticalAlign','top')
hold off
saveas(h,figfilename,'jpg');



%%
%2.2a(iii)bestC bestSIGMA to all train
SVMStruct = svmtrain(x,y,'kernel_function','rbf','autoscale','false','boxconstraint',bestC*ones(length(y),1),'rbf_sigma',bestSIGMA);
y_te_predict = svmclassify(SVMStruct,x_te);
ccr_te =sum(y_te_predict==y_te)/length(y_te)%  0.8172

save('matlab2_2b_result.mat')%delete old matlab2_2b.mat