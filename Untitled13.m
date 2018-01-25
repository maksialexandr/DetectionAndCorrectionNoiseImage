[im,map] = imread('11.tif');
p = 0.1;
[LIM,LMaska]=NoiseIM(im, p);
type = 1;
maska = LMaska{type};
IM = LIM{type};

%figure;
%imshow(scorfilt(IM));

%tic;
%[GH_channels, Maska] = GH_channel(IM);
%toc
%PrintError(Maska, maska);

%tic;
%Maska = M_D_5(IM);
%toc
%PrintError(Maska, maska);

%tic;
%Maska = M_D_5_1(IM);
%toc
%PrintError(Maska, maska);


%tic;
%Maska = Smolka2016(IM);
%toc
%PrintError(Maska, maska);


%tic;
%Maska = Smolka_2016_Origin(IM);
%toc
%PrintError(Maska, maska);


%tic;
%Maska = Smolka2015(IM);
%toc
%PrintError(Maska, maska);
[n,m,k] = size(IM);
GH_channels = zeros(n,m,k);
tic;
GH_full = Smolka_2016_Origin(im);
toc
for i_gh=1:3
    GH_channels(:,:,i_gh) = GH_full;
end

tic;
im1 = VMF(im, GH_channels, R(p*10));
toc

