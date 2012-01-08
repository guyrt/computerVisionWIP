function flatCuboids = flattenCuboids(cuboids)

% Flatten cuboids. Also, get 3-D gradient. Returns a matrix where each row
% is a cuboid.

sz = size(cuboids);
flatCuboids = zeros(sz(4), 3*prod(sz(1:3)));

for i=1:sz(4)
    [gx gy gz] = gradient(cuboids(:,:,:,i));
    flatCuboids(i,:) = [gx(:)' gy(:)' gz(:)'];
end