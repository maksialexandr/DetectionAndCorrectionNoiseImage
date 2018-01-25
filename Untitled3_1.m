
[im,map] = imread('11.tif');
[LIM,LMaska]=NoiseIM(im,0.1);
type = 1;
maska = LMaska{type};
IM = LIM{type};
im = IM;  

arr = [1,2,3;5,2,4;3,8,1];
disp(arr);
A = medfilt2(arr);
disp(A);