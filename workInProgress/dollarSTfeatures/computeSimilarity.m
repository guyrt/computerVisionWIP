function simMatrix = computeSimilarity(patchSet)

%%
% Compute the self-similarity of each set of clusters using normxcorr2,
% which compares a patch to another patch. Keeping with Agarwal et. al.
% (2003), we allow shifts of up to two pixels.
%
% Input: 
%   patchSet: p x p x N set of vectorized patches.
%
% Return:
%   simMatrix: "N choose 2" by 1 vector of similiarities corresponding to a
%   packed, upper triangular matrix of similarities.
%
% Author: Richard T. Guy
%

p = size(patchSet,1);
N = size(patchSet,3);
center = (p - 1) / 2; % Assume that sz is odd.
simMatrix = zeros(size(patchSet,3));

for i = 1:N
    patchI = patchSet(:,:,i); % separate this one out to avoid communication overhead.
    parfor j=i+1:N
        cc = normxcorr2(patchI, patchSet(:,:,j));
        cc = cc(center - 2:center+2,center-2:center+2);
        m = max(cc(:));
        simMatrix(i,j) = m; % ensure nonzero for packing.
    end
end

%simMatrix = simMatrix(simMatrix > 0);
%simMatrix = simMatrix - eps; % undo nonzero check.

