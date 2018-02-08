%%
%%data_circle
% clear;clc;
sigma=0.2;

%D = pdist(X) computes the Euclidean distance between pairs of objects in m-by-n data matrix X. Rows of X correspond to observations, and columns correspond to variables. D is a row vector of length m(m�?)/2
%To save space and computation time, D is formatted as a vector. However, you can convert this vector into a square matrix using the squareform function so that element i, j in the matrix, where i < j, corresponds to the distance between objects i and j in the original data set.
W = squareform(pdist(data_circle));
W = exp(-W.^2 ./ (2*sigma^2));

% calculate degree matrix
degs = sum(W, 2);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
% compute unnormalized Laplacian
L = D - W;
%%
% avoid dividing by zero
degs(degs == 0) = eps;
% calculate inverse of D
Drw = spdiags(1./degs, 0, size(D, 1), size(D, 2));

% calculate normalized Laplacian
Lrw = Drw * L;
%%
degs(degs == 0) = eps;
% calculate D^(-1/2)
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));

% calculate normalized Laplacian
Lsym = Dsym * L * Dsym;

%e = eig(A) returns a column vector containing the eigenvalues of square matrix A.

subplot(2,3,1)
temp=eig(L);temp = sort(temp,'ascend');
plot( temp)
title 'Circle eig L'
xlabel('order of eigenvalues')
ylabel('eigenvalues')
subplot(2,3,2)
temp=eig(Lrw);temp = sort(temp,'ascend');
plot( temp)
title 'Circle eig Lrw'
xlabel('order of eigenvalues')
ylabel('eigenvalues')
subplot(2,3,3)
temp=eig(Lsym);temp = sort(temp,'ascend');
plot( temp)
title 'Circle eig Lsym'
xlabel('order of eigenvalues')
ylabel('eigenvalues')

%%
W = squareform(pdist(data_spiral));
W = exp(-W.^2 ./ (2*sigma^2));
% calculate degree matrix
degs = sum(W, 2);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
% compute unnormalized Laplacian
L = D - W;
% avoid dividing by zero
degs(degs == 0) = eps;
% calculate inverse of D
Drw = spdiags(1./degs, 0, size(D, 1), size(D, 2));
% calculate normalized Laplacian
Lrw = Drw * L;
% calculate D^(-1/2)
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));
% calculate normalized Laplacian
Lsym = Dsym * L * Dsym;

subplot(2,3,4)
temp=eig(L);temp = sort(temp,'ascend');
plot( temp)
title 'spiral eig L'
xlabel('order of eigenvalues')
ylabel('eigenvalues')
subplot(2,3,5)
temp=eig(Lrw);temp = sort(temp,'ascend');
plot( temp)
title 'spiral eig Lrw'
xlabel('order of eigenvalues')
ylabel('eigenvalues')
subplot(2,3,6)
temp=eig(Lsym);temp = sort(temp,'ascend');
plot( temp)
title 'spiral eig Lsym'
xlabel('order of eigenvalues')
ylabel('eigenvalues')

%%
%4.1(b)ii
%%data_circle
W = squareform(pdist(data_circle));
W = exp(-W.^2 ./ (2*sigma^2));
degs = sum(W, 2);%sum(W, 1);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
L = D - W;% compute unnormalized Laplacian
degs(degs == 0) = eps;% avoid dividing by zero
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));% calculate D^(-1/2)
Lsym = Dsym * L * Dsym;


%result4_1bii=zeros(4,6);
[U_circle, D_circle] = eigs(Lsym, 4,'sm');%Smallest magnitude. Same as sigma = 0. If A is a function, Afun must return Y = A\x.

