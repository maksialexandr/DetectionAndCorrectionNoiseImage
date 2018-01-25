function ROC1(IM,STR,D1,MET1,ko1,KO1,k1,KK1,MET2,D2)
[n,m,ku]=size(IM);
%kol2=sum(Maska(:));
%kol1=n*m-kol2;
DIM=double(IM)/255;


%1Метод Смолка 2016 Модифицированный
%--------------------------------------------
d=0.2;%0.01:0.01:0.5
ti=2;%1:3
con=-1*ones(n,m);
Mask=zeros(n,m);
for chan=1:3
    for i=2:n-1
        for j=2:m-1
            cent=DIM(i,j,chan);
            for ii=1:3
                for jj=1:3
                    sravn=DIM(i-ii+2,j-jj+2,chan);
                    if(sum(abs(cent - sravn))<d)
                        con(i,j)=con(i,j)+1;
                    end
                end
            end
            if(con(i,j)<=ti)
                Mask(i,j)=1;
            end  
        end
    end
con=-1*ones(n,m);
end

%tt=1;
ti=1;
for d=D1
con=-1*ones(n,m);
Mask1=Mask;
for chan=1:3
    for i=2:n-1
        for j=2:m-1
            cent=DIM(i,j,chan);
            for ii=1:3
                for jj=1:3
                    sravn=DIM(i-ii+2,j-jj+2,chan);
                    if(Mask(i-ii+2,j-jj+2)==1)
                        continue;
                    end
                    if(sum(abs(cent - sravn))<d)
                        con(i,j)=con(i,j)+1;
                    end
                end
            end
            if(con(i,j)<=ti)
                Mask1(i,j)=1;
            end  
        end
    end
con=-1*ones(n,m);
end
Mask=Mask1;
save(strcat(STR,'Mask1.mat'),'Mask');
%[e1,e2]=getError(Maska,Mask1);
%res1(tt,1:3)=[e1/kol1,e2/kol2,d];
%tt=tt+1;
end


%2Метод Смолка 2015 Модифицированный
%--------------------------------------------
%ttt=1;
ss=[1 2 3 4 5 6 7 8 9].^-1;
for met=MET1
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
    save(strcat(STR,'Mask2.mat'),'Mask');
    %[e1,e2]=getError(Maska,Mask);
    %res2(ttt,1:3)=[e1/kol1,e2/kol2,met];
    %ttt=ttt+1;
end



%3Метод Мой
%--------------------------------------------
%tt=1;
for ko=ko1%47:48%46:48
for KO=KO1%258:-1:252
for k=k1%0.99
for KK=KK1%0.9:0.01:0.99
Mask=zeros(n,m);
Mask1=bwmorph(IM(:,:,1)-ko,'bothat')|bwmorph(IM(:,:,2)-ko,'bothat')|bwmorph(IM(:,:,3)-ko,'bothat');
Mask3=bwmorph(KO-IM(:,:,1),'bothat')|bwmorph(KO-IM(:,:,2),'bothat')|bwmorph(KO-IM(:,:,3),'bothat');
Mask2=bwmorph(im2bw(IM(:,:,1)+ko,k)|im2bw(IM(:,:,2)+ko,k)|im2bw(IM(:,:,3)+ko,k),'remove');
Mask4=bwmorph(im2bw(KO-IM(:,:,1),KK)|im2bw(KO-IM(:,:,2),KK)|im2bw(KO-IM(:,:,3),KK),'remove');
Mask5=bwmorph(im2bw(rgb2gray(IM),k),'bothat');
Mask6=bwmorph(im2bw(rgb2gray(KO-IM),KK),'bothat');
Mask=Mask1|Mask2|Mask3|Mask4|Mask5|Mask6;
save(strcat(STR,'Mask3.mat'),'Mask');
%[e1,e2]=getError(Maska,Mask);
%res3(tt,1:6)=[e1/kol1,e2/kol2,ko,KO,k,KK];
%tt=tt+1;
end
end
end
end
%save(strcat(STR,'M3.mat'),'res3');

%4
%Смолка 2015 
%ttt=1;
ss=[1 2 3 4 5 6 7 8 9].^-1;
for met=MET2
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
            delta1=D(5); %Значение
            deltaS1=find(inD==5);%вычисление позиции в отсортированном ряде расстояний
            if(delta1-deltaS1>met) 
                Mask(i,j)=1; 
            end 
            
        end
    end
    save(strcat(STR,'Mask4.mat'),'Mask');
    %[e1,e2]=getError(Maska,Mask);
    %res4(ttt,1:3)=[e1/kol1,e2/kol2,met];
    %ttt=ttt+1;
end
%save(strcat(STR,'M4.mat'),'res4');

%5
%Смолка 2016
%tt=1;
ti=2;
for d=D2 
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
save(strcat(STR,'Mask5.mat'),'Mask');
%[e1,e2]=getError(Maska,Mask);
%res5(tt,1:3)=[e1/kol1,e2/kol2,d];
%tt=tt+1;
end
%save(strcat(STR,'M5.mat'),'res5');

%итоговое рок график для методов
%plot(res1(:,1),res1(:,2),'b',res2(:,1),res2(:,2),'r',res3(:,1),res3(:,2),'g',res4(:,1),res4(:,2),'c',res5(:,1),res5(:,2),'y'), xlim([0, 0.12]), ylim([0, 0.24]);
%saveas(gcf,strcat(STR,'.jpg'));
%saveas(gcf,strcat(STR),'epsc');

end
