function img = groupsToImage(imageData, groups)

image_ysize = length(unique(imageData.drawCoords(1,:)));
image_xsize = length(unique(imageData.drawCoords(2,:)));

img = reshape(groups, [image_ysize, image_xsize]);

