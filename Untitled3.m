
[im,map] = imread('11.tif');
[LIM,LMaska]=NoiseIM(im,0.5);
type = 1;
maska = LMaska{type};
IM = LIM{type};
origin = im;
im = IM;
figure;  
imshow(im);


[GH_channels, GH_full] = GH_channel(im);
PrintError(maska, GH_full);
tic;
im1 = RF(im, GH_channels, 5);
toc
figure;
imshow(im1);

%{
y - уровень искажения (peak signal-to-noise ratio) пиковое отношение сигнал / шум
sigma - среднеквадратичное откланение
%}
[y, sigma] = PSNR_MSE(origin, im1)
load('iW.mat'); 
score_IFS = IFS(origin, im1, iW)
score_SR_SIM = SR_SIM(origin, im1)











