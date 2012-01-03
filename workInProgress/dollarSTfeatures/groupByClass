function [classSimMatrix classVector] = sumByClass(simMatrix, classVector)

%%
% Cluster the self-similarity matrix into clusters.
%
% Input: 
%   simMatrix: N x N symmetric matrix of similarities.
%
% Return:
%   classSimMatrix: Matrix of classes
%   classVector: Vector of class names.
%
% Author: Richard T. Guy
%

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
        classSimCount(i,j) = classSimMatrix(j,i) + 1;
    end
end

classSimMatrix = classSimMatrix ./ (classSimCount);
classSimMatrix = triu(classSimMatrix,1);

[m mi] = max(classSimMatrix(:));
[i j] = ind2sub( size(classSimMatrix), mi );

classVector([i j]) = min(classVector([i j]));
classSimMatrix(i,j) = classSimMatrix(i,j) + simMatrix(i,j);


classSimMatrix = triu(classSimMatrix,1) + classSimCount';

