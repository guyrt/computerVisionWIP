
function retSet = getDescriptors(strPath, pyramidLevels, selectPatch)

% Get descriptors for a series of images, with a specified number of
% pyramidLevels. If only a path is given, use only one pyramidLevel.

% Return: an object holding 
%    resp: the response matrix
%    drawCoords: the coordinates of each feature
%    salientCoords: the location of coordinates where no feature was found
%        due to salience.
%    uniformCoords: the location of coordinates where no feature was
%        returned due to uniformity.

if nargin == 1
   pyramidLevels = 1; 
end

img = imread(strPath);

if nargin == 3 && selectPatch
   figure(999), imagesc(img);
   cb = round(ginput(2));
   img= img(cb(1,2):cb(2,2), cb(1,1):cb(2,1));
end

img = double(img);

retSet = cell(pyramidLevels,1);
retSet{1} = descriptorSet(img);



for i=2:pyramidLevels
   img = impyramid(img,'reduce'); 
   retSet{i} = descriptorSet(img);
end

end

function response = descriptorSet(img)
    parms.size=5;
    parms.coRelWindowRadius=10;
    parms.numRadiiIntervals=4;
    parms.numThetaIntervals=20;
    parms.varNoise=25*3*36;
    parms.autoVarRadius=1;
    parms.saliencyThresh=0.1; % I usually disable saliency checking
    parms.nChannels=size(img,3);

    radius=(parms.size-1)/2; % the radius of the patch
    marg=radius+parms.coRelWindowRadius;

    % Compute descriptor at every 5 pixels seperation in both X and Y directions
    [allXCoords,allYCoords]=meshgrid(marg+1:5:size(img,2)-marg, marg+1:5:size(img,1)-marg);

    allXCoords=allXCoords(:)';
    allYCoords=allYCoords(:)';

    fprintf('Computing self similarity descriptors\n');
    [resp,drawCoords,salientCoords,uniformCoords]=ssimDescriptor(img, parms ,allXCoords ,allYCoords);
    fprintf('Descriptor computation done\n');
    
    response.resp = resp;
    response.salientCoords = salientCoords;
    response.drawCoords = drawCoords;
    response.uniformCoords = uniformCoords;
    response.params = parms;
    response.imgSize = size(img);
end