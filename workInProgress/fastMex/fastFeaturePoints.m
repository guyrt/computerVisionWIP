function fp = fastFeaturePoints(img)

if size(img,3) > 1
   img = rgb2gray(img); 
end

fp = mexFastNonMax(img);