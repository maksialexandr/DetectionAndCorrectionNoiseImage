clear all;
files = dir('image');
for type=1:3
    for file_name = 3:length(files)-2
        str_name = sprintf('image/%s', files(file_name).name);
        [im,map] = imread(str_name);
        [n,m,k]=size(im);
        IM=im;
        for p=0.2
            [LIM,LMaska] = NoiseIM(IM, p);
            IM = LIM{type};
            [N,edges] = histcounts(IM(:,:,:), 255);
            mean_N = int64(mean(N));

            array_N_1 = zeros(1,255);
            count = 0;
            for i=1:255
                if N(i) > mean_N*3.5
                    array_N_1(i) = N(i);
                    count = count + 1;
                end
            end     
            if isType1(array_N_1)==1
                disp('1');
            elseif isType3(array_N_1)==1
                disp('3');
            elseif isType2(array_N_1)==1
                disp('2');
            else
                disp('-');
            end

        end
    end
    disp('-------');
end


