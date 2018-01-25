function [GH] = GHError(IM)
    SE = strel('square', 9);
    im = IM(:,:,:);
    [n,m,k] = size(im);
    GH = zeros(n,m);
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
                else
                    gh(i,j) = 0;  
                end
            end
        end
        GH = gh|GH;
    end
