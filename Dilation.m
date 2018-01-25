function [dilation_array] = Dilation(IM, SE, GH)
    im = IM;
    [n,m,v] = size(im);
    dilation_array = ones(n,m,v)*255;
    size_for_median_plus = (SE+1)/2;
    size_for_median_minus = (SE-1)/2;
    
    n_ext = n + SE - 1;
    m_ext = m + SE - 1;
    im_extended = zeros(n_ext, m_ext, v);
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
                    dilation_array(i-size_for_median_minus, j-size_for_median_minus, k) = max(max(array_result));
                end
            end
        end
    end

    dilation_array = uint8(dilation_array);
    
    
    
    
    