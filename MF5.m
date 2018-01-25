function [IM] = MF5(im, error, size_for_median)
    size_block = size_for_median;
    size_for_median = (size_for_median+1)/2;
    [n,m,v]=size(im);
    IM = im;
    for k=1:v
        for i=size_for_median:n-size_for_median
            for j=size_for_median:m-size_for_median
                average = 0;
                if error(i,j) == 1
                    for maska_i=i-size_for_median+1:i+size_for_median-1
                        for maska_j=j-size_for_median+1:j+size_for_median-1
                            average = average + im(maska_i, maska_j);
                        end
                    end
                    IM(i,j,k) = average/(size_block*size_block);
                end
            end
        end
    end
    
    