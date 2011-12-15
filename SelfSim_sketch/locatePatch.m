function patchCorr = locatePatch(patchData, imageData, invert)

% Compute the patch comparison at each image location.
%

ysize = length(unique(patchData.drawCoords(1,:)));
xsize = length(unique(patchData.drawCoords(2,:)));

image_ysize = length(unique(imageData.drawCoords(1,:)));
image_xsize = length(unique(imageData.drawCoords(2,:)));

% Compute number of patch comparisons.
patchLimitX = image_xsize - xsize+1;
patchLimitY = image_ysize - ysize+1;
sz = [patchLimitX patchLimitY];

patchCorr = zeros(imageData.imgSize(1), imageData.imgSize(2));

for i=1:sz(2) % march through columns
    z = zeros([image_xsize, image_ysize]);
    z(1:xsize,i:ysize+(i-1)) = 1;
    %figure(9), spy(z);S = .2*diag(ones(size(patchResp,1),1));


    %pause;
    z = find(z);
    
    for j=1:sz(1) % down rows.
        [cc cLoc] = starCorrelation(patchData.resp, imageData.resp(:,z+(j-1)), imageData.drawCoords(:,z+(j-1)));
        patchCorr(cLoc(2)-2:cLoc(2)+2,cLoc(1)-2:cLoc(1)+2) = cc; 
    end
end

if nargin ==3 && invert == 1
    patchCorr(patchCorr == 0) = min(patchCorr(patchCorr>0));
else
    patchCorr(patchCorr == 0) = max(patchCorr(patchCorr>0));
    patchCorr = max(patchCorr(:)) - patchCorr;
end