function [im] = SRF(im, error)
    [n,m,v]=size(im);
    size_for_median = 3;
    n_ext = n + size_for_median - 1;
    m_ext = m + size_for_median - 1;
    im_extended = zeros(n_ext, m_ext, v);
    size_for_median_plus = (size_for_median+1)/2;
    size_for_median_minus = (size_for_median-1)/2;
    
    for k=1:v
        for i=1:n_ext
            for j=1:m_ext
                im_extended(i,j,k) = -1;
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
    
    for i=size_for_median_plus:n_ext-size_for_median_minus
        for j=size_for_median_plus:m_ext-size_for_median_minus
      
            for k=1:v
                if error(i-size_for_median_minus, j-size_for_median_minus,k) == 1
                    arr = [];
                    count_ext = 0;
                    while size(arr) == 0
                        size_for_median_minus_ext = size_for_median_minus + count_ext;
                        if i-size_for_median_minus_ext > 0 && i+size_for_median_minus_ext <= n_ext && j-size_for_median_minus_ext > 0 && j+size_for_median_minus_ext <= m_ext
                            for maska_i=i-size_for_median_minus_ext:i+size_for_median_minus_ext
                                for maska_j=j-size_for_median_minus_ext:j+size_for_median_minus_ext
                                    if im_extended(maska_i,maska_j) ~= -1 && error(maska_i-size_for_median_minus, maska_j-size_for_median_minus,k) == 0
                                        arr = [arr, im_extended(maska_i, maska_j, k)];
                                    end
                                end
                            end  
                            count_ext = count_ext + 1;
                        else
                            for maska_i=i-size_for_median_minus:i+size_for_median_minus
                                for maska_j=j-size_for_median_minus:j+size_for_median_minus
                                    if im_extended(maska_i,maska_j) ~= -1
                                        arr = [arr, im_extended(maska_i, maska_j, k)];
                                    end
                                end
                            end  
                            break
                        end
                    end
                    if size(arr) ~= 0
                        corect_pixel = arr(randi(size(arr)));
                    end
                    im(i-size_for_median_minus, j-size_for_median_minus,k) = corect_pixel;
                end
            end
        end
    end
    
    
    