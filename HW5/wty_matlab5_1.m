clear;clc;
%5-1-a
load('helix.mat') %Useful MATLAB functions: scatter3, grid on view([12 20]).

%scatter3(X,Y,Z) displays circles at the locations specified by the vectors X, Y, and Z.

scatter3(X(1,:),X(2,:),X(3,:),ones(size(X,2), 1)*20,tt)
grid on
view([12 20])
title('5-1-a-helix')



load('swiss.mat')
scatter3(X(1,:),X(2,:),X(3,:),ones(size(X,2), 1)*20,tt)
grid on
view([12 20])
title('5-1-a-swiss')

%5-1-b
load('helix.mat')
sigma=4;
n=700;
H=eye(n)-1/n*ones(n,1)*ones(1,n);

linear=X'*X;linearK=H*linear*H;
ployK=linear.^3;ployK=H*ployK*H;
rbf = squareform(pdist(X'));
rbf = exp(-rbf.^2 ./ (2*sigma^2));rbf=H*rbf*H;

subplot(2,3,1)
rng('default')
[U, DD] = eigs(linearK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-helix-linearKernel')

subplot(2,3,2)
rng('default')
[U, DD] = eigs(ployK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-helix-ployKernel')


subplot(2,3,3)
rng('default')
[U, DD] = eigs(rbf, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-helix-rbf')


load('swiss.mat')
linear=X'*X;linearK=H*linear*H;
ployK=linear.^3;ployK=H*ployK*H;
rbf = squareform(pdist(X'));
rbf = exp(-rbf.^2 ./ (2*sigma^2));rbf=H*rbf*H;

subplot(2,3,4)
rng('default')
[U, DD] = eigs(linearK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-swiss-linearKernel')

subplot(2,3,5)
rng('default')
[U, DD] = eigs(ployK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-swiss-ployKernel')


subplot(2,3,6)
rng('default')
[U, DD] = eigs(rbf, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-b-swiss-rbf')


%5-1-d
k=7;

load('helix.mat')

euclidean = squareform(pdist(X'));
knn_graph=sparse(700,700);%full(knn_graph);
for m=1:700
    [d,ind] = sort(euclidean(m,:));
    ind_closest = ind(1:k);
    knn_graph(m,ind_closest) = euclidean(m,ind_closest);
end


knn_graph=max(knn_graph,knn_graph');% max(ones(2,2),2*ones(2,2))

% [i,j]=find(knn_graph>0);
% plot3([X(1,i),X(1,j)],[X(2,i),X(2,j)] ,[X(3,i),X(3,j)])
for i=1:700
    for j=i+1:700
           if     knn_graph(i,j)>0
       plot3([X(1,i),X(1,j)],[X(2,i),X(2,j)] ,[X(3,i),X(3,j)]);hold on;
           end
%         knn_graph(i,j)=max(knn_graph(i,j),knn_graph(j,i));
%         knn_graph(j,i)=knn_graph(i,j);
    end
end
title('5-1-d-helix-7NN graph')

tic
D = dijkstra( knn_graph , 1:700 );
toc%Elapsed time is 30.962972 seconds.
%isequal(D,D')%0
D =(D +D')/2;
D =D.^2;
n=700;
H=eye(n)-1/n*ones(n,1)*ones(1,n);
Kisomap=-0.5*H*D*H;

linearK=H*Kisomap*H;
rng('default')
[U, DD] = eigs(linearK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-d-helix-isomapKernel')





load('swiss.mat')
euclidean = squareform(pdist(X'));
knn_graph=sparse(700,700);%full(knn_graph);
for m=1:700
    [d,ind] = sort(euclidean(m,:));
    ind_closest = ind(1:k);
    knn_graph(m,ind_closest) = euclidean(m,ind_closest);
end


knn_graph=max(knn_graph,knn_graph');% max(ones(2,2),2*ones(2,2))

% [i,j]=find(knn_graph>0);
% plot3([X(1,i),X(1,j)],[X(2,i),X(2,j)] ,[X(3,i),X(3,j)])
for i=1:700
    for j=i+1:700
           if     knn_graph(i,j)>0
       plot3([X(1,i),X(1,j)],[X(2,i),X(2,j)] ,[X(3,i),X(3,j)]);hold on;
           end
%         knn_graph(i,j)=max(knn_graph(i,j),knn_graph(j,i));
%         knn_graph(j,i)=knn_graph(i,j);
    end
end
title('5-1-d-swiss-7NN graph')

tic
D = dijkstra( knn_graph , 1:700 );
toc%Elapsed time is 30.962972 seconds.
%isequal(D,D')%0
D =(D +D')/2;
D =D.^2;
n=700;
H=eye(n)-1/n*ones(n,1)*ones(1,n);
Kisomap=-0.5*H*D*H;

linearK=H*Kisomap*H;
rng('default')
[U, DD] = eigs(linearK, 2);
X_linearK=sqrt(DD)*U';
scatter(X_linearK(1,:),X_linearK(2,:),[],tt)
title('5-1-d-swiss-isomapKernel')

