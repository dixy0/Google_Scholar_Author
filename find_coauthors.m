clear

startID = 'wDjD46gAAAAJ';
searchID{1} = startID;
allID = startID;

%cite_mtx = 0;
sp_from = [];
sp_to = [];

% search up to n layers
n = 3;
for layeri = 1:n
    fprintf('Start searching co-authors. Level %d: ',layeri);
    
    newsearchID = [];
    
    for searchi = 1:length(searchID)
        getID = get_coauthors(searchID{searchi});
        
        if isempty(getID)
            continue
        else
            isin = ismember(getID,allID);
            newID = getID(find(isin==0));
            allID = [allID; newID];
            newsearchID = [newsearchID; newID];
            
            for citei = 1:length(getID)
                sp_from = [sp_from; find(strcmp(allID, searchID{searchi}))];
                sp_to = [sp_to; find(strcmp(allID, getID{citei}))];
            end
        end
    end
    
    searchID = newsearchID;
    fprintf('%d new co-authors \n',length(newsearchID));
end

S = sparse(sp_from,sp_to,1,length(allID),length(allID)) ;
writetoPAJ(S(1:616,1:616),'CiteNet616',1)
cite_mtx = S(1:616,1:616);

