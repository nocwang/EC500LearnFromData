%data_circle
[THETA_circle,RHO_circle] = cart2pol(data_circle(:,1),data_circle(:,2));
 THETA_circle = (THETA_circle - min(THETA_circle)) / range(THETA_circle);
  RHO_circle= (RHO_circle - min(RHO_circle)) / range(RHO_circle);
data_circle3=[RHO_circle,THETA_circle];
result4_1ci=zeros(4,6);
for k=2:4
    rng(2); % For reproducibility
    [idx,C,sumd] = kmeans(data_circle3 , k,'Replicates',20,'Distance', 'cityblock');%,'Distance', 'sqeuclidean'
    result4_1ci(1:k,k-1)=sumd;
    if k==2
        subplot(1,3,k-1)
        plot(data_circle3(idx==1,1),data_circle3(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==2,1),data_circle3(idx==2,2),'b.','MarkerSize',12)
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Centroids','Location','northoutside')%,... 'Location','NW'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    elseif k==3
        subplot(1,3,k-1)
        plot(data_circle3(idx==1,1),data_circle3(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==2,1),data_circle3(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==3,1),data_circle3(idx==3,2),'g.','MarkerSize',12)
        hold on
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','northoutside')%,... 'Location','NW'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    else%if k==4
        subplot(1,3,k-1)
        plot(data_circle3(idx==1,1),data_circle3(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==2,1),data_circle3(idx==2,2),'b.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==3,1),data_circle3(idx==3,2),'g.','MarkerSize',12)
        hold on
        plot(data_circle3(idx==4,1),data_circle3(idx==4,2),'k.','MarkerSize',12)
        hold on
        plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
        legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
        title 'Circle Cluster Assignments and Centroids'
        xlabel('x')
        ylabel('y')
    end
end

% %data_spiral
% [THETA_spiral,RHO_spiral] = cart2pol(data_spiral(:,1),data_spiral(:,2));
%  THETA_spiral = (THETA_spiral - min(THETA_spiral)) / range(THETA_spiral);
%   RHO_spiral= (RHO_spiral - min(RHO_spiral)) / range(RHO_spiral);
% data_spiral3=[RHO_spiral,THETA_spiral]; 
% for k=2:4
%     rng(2); % For reproducibility
%     [idx,C,sumd] = kmeans(data_spiral3, k,'Replicates',20,'Distance', 'cityblock');%,'Distance', 'sqeuclidean'
%     result4_1ci(1:k,k+2)=sumd;
%     if k==2
%         subplot(2,3,k+2)
%         plot(data_spiral3(idx==1,1),data_spiral3(idx==1,2),'r.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==2,1),data_spiral3(idx==2,2),'b.','MarkerSize',12)
%         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
%         legend('Cluster 1','Cluster 2','Centroids','Location','northoutside')%,... 'Location','NW'
%         title 'Spiral Cluster Assignments and Centroids'
%         xlabel('x')
%         ylabel('y')
%     elseif k==3
%         subplot(2,3,k+2)
%         plot(data_spiral3(idx==1,1),data_spiral3(idx==1,2),'r.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==2,1),data_spiral3(idx==2,2),'b.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==3,1),data_spiral3(idx==3,2),'g.','MarkerSize',12)
%         hold on
%         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
%         legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','northoutside')%,... 'Location','NW'
%         title 'Spiral Cluster Assignments and Centroids'
%         xlabel('x')
%         ylabel('y')
%     else%if k==4
%         subplot(2,3,k+2)
%         plot(data_spiral3(idx==1,1),data_spiral3(idx==1,2),'r.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==2,1),data_spiral3(idx==2,2),'b.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==3,1),data_spiral3(idx==3,2),'g.','MarkerSize',12)
%         hold on
%         plot(data_spiral3(idx==4,1),data_spiral3(idx==4,2),'k.','MarkerSize',12)
%         hold on
%         plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
%         legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids','Location','northoutside')%,... 'Location','NW' ,'Orientation','horizontal'
%         title 'Spiral Cluster Assignments and Centroids'
%         xlabel('x')
%         ylabel('y')
%     end
% end