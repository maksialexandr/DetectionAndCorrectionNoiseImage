[im,map] = imread('example.jpeg');
[n,m,k]=size(im);
%перебор уровня шума
for p=0.1:0.1:0.3
    %генерация 6 типа шума и масок
   %[LIM,LMaska]=NoiseIM(im,p);
   %перебор типа шумов
   for type=1:6
       %IM=LIM{type};
       %Maska=LMaska{type};
       %перебор методов предсказания  для построения графиков
       
       
   end
end


