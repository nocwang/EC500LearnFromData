clc;clear;
num_cluster=3;
points_per_cluster=500*ones(num_cluster,1);
[data_circle ,label_circle] = sample_circle( num_cluster, points_per_cluster );
[data_spiral, label_spiral] = sample_spiral(num_cluster, points_per_cluster);
%[idx,C,sumd] = kmeans(___) returns the within-cluster sums of point-to-centroid distances in the k-by-1 vector sumd.

result4_1aii=zeros(4,6);
for k=2:4
    rng(2); % For reproducibility
    [idx,C,sumd] = kmeans(data_circle, k,'Replicates',20,'Distance', 'sqeuclidean');%,'Distance', 'sqeuclidean'
    result4_1aii(1:k,k-1)=sumd;
    if k==2
        subplot(2,3,k-1)
        plot(data_circle(idx==1,1),data_circle(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle(idx==2,1),data_circle(idx==2,2),'b.','MarkerSize',12)
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Centroids','Location','northoutside')%,... 'Location','NW'
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
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','northoutside')%,... 'Location','NW'
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
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    end
end

for k=2:4
    rng(2); % For reproducibility
    [idx,C,sumd] = kmeans(data_spiral, k,'Replicates',20,'Distance', 'sqeuclidean');%,'Distance', 'sqeuclidean'
    result4_1aii(1:k,k+2)=sumd;
    if k==2
        subplot(2,3,k+2)
        plot(data_spiral(idx==1,1),data_spiral(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_spiral(idx==2,1),data_spiral(idx==2,2),'b.','MarkerSize',12)
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Centroids','Location','northoutside')%,... 'Location','NW'
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
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','northoutside')%,... 'Location','NW'
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
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
        title 'Spiral Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    end
end