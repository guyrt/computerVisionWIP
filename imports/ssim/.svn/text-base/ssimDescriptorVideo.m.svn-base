function [resp,drawCoords,salientCoords,uniformCoords] = ssimDescriptorVideo( video,parms,allXCoords,allYCoords )
%UNTITLED Compute Self-similarity features over video.
%   
% Author: Richard T. Guy
% Uses ssimDescriptor as written by Varun Gulshan, varun@robots.ox.ac.uk
% Based on paper:
%   Matching Local Self-Similarities across Images and Videos, Eli Shechtman and Michal Irani
%   CVPR '07
%
%
%  Assume that the time direction matches 1 frame against 5 frames.

  [resp,drawCoords,salientCoords,uniformCoords]= ...
  calcFrespsVideo(video,parms.size,parms.coRelWindowRadius,allXCoords,allYCoords,parms.numRadiiIntervals, ...
                 parms.numThetaIntervals,parms.varNoise,parms.autoVarRadius,parms.saliencyThresh,parms.nChannels);


end

function [ssimMaps,dCoords,sCoords,uCoords]=calcFrespsVideo(video,patchSize,coRelWindowRadius,allXCoords,allYCoords, ...
          numRadiiIntervals, numThetaIntervals,varNoise,autoVarRadius,saliencyThresh,nChannels)

      NUMvidFrames = 1;
      
if mod(patchSize,2) ~= 1
    fprintf('patchSize was %d. Must be an odd integer.\n',patchSize);
    return
end
      
NUMradius=(patchSize-1)/2; % Note: patchSize should be odd only
NUMpixels=patchSize*patchSize*NUMvidFrames;

% -- Find all the image patches -----
NUMrows = video.height;
NUMcols = video.width;
NUMframes = video.NumberOfFrames;

[colinds,rowinds,frameinds]=meshgrid(1:NUMcols,1:NUMrows,1:NUMframes);
rowinds=rowinds(NUMradius+1:NUMrows-NUMradius,NUMradius+1:NUMcols-NUMradius,NUMvidFrames+1:NUMframes-NUMvidFrames);
colinds=colinds(NUMradius+1:NUMrows-NUMradius,NUMradius+1:NUMcols-NUMradius,NUMvidFrames+1:NUMframes-NUMvidFrames);
frameinds=frameinds(NUMradius+1:NUMrows-NUMradius,NUMradius+1:NUMcols-NUMradius,NUMvidFrames+1:NUMframes-NUMvidFrames);
NUMvalid=numel(rowinds);
rowinds=reshape(rowinds,1,NUMvalid); % Row coordinates for extracting patches
colinds=reshape(colinds,1,NUMvalid); % Col coordinates for extracting patches
frameinds=reshape(frameinds,1,NUMvalid);

rexpand=repmat([-NUMradius:NUMradius]',patchSize,1);
cexpand=reshape(repmat([-NUMradius:NUMradius],patchSize,1),NUMpixels,1);
fexpand=1; % for now, only one frame.


% Here, we need to go in sections.

if (NUMvalid>0),
  rowinds=repmat(rowinds,NUMpixels,1)+repmat(rexpand,1,NUMvalid);
  colinds=repmat(colinds,NUMpixels,1)+repmat(cexpand,1,NUMvalid);
  
  inds=sub2ind([NUMrows NUMcols],rowinds,colinds);
  clear rowinds colinds frameinds; % saving memory
  if nChannels==3,
    ch=img(:,:,1);
    imgpatches(:,:,1)=ch(inds);
    ch=img(:,:,2);
    imgpatches(:,:,2)=ch(inds);
    ch=img(:,:,3);
    imgpatches(:,:,3)=ch(inds);
  else
    imgpatches(:,:)=img(inds);
  end;
  clear inds; % saving memory
else
  imgpatches=[];
end;


simMapParams=makeSimMapParams(coRelWindowRadius,NUMrows,NUMradius,autoVarRadius,numRadiiIntervals, ...
                              numThetaIntervals,varNoise);

simMapParams.interiorH=uint32(simMapParams.interiorH);
simMapParams.coRelCircleOffsets=int32(simMapParams.coRelCircleOffsets);
simMapParams.numRadiiIntervals=uint32(simMapParams.numRadiiIntervals);
simMapParams.numThetaIntervals=uint32(simMapParams.numThetaIntervals);
simMapParams.autoVarianceIndices=uint32(simMapParams.autoVarianceIndices-1); % Making it 0 indexed
for i=1:length(simMapParams.binIndices)
  simMapParams.binIndices{i}=uint32(simMapParams.binIndices{i}-1); %Making it 0 indexed
end

ssimMaps=mexFindSimMaps(uint32(allXCoords-1-NUMradius),uint32(allYCoords-1-NUMradius),imgpatches,simMapParams, ...
                        uint32(nChannels));
allCoords(1,:)=allXCoords;allCoords(2,:)=allYCoords;
clear allXCoords allYCoords;
[indsSalient,indsUniform,indsOkay,ssimMaps]=pruneAndScaleMaps(ssimMaps,saliencyThresh); % TO BE COMPLETED RETURN DCOORDS.
dCoords=allCoords(:,indsOkay);
sCoords=allCoords(:,indsSalient);
uCoords=allCoords(:,indsUniform);
%ssimMaps=ssimMaps(:,indsOkay);

end