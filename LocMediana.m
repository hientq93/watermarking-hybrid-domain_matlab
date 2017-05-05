function y = LocMediana(anhThuyVan)

%rgbf=ones(size(anhThuyVan)); % better prealloc
r=medfilt2(anhThuyVan(:,:,1));
g=medfilt2(anhThuyVan(:,:,2));
b=medfilt2(anhThuyVan(:,:,3));

y=cat(3,r,g,b);