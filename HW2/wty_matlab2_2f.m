%
% x=data_train;
% y=labels_train;
x_te=data_test;
y_te=labels_test;

x=cell(20,1);y=cell(20,1);
for k=1:20
    x{k}=data_train(labels_train==k,:);%x{k};unique(labels_train);[x{i};x{j}];
    y{k}=labels_train(labels_train==k,:);
end

tic
y_ij=sparse(size(x_te,1),1);
 counts=sparse(size(x_te,1),20);
for i=1:19
    for j=i+1:20
        SVMStruct = svmtrain([x{i};x{j}],[y{i};y{j}],'kernel_function','rbf','autoscale','false');%
        y_ij= svmclassify(SVMStruct,x_te);
        counts(:,i)=(y_ij==i)+counts(:,i);
        counts(:,j)=(y_ij==j)+counts(:,j);
    end
end
runtime=toc%  'autoscale','false' 387.0257

[~,y_predict] = max(counts,[],2);
CF=confusionmat(y_te,y_predict,'order',1:20);
ccr=sum(diag(CF))/sum(sum(CF))%'autoscale','false'  0.3139
fprintf('SVM (1-against-1):\naccuracy = %.4f\n', ccr);
fprintf('Confusion Matrix:\n'), disp(CF)
save('matlab2_2f_20151031.mat')