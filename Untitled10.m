[im,map] = imread('image/15.tif');
[LIM,LMaska]=NoiseIM(im, 0.9);

type = 1;
maska = LMaska{type};
IM = LIM{type}; 
figure;
imshow(IM);

GH_full = M_D_5_1(IM);
for i_gh=1:3
    GH_channels(:,:,i_gh) = GH_full;
end
[er1, er2] = PrintError(maska, GH_full)
Colorize(maska, GH_full);

%im_correct = AMF(IM, GH_channels);
%figure;
%imshow(im_correct);