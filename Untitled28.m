clear all;
files = dir('image');
type = 6;
for p=0:0.1:0.9
    error = 0;
    for file_name = 3:length(files)-2

        str_name = sprintf('image/%s', files(file_name).name);
        [im,map] = imread(str_name);
        [n,m,k]=size(im);
        IM=im;       
    
        [LIM,LMaska] = NoiseIM(IM, p);
        IM = LIM{type};
        maska = LMaska{type};
        [GH_channels, GH] = GH_channel(IM);
        error = error + abs(p - sum(sum(GH))/(m*n));

    end
    R = sprintf('R(%0.1f) = %0.5f', p, error/(length(files)-4));
    disp(R);
end