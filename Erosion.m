function [erosion_array] = Erosion(IM, SE, GH)
    im = IM;
    [n,m,v] = size(im);
    erosion_array = zeros(n,m,v);
    size_for_median_plus = (SE+1)/2;
    size_for_median_minus = (SE-1)/2;
    
    n_ext = n + SE - 1;
    m_ext = m + SE - 1;
    im_extended = zeros(n_ext, m_ext, v);
    for k=1:v
        for i=1:n_ext
            for j=1:m_ext
                im_extended(i,j,k) = 256;
            end
        end
    end
    
    for k=1:v
        for i=size_for_median_plus:n+size_for_median_minus
            for j=size_for_median_plus:m+size_for_median_minus
                im_extended(i, j, k) = im(i-size_for_median_minus, j-size_for_median_minus, k);
            end 
        end
    end
    for k=1:v
        for i=size_for_median_plus:n_ext-size_for_median_minus
            for j=size_for_median_plus:m_ext-size_for_median_minus
                if GH(i-size_for_median_minus, j-size_for_median_minus) == 0
                    array_result = [];
                    array_result = [array_result, im_extended(i-size_for_median_minus:i+size_for_median_minus,j-size_for_median_minus:j+size_for_median_minus,k)];
                    erosion_array(i-size_for_median_minus, j-size_for_median_minus, k) = min(min(array_result));
                end
            end
        end
    end
    
    erosion_array = uint8(erosion_array);
    
    
    
    
    