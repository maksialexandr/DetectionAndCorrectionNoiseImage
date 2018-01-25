%{
[im,map] = imread('example.jpeg');
[n,m,k]=size(im);
for p=0.1:0.1:0.9
   [LIM,LMaska]=NoiseIM(im,p);
   for type=1
       IM=LIM{type};
       GH = zeros(n,m);
       for r=1:3
           im1 = IM(:,:,r);

           SE = strel('square', 9);

           erode = imerode(im1, SE);
           ge = im1 - erode;

           dilate = imdilate(im1, SE);
           gd = dilate - im1;
           
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
   end 
   
   R = sprintf('R(%0.1f) = %0.5f', p, sum(sum(GH))/(m*n));
   disp(R);
end
%}

clear all;
files = dir('image');
for file_name = 4:length(files)-2
    str_name = sprintf('image/%s', files(file_name).name);
    [im,map] = imread(str_name);
    [n,m,k]=size(im);
    IM=im;

    [GH_channels, GH] = GH_channel(IM);
    R = sprintf('R(0.0) = %0.5f', sum(sum(GH))/(m*n));
    disp(R);
    
    for p=0.1:0.1:0.9
        [LIM,LMaska] = NoiseIM(IM, p);
        for type=2
            IM = LIM{type};
            maska = LMaska{type};
            [GH_channels, GH] = GH_channel(IM);
        end
        R = sprintf('R(%0.1f) = %0.5f', p, sum(sum(GH))/(m*n));
        disp(R);
    end
end
