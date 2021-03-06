function CAIDs = get_coauthors(GSID)
% Given a Google Scholar ID, return Google Scholar IDs of listed co-authors
% For example: oa = get_coauthors('wDjD46gAAAAJ')

if nargin == 0
    GSID = 'wDjD46gAAAAJ';
end

str = urlread(['http://scholar.google.com/citations?view_op=list_colleagues&user=' GSID]);
pat = '?user=.......AAAAJ';

S = regexp(str,pat);
if length(S) > 1
    %S = S(2:end);
    
    for i = 1:length(S)
        CAIDs{i,1} = str(S(i)+6:S(i)+17);
    end
else
    CAIDs = [];
end

