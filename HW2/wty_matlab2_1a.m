clc;clear;
load('data_SFcrime_train.mat');

% unique(DayOfWeek)'%'Friday'    'Monday'    'Saturday'    'Sunday'    'Thursday'    'Tuesday'    'Wednesday'
% unique(PdDistrict)'%10 kinds
% unique(Category)'%39 kinds
% %Dates{1}%5/13/2015 23:53
Hour = hour(Dates);%unique(Hour)';%0--23
Hour = Hour +1;% 1 stand for 0:00-0:59

N=length(DayOfWeek);
x=sparse(N,41);%x(1,1)
tic
for k=1:24    
     x(:,k)=ismember(Hour, k);  %x(:,k)=(Hour==k-1);
end
%0.117178 seconds. 0.107950 seconds.
dayNameList = {'Sunday', 'Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday' };%dayNameList{1}
for k=25:31    
    x(:,k)=ismember(DayOfWeek, dayNameList{k-24});  
end
PdDistrict_name=unique(PdDistrict);
for k=32:41    
    x(:,k)=ismember(PdDistrict, PdDistrict_name{k-31});  
end

toc

histogram(Hour)
xlabel('Hour: 0--24')
ylabel('number of incidents in every hour')
title('histogram of Hour')

bar(sum(x(:,25:31)));% Friday highest
xlabel(['Sunday', 'Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday'])
ylabel('number of incidents in every day')
title('histogram of DayOfWeek')

bar(sum(x(:,32:41)));% 8th street is highest
xlabel(['PdDistrict'])
ylabel('number of incidents in every PdDistrict')
title('histogram of PdDistrict')
%%
%result2_2a3
CategoryNameList = sort(unique(Category));
y=zeros(length(Category),1);
for k=1:length(unique(Category))
    y=k*ismember(Category, CategoryNameList{k})+y;%unique(y);
end
result2_2a3_all = sparse(y,Hour,ones(length(y),1));%unique(Hour);
[~,result2_2a3]=max(result2_2a3_all,[],2);

%%
%result2_2a4
PdDistrict10=zeros(length(PdDistrict),1);
for k=1:length(unique(PdDistrict))
    PdDistrict10=k*ismember(PdDistrict, PdDistrict_name{k})+PdDistrict10;%unique(y);
end
result2_2a4_all = sparse(PdDistrict10,y,ones(length(PdDistrict10),1));
[~,result2_2a4]=max(result2_2a4_all,[],2);
result2_2a4_name=char(CategoryNameList{result2_2a4});






