function Colorize(maska, found_error_maska)
    [n,m] = size(maska);
    colorize_maska = zeros(n,m,3);
    for i=1:n
       for j=1:m
           if maska(i,j) == 1 && found_error_maska(i,j) == 1
               colorize_maska(i,j,2) = 255;
           elseif maska(i,j) == 1 && found_error_maska(i,j) == 0
               colorize_maska(i,j,1) = 255;
           %elseif maska(i,j) == 0 && found_error_maska(i,j) == 1
               %colorize_maska(i,j,3) = 255;
           end
       end
    end  
    figure;
    imshow(colorize_maska);