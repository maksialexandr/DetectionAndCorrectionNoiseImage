function [IM,Maska]=NoiseIM(im,p)
    [n,m,k]=size(im);
    %1-3 тип
    for i=1:3
        %1 независимо соль-перец
        x = rand(n,m);
        b=im(:,:,i);
        b(x < p/2) = 0; % Minimum value
        b(x >= p/2 & x < p) = 255; % Maximum (saturated) value
        IM1(:,:,i)=uint8(b);
        %2 независимо рандом
        x = rand(n,m);
        b=im(:,:,i);
        b(x < p/2) = randi([0,255]); % Minimum value
        b(x >= p/2 & x < p) = randi([0,255]); % Maximum (saturated) value
        IM2(:,:,i)=uint8(b);
        %3 независимо в пределах
        x = rand(n,m);
        b=im(:,:,i);
        b(x < p/2) = randi([0,50]); % Minimum value
        b(x >= p/2 & x < p) = randi([200,255]); % Maximum (saturated) value
        IM3(:,:,i)=uint8(b);
    end
    IM{1}=IM1;
    IM{2}=IM2;
    IM{3}=IM3;
    
    %4 Зависимо в каждый канал соль-перец
    x = rand(n,m);
    b1=im(:,:,1);
    b2=im(:,:,2);
    b3=im(:,:,3);
    b1(x < p/2) = 255*randi([0,1]); % Minimum value
    b2(x < p/2) = 255*randi([0,1]); % Minimum value
    b3(x < p/2) = 255*randi([0,1]); % Minimum value
    b1(x >= p/2 & x < p) = 255*randi([0,1]); % Maximum (saturated) value
    b2(x >= p/2 & x < p) = 255*randi([0,1]); % Maximum (saturated) value
    b3(x >= p/2 & x < p) = 255*randi([0,1]); % Maximum (saturated) value
    IM4(:,:,1)=uint8(b1);
    IM4(:,:,2)=uint8(b2);
    IM4(:,:,3)=uint8(b3);

    %5 Зависимо в каждый канал случайное
    x = rand(n,m);
    b1=im(:,:,1);
    b2=im(:,:,2);
    b3=im(:,:,3);
    b1(x < p/2) = randi([0,255]); % Minimum value
    b2(x < p/2) = randi([0,255]); % Minimum value
    b3(x < p/2) = randi([0,255]); % Minimum value
    b1(x >= p/2 & x < p) = randi([0,255]); % Maximum (saturated) value
    b2(x >= p/2 & x < p) = randi([0,255]); % Maximum (saturated) value
    b3(x >= p/2 & x < p) = randi([0,255]); % Maximum (saturated) value
    IM5(:,:,1)=uint8(b1);
    IM5(:,:,2)=uint8(b2);
    IM5(:,:,3)=uint8(b3);

    %6 Зависимо в каждый канал случайное
    x = rand(n,m);
    b1=im(:,:,1);
    b2=im(:,:,2);
    b3=im(:,:,3);
    b1(x < p/2) = randi([0,50]); % Minimum value
    b2(x < p/2) = randi([0,50]); % Minimum value
    b3(x < p/2) = randi([0,50]); % Minimum value
    b1(x >= p/2 & x < p) = randi([200,255]); % Maximum (saturated) value
    b2(x >= p/2 & x < p) = randi([200,255]); % Maximum (saturated) value
    b3(x >= p/2 & x < p) = randi([200,255]); % Maximum (saturated) value
    IM6(:,:,1)=uint8(b1);
    IM6(:,:,2)=uint8(b2);
    IM6(:,:,3)=uint8(b3);
    
    IM{4}=IM4;
    IM{5}=IM5;
    IM{6}=IM6;
    
    %Поиск маски
    Maska1=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM1(i,j,1) || im(i,j,2)~=IM1(i,j,2) || im(i,j,3)~=IM1(i,j,3))
                Maska1(i,j)=1;
            end
        end
    end

    Maska2=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM2(i,j,1) || im(i,j,2)~=IM2(i,j,2) || im(i,j,3)~=IM2(i,j,3))
                Maska2(i,j)=1;
            end
        end
    end

    Maska3=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM3(i,j,1) || im(i,j,2)~=IM3(i,j,2) || im(i,j,3)~=IM3(i,j,3))
                Maska3(i,j)=1;
            end
        end
    end

    Maska4=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM4(i,j,1) || im(i,j,2)~=IM4(i,j,2) || im(i,j,3)~=IM4(i,j,3))
                Maska4(i,j)=1;
            end
        end
    end

    Maska5=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM5(i,j,1) || im(i,j,2)~=IM5(i,j,2) || im(i,j,3)~=IM5(i,j,3))
                Maska5(i,j)=1;
            end
        end
    end

    Maska6=zeros(n,m);
    for i=1:n
        for j=1:m
            if(im(i,j,1)~=IM6(i,j,1) || im(i,j,2)~=IM6(i,j,2) || im(i,j,3)~=IM6(i,j,3))
                Maska6(i,j)=1;
            end
        end
    end
    
    Maska{1}=Maska1;
    Maska{2}=Maska2;
    Maska{3}=Maska3;
    Maska{4}=Maska4;
    Maska{5}=Maska5;
    Maska{6}=Maska6;
end