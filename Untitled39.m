
clear all;
[im,map] = imread('image/I03.BMP');
[n,m,k]=size(im);

for p=0:0.1:0.9
    [n,m,k] = size(im);
    GH_channels = zeros(n,m,k);
    [LIM,LMaska] = NoiseIM(im, p);
    for type=1
        IM = LIM{type};
        maska = LMaska{type};

        figure;
        gca = imshow(IM);
        saveas(gca, strcat('snap_',int2str(type),'_',int2str(p*10),'.eps'),'epsc');

    end
    
end
