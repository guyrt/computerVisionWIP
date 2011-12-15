function [crl c]  = starCorrelation(patchResp, imageResp, imageCoords)

% Compute the correlation between two image patch sets.
% Working in log space.

a = sum(abs(patchResp-imageResp)/size(patchResp,1));
crl = a./(1+a.^2).^.5;
crl = sum(crl);

centerImage = round(mean(imageCoords,2));
cImage = repmat(centerImage,1,size(imageCoords,2));

c = cImage;