for k=2:4
    temp=U_circle(:,1:k);
    Uk = bsxfun(@rdivide, temp, sqrt(sum(temp.^2, 2)));%normalize the eigenvectors row-wise
    rng(2); % For reproducibility
    [idx,C,sumd] = kmeans(Uk, k,'Replicates',20);%,'Distance', 'sqeuclidean'
    %result4_1bii(1:k,k-1)=sumd;
    if k==2
        subplot(2,3,k-1)
        plot(data_circle(idx==1,1),data_circle(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle(idx==2,1),data_circle(idx==2,2),'b.','MarkerSize',12)
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Location','northoutside')%,... 'Location','NW'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    elseif k==3
        subplot(2,3,k-1)
        plot(data_circle(idx==1,1),data_circle(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle(idx==2,1),data_circle(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_circle(idx==3,1),data_circle(idx==3,2),'g.','MarkerSize',12)
        hold on
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Location','northoutside')%,... 'Location','NW'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    else%if k==4
        subplot(2,3,k-1)
        plot(data_circle(idx==1,1),data_circle(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle(idx==2,1),data_circle(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_circle(idx==3,1),data_circle(idx==3,2),'g.','MarkerSize',12)
        hold on
        plot(data_circle(idx==4,1),data_circle(idx==4,2),'k.','MarkerSize',12)
        hold on
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    end
end

%%
%data_spiral
W = squareform(pdist(data_spiral));
W = exp(-W.^2 ./ (2*sigma^2));
degs = sum(W, 2);%sum(W, 1);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
L = D - W;% compute unnormalized Laplacian
degs(degs == 0) = eps;% avoid dividing by zero
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));% calculate D^(-1/2)
Lsym = Dsym * L * Dsym;

[U_spiral, DD] = eigs(Lsym, 4,'sm');%Smallest magnitude. Same as sigma = 0. If A is a function, Afun must return Y = A\x.

for k=2:4
    temp=U_spiral(:,1:k);
    Uk = bsxfun(@rdivide, temp, sqrt(sum(temp.^2, 2)));%normalize the eigenvectors row-wise
    rng(2); % For reproducibility
    [idx,C,sumd] = kmeans(Uk, k,'Replicates',20);%,'Distance', 'sqeuclidean'
    %result4_1bii(1:k,k-1)=sumd;
    if k==2
        subplot(2,3,k+2)
        plot(data_spiral(idx==1,1),data_spiral(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==2,1),data_spiral(idx==2,2),'b.','MarkerSize',12)
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Location','northoutside')%,... 'Location','NW'
        title 'Spiral Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    elseif k==3
        subplot(2,3,k+2)
        plot(data_spiral(idx==1,1),data_spiral(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==2,1),data_spiral(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==3,1),data_spiral(idx==3,2),'g.','MarkerSize',12)
        hold on
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Location','northoutside')%,... 'Location','NW'
        title 'Spiral Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    else%if k==4
        subplot(2,3,k+2)
        plot(data_spiral(idx==1,1),data_spiral(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==2,1),data_spiral(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==3,1),data_spiral(idx==3,2),'g.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==4,1),data_spiral(idx==4,2),'k.','MarkerSize',12)
        hold on
        %         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
        title 'Spiral Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    end
end


%%

%4.1(b)iii
%%data_circle
k=3;
W = squareform(pdist(data_circle));
W = exp(-W.^2 ./ (2*sigma^2));
degs = sum(W, 2);%sum(W, 1);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
L = D - W;% compute unnormalized Laplacian
degs(degs == 0) = eps;% avoid dividing by zero

Drw = spdiags(1./degs, 0, size(D, 1), size(D, 2));% calculate inverse of D
Lrw = Drw * L;% calculate normalized Laplacian
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));% calculate D^(-1/2)
Lsym = Dsym * L * Dsym;

[U_circle, ~] = eigs(L, k,'sm');%D_circle
[Urw_circle, ~] = eigs(Lrw, k,'sm');
[Usym_circle, ~] = eigs(Lsym, k,'sm');%Smallest magnitude. Same as sigma = 0. If A is a function, Afun must return Y = A\x.

% U_circle = bsxfun(@rdivide, U_circle, sqrt(sum(U_circle.^2, 2)));%normalize the eigenvectors row-wise
% Urw_circle = bsxfun(@rdivide, Urw_circle, sqrt(sum(Urw_circle.^2, 2)));
Usym_circle = bsxfun(@rdivide, Usym_circle, sqrt(sum(Usym_circle.^2, 2)));
rng(2); % For reproducibility
idx_circle = kmeans(U_circle, k,'Replicates',20);%   [idx_circle,C,sumd]
rng(2);
idxrw_circle= kmeans(Urw_circle, k,'Replicates',20);%    [idxrw_circle,C,sumd]
rng(2);
idxsym_circle = kmeans(Usym_circle, k,'Replicates',20);%       [idxsym_circle,C,sumd]
%rbg plot3 red, blue, and green
%colorrbg=cell(3,1); colorrbg(1)='red'; colorrbg{2}=blue; colorrbg{3}=green;
colorrbg=['red  ';'blue ';'green'];
%C = cellstr(colorrbg);
C =eye(3);
subplot(2,3,1)
for k=1:3
    h=plot3(U_circle(idx_circle==k,1),U_circle(idx_circle==k,2),U_circle(idx_circle==k,3));%,'r'
    h.Color = C(k,:);%'red';
    hold on
end
 grid on%axis tight,
legend('Cluster 1 in D1','Cluster 2','Cluster 3','Location','northoutside')

% h=plot3(lat,lon,lat+1);
%   h.Color = C(k);
subplot(2,3,2)
for k=1:3
    h=plot3(Urw_circle(idxrw_circle==k,1),Urw_circle(idxrw_circle==k,2),Urw_circle(idxrw_circle==k,3));
    h.Color = C(k,:);
    hold on
end
grid on
legend('Cluster 1 in D1','Cluster 2','Cluster 3','Location','northoutside')

subplot(2,3,3)
for k=1:3
    h=plot3(Usym_circle(idxsym_circle==k,1),Usym_circle(idxsym_circle==k,2),Usym_circle(idxsym_circle==k,3));
    h.Color = C(k,:);
    hold on
end
grid on
legend('Cluster 1 in D1','Cluster 2','Cluster 3','Location','northoutside')%

%data_spiral
k=3;
W = squareform(pdist(data_spiral));
W = exp(-W.^2 ./ (2*sigma^2));
degs = sum(W, 2);%sum(W, 1);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
L = D - W;% compute unnormalized Laplacian
degs(degs == 0) = eps;% avoid dividing by zero

Drw = spdiags(1./degs, 0, size(D, 1), size(D, 2));% calculate inverse of D
Lrw = Drw * L;% calculate normalized Laplacian
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));% calculate D^(-1/2)
Lsym = Dsym * L * Dsym;

