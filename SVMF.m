function [im] = SVMF(im, error)
    [n,m,v]=size(im);
    size_for_median = 3;
    n_ext = n + size_for_median - 1;
    m_ext = m + size_for_median - 1;
    im_extended = zeros(n_ext, m_ext, v);
    size_for_median_plus = (size_for_median+1)/2;
    size_for_median_minus = (size_for_median-1)/2;
    value_pixel = 0;
    
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
                    count_ext = 0;
                    array_cm = [];
                    while sum(sum(array_cm)) == 0
                        size_for_median_minus_ext = size_for_median_minus + count_ext;
                        array_cm = [];
                        if i-size_for_median_minus_ext > 0 && i+size_for_median_minus_ext <= n_ext && j-size_for_median_minus_ext > 0 && j+size_for_median_minus_ext <= m_ext
                            for maska_i=i-size_for_median_minus_ext:i+size_for_median_minus_ext
                                for maska_j=j-size_for_median_minus_ext:j+size_for_median_minus_ext
                                    if im_extended(maska_i,maska_j) ~= -1 && error(maska_i-size_for_median_minus, maska_j-size_for_median_minus,k) == 0
                                        array_cm = [array_cm, norm([i,j] - [maska_i,maska_i])];                                   
                                    else
                                        array_cm = [array_cm, 0];    
                                    end
                                end
                            end  
                            count_ext = count_ext + 1;
                        else
                            for maska_i=i-size_for_median_minus:i+size_for_median_minus
                                for maska_j=j-size_for_median_minus:j+size_for_median_minus
                                    if im_extended(maska_i,maska_j) ~= -1
                                        array_cm = [array_cm, norm([i,j] - [maska_i,maska_i])];
                                    else
                                        array_cm = [array_cm, 0];  
                                    end
                                    
                                end
                            end  
                            break
                        end
                        if sum(sum(array_cm)) ~= 0
                            array_cm_matrix = GetMatrix(array_cm, 1+size_for_median_minus_ext*2);
                            [index_i,index_j] = GetMinIndex(array_cm_matrix);
                            matrix = im_extended(i-size_for_median_minus_ext:i+size_for_median_minus_ext, j-size_for_median_minus_ext:j+size_for_median_minus_ext, k);
                            value_pixel = matrix(index_i, index_j);
                        end
                    end
                    if sum(sum(array_cm)) ~= 0
                        im(i-size_for_median_minus, j-size_for_median_minus,k) = value_pixel;
                    end  
                end
            end
        end
    end
    
    
    
    
    
    