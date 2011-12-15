function selfCorr = selfCorrelation(imageData)

% Compute the patch comparison at each image location.
%

resp = imageData.resp;
numFeatures = size(resp,2);

subMat = diag(-1*ones(1,numFeatures-1),0);
subMat = [ones(numFeatures-1,1) subMat];

selfCorr = zeros(numFeatures);

parfor i=1:numFeatures
    selfCorrT = sum(abs(circshift(subMat,[0 i-1]) * resp'),2)' / size(resp,1);
    selfCorrT = [selfCorrT(1:i-1) 0 selfCorrT(i:end)];
    selfCorr(i,:) = selfCorrT;
end

% Sigmoid
selfCorr = selfCorr ./ (1 + selfCorr.^.5).^.5;
selfCorr = max(selfCorr(:)) - selfCorr;