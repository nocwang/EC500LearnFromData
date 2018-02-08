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
 counts=sparse(size(x_te,1),20);
 y_ij=sparse(size(x_te,1),1);
for i=1:19
    for j=i+1:20
        SVMStruct = svmtrain([x{i};x{j}],[y{i};y{j}],'autoscale','false');%,'kernel_function','linear'????????????
%        SVMStruct = svmtrain([x{i},x{j}],[y{i},y{j}],'autoscale','false','kernel_function','rbf');%????????????
        y_ij= svmclassify(SVMStruct,x_te);
        counts(:,i)=(y_ij==i)+counts(:,i);
        counts(:,j)=(y_ij==j)+counts(:,j);
    end
end
runtime=toc% 181.0199

[~,y_predict] = max(counts,[],2);
CF=confusionmat(y_te,y_predict,'order',1:20);
ccr=sum(diag(CF))/sum(sum(CF))%0.3087
CF_display=zeros(21,21);
%CF_display(1,1)=[];
CF_display(2:21,2:21)=CF;
CF_display(1,2:21)=1:20;
CF_display(2:21,1)=1:20';
save('matlab2_2e_20151031.mat')