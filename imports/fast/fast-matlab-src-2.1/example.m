i = imread('lab.pgm');

%Make image greyscale
if length(size(i)) == 3
	im =  double(i(:,:,2));
else
	im = double(i);
end

c9 = fast9(im, 30,1);

axis image
colormap(gray)

imshow(im / max(im(:)));
hold on
plot(c9(:,1), c9(:,2), 'r.')
title('9 point FAST');
