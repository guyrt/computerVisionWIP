function d = chiSqDist(x,y)

e = sqrt(eps);
d = (x-y).^2 ./ (x+y+e);
d = sum(d,2) / 2;