function [GH_channels, GH] = GH_channel(IM)
    SE = strel('square', 9);
    im = IM(:,:,:);
    [n,m,k] = size(im);
    GH = zeros(n,m);
    GH_channels = zeros(n,m, k);
    for r=1:k
        im = IM(:,:,r);
        dilate = imdilate(im, SE);
        erode = imerode(im, SE);
        ge = im - erode;
        gd = dilate - im;

        gh = ge .* gd;
        for i=1:n
           for j=1:m
                if gh(i,j) == 0
                    gh(i,j) = 1;   
                    GH_channels(i,j,r) = 1;  
                else
                    gh(i,j) = 0;  
                    GH_channels(i,j,r) = 0;  
                end
            end
        end
        GH = gh|GH;
    end