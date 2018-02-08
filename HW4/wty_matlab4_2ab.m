%%BostonListing
clear;clc;
load BostonListing.mat

sigma=0.01;
data_Boston=[latitude,longitude];
name=unique(neighbourhood);
y=zeros(2558,1);
for k=1:length(name)
    y(ismember(neighbourhood,name{k}))=k;
end
W = squareform(pdist(data_Boston));
W = exp(-W.^2 ./ (2*sigma^2));
degs = sum(W, 2);%sum(W, 1);
D    = sparse(1:size(W, 1), 1:size(W, 2), degs);
L = D - W;% compute unnormalized Laplacian
degs(degs == 0) = eps;% avoid dividing by zero
Dsym = spdiags(1./(degs.^0.5), 0, size(D, 1), size(D, 2));% calculate D^(-1/2)
Lsym = Dsym * L * Dsym;


%result4_1bii=zeros(4,6);
[U, DD] = eigs(Lsym, 25,'sm');%Smallest magnitude. Same as sigma = 0. If A is a function, Afun must return Y = A\x.
purity=zeros(25,1);
idx=zeros(2558,1);
idx5=idx;
for k=1:25
    temp=U(:,1:k);
    Uk = bsxfun(@rdivide, temp, sqrt(sum(temp.^2, 2)));%normalize the eigenvectors row-wise
    rng(2); % For reproducibility
    idx = kmeans(Uk, k,'Replicates',20);
    if k==5
        idx5=idx;
    end
    N=confusionmat(idx,y);
    %temp=max(N,[],2);
    purity(k)=sum(max(N,[],2))/2558;%?
end
plot(1:25,purity)
xlabel('1:25')
ylabel('purity')
title('purity of SC3 from 1 to 25 clusters using BostonListing')


%%
%4.2b
for k=1:5
    scatter(longitude(idx5==k),latitude(idx5==k))%,'.r','MarkerSize',20   plot
    hold on
end
title('k=5 clusters of SC3 using BostonListing')

plot_google_map