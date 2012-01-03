function [classVector vecHistory] = groupByClass(simMatrix, classVector, mergeThresh)

%%
% Cluster the self-similarity matrix by repeatedly grabbing clusters with
% the largest average similarity scores. See Agarwal et. al. for details.
%
% Input: 
%   simMatrix: N x 1 vector of patch similiarity scores.
%   classVector: N x 1 vector of current class scores
%
% Return:
%   classSimMatrix: Matrix of classes
%   classVector: Vector of class names.
%
% Author: Richard T. Guy
%

if nargin == 2
    mergeThresh = 0;
end

oldCV = classVector;
vecHistory = classVector(:);
while 1
    classVector = innerGroupByClass(simMatrix, classVector, mergeThresh);
    vecHistory = [vecHistory classVector'];
    
    if max(abs(classVector-oldCV)) == 0
       break;  % leave loop.
    end
    oldCV = classVector;
end

end % fxn

function classVector = innerGroupByClass(simMatrix, classVector, mergeThresh)

uniqueClasses = unique(classVector);
classSimMatrix = zeros(length(uniqueClasses));
classSimCount = zeros(length(uniqueClasses));
 
for i=1:length(uniqueClasses)
    c1 = uniqueClasses(i);
    c1Set = classVector == c1;
    for j = i+1:length(uniqueClasses)
        c2 = uniqueClasses(j);
        c2Set = classVector == c2;
        m = simMatrix(c1Set,c2Set);
        
        classSimMatrix(i,j) = classSimMatrix(i,j) + sum(m(:));
        classSimCount(i,j) = classSimMatrix(j,i) + length(m);
    end
end

classSimMatrix = classSimMatrix ./ (classSimCount);
classSimMatrix = triu(classSimMatrix,1);

[m mi] = max(classSimMatrix(:));
if m > mergeThresh
    [i j] = ind2sub( size(classSimMatrix), mi );

    clsInd = [find(classVector == uniqueClasses(i)) find(classVector==uniqueClasses(j))];
    
    classVector(clsInd) = min(classVector([i j]));
end

end
