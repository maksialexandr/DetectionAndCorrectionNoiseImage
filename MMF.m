function [im] = MMF(im, GH)
    mySE = 9;
    size_stucture_element = 3;
    SE = strel('square', 3);
    erode = Erosion(im, mySE, GH);
    dilate = Dilation(im, mySE, GH); 
    %erode = imerode(im, SE);
    %dilate = imdilate(im, SE); 
   
    
    fbc1 = imdilate(erode, SE);
    fbc2 = imerode(dilate, SE);

    
    [n,m,v] = size(im);
    w = zeros(n,m);
    M = zeros(n,m,v);
    
    n_ext = n + size_stucture_element - 1;
    m_ext = m + size_stucture_element - 1;
    im_extended = zeros(n_ext, m_ext, v);
    GH_extended = zeros(n_ext, m_ext, v);
    size_for_median_plus = (size_stucture_element+1)/2;
    size_for_median_minus = (size_stucture_element-1)/2;
    for k=1:v
        for i=size_for_median_plus:n+size_for_median_minus
            for j=size_for_median_plus:m+size_for_median_minus
                im_extended(i, j, k) = im(i-size_for_median_minus, j-size_for_median_minus, k);
                GH_extended(i, j, k) = GH(i-size_for_median_minus, j-size_for_median_minus, k);
            end 
        end
    end

    for k=1:v
        for i=size_for_median_plus:n_ext-size_for_median_minus
            for j=size_for_median_plus:m_ext-size_for_median_minus
                if GH(i-size_for_median_minus, j-size_for_median_minus,k) == 1
                    arr = [];
                    for maska_i=i-size_for_median_minus:i+size_for_median_minus
                        for maska_j=j-size_for_median_minus:j+size_for_median_minus
                            if GH_extended(maska_i, maska_j) == 0
                                arr = [arr, im_extended(maska_i, maska_j, k)];
                            end
                        end
                    end
                    %arr = im_extended(i-(size_for_median_plus-1):i+size_for_median_plus-1, j-(size_for_median_plus-1):j+size_for_median_plus-1, k);
                    error = GH_extended(i-(size_for_median_plus-1):i+size_for_median_plus-1, j-(size_for_median_plus-1):j+size_for_median_plus-1);
                    R = sum(sum(error))/(size_stucture_element*size_stucture_element);
                    w(i-size_for_median_minus, j-size_for_median_minus) = (1-R)/(2*R);
                    M(i-size_for_median_minus, j-size_for_median_minus,k) = median(arr);
                
                    fb1 = fbc1(i-size_for_median_minus, j-size_for_median_minus,k);
                    fb2 = fbc2(i-size_for_median_minus, j-size_for_median_minus,k);
                    w1 = w(i-size_for_median_minus, j-size_for_median_minus);
                    m1 = M(i-size_for_median_minus, j-size_for_median_minus,k);
                    %im(i-size_for_median_minus, j-size_for_median_minus,k) = (fbc1(i-size_for_median_minus, j-size_for_median_minus) + w(i-size_for_median_minus, j-size_for_median_minus,k)*M(i-size_for_median_minus, j-size_for_median_minus,k) + fbc2(i-size_for_median_minus, j-size_for_median_minus))/(w(i-size_for_median_minus, j-size_for_median_minus,k) + 2);
                    im(i-size_for_median_minus, j-size_for_median_minus,k) = (fb1 + w1*m1 + fb2)/(w1+2);
                end
            end
        end
    end

    
    