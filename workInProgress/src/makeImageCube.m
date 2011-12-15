function cube = makeImageCube(dirHead, suffix, n)

imPath = [dirHead num2str(1) suffix];
pic = rgb2gray(imread(imPath));
[w h] = size(pic);
cube = zeros(w,h,n);
cube(:,:,1) = pic;

for i=2:n
   imPath = [dirHead num2str(i) suffix] ;
   cube(:,:,i) = rgb2gray(imread(imPath));
end

