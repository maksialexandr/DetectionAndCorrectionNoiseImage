function [Mask] = Smolka2016(IM)
    [n,m,k] = size(IM);
    DIM = double(IM)/255;
    %1Метод Смолка 2016 Модифицированный
    %--------------------------------------------
    d = 0.2;%0.01:0.01:0.5 
    volume_of_group = 2;
    con = -1*ones(n, m);
    Mask = zeros(n, m);
    for chan=1:k
        for i=2:n-1
            for j=2:m-1
                center = DIM(i, j, chan);
                for i_maska=i-1:i+1
                    for j_maska=j-1:j+1
                        circle = DIM(i_maska, j_maska, chan);
                        if sqrt(sum(abs(center - circle).^2)) < d
                            con(i, j) = con(i, j) + 1;
                        end
                    end
                end
                if con(i, j) <= volume_of_group
                   Mask(i, j) = 1;
                end  
            end
        end
    con = -1*ones(n, m);
    end

end
