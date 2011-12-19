function fp = fastFeaturePoints(img,threshold)

% Compute feature points using the FAST algorithm by
% 
% Uses the fast_9 implementation by 

if nargin == 1
   threshold = 50; 
end

if size(img,3) > 1
   img = rgb2gray(img); 
end

fp = mexFastNonMax(img, threshold);