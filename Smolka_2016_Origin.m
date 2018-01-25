function [Mask] = Smolka_2016_Origin(IM)
    [n,m,k] = size(IM);
    DIM = double(IM)/255;
    ti=2;
    for d=1
        con=-1*ones(n,m);
        Mask=zeros(n,m);
        for i=2:n-1
            for j=2:m-1
                cent=DIM(i,j,:);
                for ii=1:3
                    for jj=1:3
                        sravn=DIM(i-ii+2,j-jj+2,:);
                        if(sqrt(sum((cent - sravn).^2))<d)
                            con(i,j)=con(i,j)+1;
                        end
                    end
                end
                if(con(i,j)<=ti)
                    Mask(i,j)=1;
                end  
            end
        end
    end