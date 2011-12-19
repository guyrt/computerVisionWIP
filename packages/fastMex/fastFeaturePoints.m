function fp = fastFeaturePoints(img,threshold)

% Compute feature points using the FAST algorithm by Rosten and Drummond.
%
% For more information on the FAST detector, visit the FAST home page at
% http://mi.eng.cam.ac.uk/~er258/work/fast.html
% 
% Uses the fast_9 implementation in C available above. I have not added
% fast_{10,11,12} but I could if there is demand. The threshold is used
% to determine the threshold that defines an interest point: higher means
% less features make it through pruning.

if nargin == 1
   threshold = 50; 
end

if size(img,3) > 1
   img = rgb2gray(img); 
end

fp = mexFastNonMax(img, threshold);