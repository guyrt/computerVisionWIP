function [classSimMatrix simMatrix] = computeSimilarity(patchSet, classVector)

%%
% Compute the self-similarity of each set of clusters using normxcorr2,
% which compares a patch to another patch. Keeping with Agarwal et. al.
% (2003), we allow shifts of up to two pixels.
%
% Input: 
%   patchSet: p x p x N set of vectorized patches.
%   classVector: N x 1 set of class labels.
% Return:
%   classSimMatrix: c x c similarity matrix for number of unique classes.
%                   The lower triangle holds counts.
%   simMatrix: N x N upper triangular matrix of similarities.   
%
% Author: Richard T. Guy
%

p = size(patchSet,1);
N = size(patchSet,3);
center = (p - 1) / 2; % Assume that sz is odd.
simMatrix = zeros(size(patchSet,3));

for i = 1:N
    for j=i+1:N
        cc = normxcorr2(patchSet(:,:,i), patchSet(:,:,j));
        cc = cc(center - 2:center+2,center-2:center+2);
        m = max(cc(:));
        simMatrix(i,j) = m;
        simMatrix(j,i) = m;
    end
end

uniqueClasses = unique(classVector);
classSimMatrix = zeros(length(uniqueClasses));

for i=1:length(uniqueClasses)
    c1 = uniqueClasses(i);
    c1Set = classVector == c1;
    for j = i+1:length(uniqueClasses)
        c2 = uniqueClasses(j);
        c2Set = classVector == c2;
        m = simMatrix(c1Set,c2Set);
        
        classSimMatrix(i,j) = classSimMatrix(i,j) + sum(m(:));
        classSimMatrix(j,i) = classSimMatrix(j,i) + 1;
    end
end
