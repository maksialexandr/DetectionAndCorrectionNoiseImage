function [Mask] = Smolka2015(IM)
    %Метод Смолка 2015 Модифицированный
    %--------------------------------------------
    [n,m,k] = size(IM);
    ss=[1 2 3 4 5 6 7 8 9].^-1;
    for met=2
        Mask=zeros(n,m);
        for i=2:n-1
            for j=2:m-1
                points=IM(i-1:i+1,j-1:j+1,:);
                qwe=1;
                for tt=1:3
                    for yy=1:3
                        point(1:3,qwe)=double(points(tt,yy,1:3));
                        qwe=qwe+1;
                    end
                end
                for ii=1:9
                    for jj=1:9
                        Dist(ii,jj)=sqrt((point(1,ii)-point(1,jj))^2+(point(2,ii)-point(2,jj))^2+(point(3,ii)-point(3,jj))^2);
                    end
                end
                %определить сортировку расстояний
                for ii=1:9
                    [sortDist,inDist]=sort(Dist(ii,:));
                    D(ii)=sum(sortDist.*ss);%f(r)=1/r
                end
                [sortD,inD]=sort(D);
                deltaS1=find(inD==5);%вычисление позиции в отсортированном ряде расстояний
                if(deltaS1>met) 
                    Mask(i,j)=1;
                end 
            end
        end
    end
