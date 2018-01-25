[im,map] = imread('example.jpeg');
[n,m,k] = size(im);
for p = 0.1
   [LIM,LMaska] = NoiseIM(im,p);
   for type = 1
       maska = LMaska{type};
       sum(sum(maska))
   end
end