[U_spiral, ~] = eigs(L, k,'sm');%D_spiral
[Urw_spiral, ~] = eigs(Lrw, k,'sm');
[Usym_spiral, ~] = eigs(Lsym, k,'sm');%Smallest magnitude. Same as sigma = 0. If A is a function, Afun must return Y = A\x.

% U_spiral = bsxfun(@rdivide, U_spiral, sqrt(sum(U_spiral.^2, 2)));%normalize the eigenvectors row-wise
% Urw_spiral = bsxfun(@rdivide, Urw_spiral, sqrt(sum(Urw_spiral.^2, 2)));
Usym_spiral = bsxfun(@rdivide, Usym_spiral, sqrt(sum(Usym_spiral.^2, 2)));
rng(2); % For reproducibility
idx_spiral = kmeans(U_spiral, k,'Replicates',20);%   [idx_spiral,C,sumd]
rng(2);
idxrw_spiral= kmeans(Urw_spiral, k,'Replicates',20);%    [idxrw_spiral,C,sumd]
rng(2);
idxsym_spiral = kmeans(Usym_spiral, k,'Replicates',20);%       [idxsym_spiral,C,sumd]
% %rbg plot3
% subplot(2,3,4)
% plot3(U_spiral(idx_spiral,1),U_spiral(idx_spiral,2),U_spiral(idx_spiral,3))
% subplot(2,3,5)
% plot3(Urw_spiral(idxrw_spiral,1),Urw_spiral(idxrw_spiral,2),Urw_spiral(idxrw_spiral,3))
% subplot(2,3,6)
% plot3(Usym_spiral(idxsym_spiral,1),Usym_spiral(idxsym_spiral,2),Usym_spiral(idxsym_spiral,3))

subplot(2,3,4)
for k=1:3
    h=plot3(U_spiral(idx_spiral==k,1),U_spiral(idx_spiral==k,2),U_spiral(idx_spiral==k,3));%,'r'
    h.Color = C(k,:);
    hold on
end
grid on
legend('Cluster 1 in D2','Cluster 2','Cluster 3','Location','northoutside')

% h=plot3(lat,lon,lat+1);
%   h.Color = C(k);
subplot(2,3,5)
for k=1:3
    h=plot3(Urw_spiral(idxrw_spiral==k,1),Urw_spiral(idxrw_spiral==k,2),Urw_spiral(idxrw_spiral==k,3));
    h.Color = C(k,:);
    hold on
end
grid on
legend('Cluster 1 in D2','Cluster 2','Cluster 3','Location','northoutside')

subplot(2,3,6)
for k=1:3
    h=plot3(Usym_spiral(idxsym_spiral==k,1),Usym_spiral(idxsym_spiral==k,2),Usym_spiral(idxsym_spiral==k,3));
    h.Color = C(k,:);
    hold on
end
grid on
legend('Cluster 1 in D2','Cluster 2','Cluster 3','Location','northoutside')