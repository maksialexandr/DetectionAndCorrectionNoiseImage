function [GH] = Method_detection_3(IM)
    im = IM(:,:,1);
    [n,m,k] = size(im);
    GH1 = Method_detection_1(IM);
    GH = zeros(n,m);
    myse = 9;
    for r=1:3
        im = IM(:,:,r);
        dilate = Dilation(im, myse);
        erode = Erosion(im, myse);
        %SE = strel('square', 9);
        %dilate = imdilate(im, SE);
        %erode = imerode(im, SE);
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
