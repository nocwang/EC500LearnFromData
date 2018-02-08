function counts=read_docs(fname,ndocs,nwords,stop_id)
[docid wordid counts]=textread(fname,'%d %d %d');%fname='data/test.data'
tempid=(ismember(wordid,stop_id));
docid(tempid)=[];wordid(tempid)=[];counts(tempid)=[];
S= sparse(docid,ones(length(docid),1),counts);
sumofw_indoc=zeros(length(docid),1);
%tic
for j=1:length(S)
    %counts(docid==j)=counts(docid==j)/S(j);
    sumofw_indoc(docid==j)=S(j);
end
%toc
counts=counts./sumofw_indoc;
counts=sparse(docid, wordid, counts, ndocs, nwords);%max( wordid)
end