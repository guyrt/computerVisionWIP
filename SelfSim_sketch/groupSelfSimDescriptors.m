function [groupings gHistory mGrouping] = groupSelfSimDescriptors(imageResp, selfCorrelations, limit)

% Group self sim descriptor scores by their similarity.
% Uses algorithm from FOO

if nargin == 2
   limit = 1000; 
end

selfCorrelations = selfCorrelations - diag(selfCorrelations(1,1)*ones(size(selfCorrelations,1),1));

groupings = (1:length(selfCorrelations))';

selfCorrelationsCp = selfCorrelations(:);

gHistory = ones(length(groupings),limit);
mGrouping = zeros(1,limit);

for i=1:limit
   
   [m idx] = max(selfCorrelationsCp); 
   if m == -1
       break
   end
   mGrouping(i) = m;
   i1 = mod(idx,length(selfCorrelations));
   i2 = 1+floor(idx / length(selfCorrelations));
   
   m1 = groupings(i1);
   m2 = groupings(i2);
   groupings(i1) = min(m1,m2);
   groupings(i2) = min(m1,m2);
   selfCorrelationsCp(idx) = -1;
   gHistory(:,i) = groupings;
   
end