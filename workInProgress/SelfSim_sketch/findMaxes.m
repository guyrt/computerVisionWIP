function maxMask = findMaxes(im, thresh, blurKernel)

% Find the maximum pixels, defined as top
% thresh pixels. The default threshold is the
% top 0.004 of all responses.

% Author: Richard T. Guy
%         University of Toronto

if nargin == 1
    thresh = 0.996;
    blurKernel = [1 4 6 4 1]/16;
elseif nargin == 2
    blurKernel = [1 4 6 4 1]/16;
elseif nargin == 3
    blurKernel = blurKernel(:)';
end


imblur = conv2(blurKernel*blurKernel',im);
loc = round(length(imblur(:)) * thresh);
imSort = sort(imblur(:));
threshold = imSort(loc);


maxMask = imblur > threshold;

