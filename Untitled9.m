
[im,map] = imread('example.jpeg');
[n,m,k]=size(im);
array_size_for_median = [3, 3, 3, 5, 5, 7, 9, 11, 13];
for p=0.1:0.1:0.1
   [LIM,LMaska]=NoiseIM(im,p);
   for type=6
       GH = zeros(n,m);
       IM=LIM{type};

       for r=1:3     
           im1 = IM(:,:,r);

           SE = strel('square', 9);

           erode = imerode(im1, SE);
           ge = im1 - erode;

           dilate = imdilate(im1, SE);
           gd = dilate - im1;
           
           gh = ge .* gd;
           for i=1:n
                for j=1:m
                    if gh(i,j) == 0
                        gh(i,j) = 1;    
                    else
                        gh(i,j) = 0;  
                    end
                end
           end
           GH = gh|GH;

       end
       maska = LMaska{type};
 
       disp('-------1--------------------------------------------------');
       PrintErrors(maska, GH);
       
       
       mset = 50; 
       pset = 255;
       level = 0.99; 
       
       Mask=zeros(n,m);
       M11=bwmorph(IM(:,:,1)- mset,'bothat')|bwmorph(IM(:,:,2)- mset,'bothat')|bwmorph(IM(:,:,3)- mset,'bothat');
       M12=bwmorph(pset - IM(:,:,1),'bothat')|bwmorph(pset - IM(:,:,2),'bothat')|bwmorph(pset - IM(:,:,3),'bothat');
       M1=M11|M12;
       M2=bwmorph(im2bw(pset-IM(:,:,1),level)|im2bw(pset-IM(:,:,2),level)|im2bw(pset-IM(:,:,3),level),'remove');
       M3=bwmorph(im2bw(mset+IM(:,:,1),level)|im2bw(mset+IM(:,:,2),level)|im2bw(mset+IM(:,:,3),level),'remove');
       M4=bwmorph(im2bw(rgb2gray(IM),level),'bothat');
       M5=bwmorph(im2bw(rgb2gray(pset-IM),level),'bothat');
       Mask=M1|M2|M3|M4|M5;
       disp('-------10---');
       PrintErrors(maska, Mask);
        
   end
   IM=LIM{type};
   figure;
   imshow(IM);
   
   im_fixed1 = MF3(IM,GH,3);
   [y1,sigma1] = PSNR_MSE(im, im_fixed1);
   str_return = sprintf('1. p = %0.1f,  psnr = %f, sigma = %f',p, y1, sigma1);
   disp(str_return);
   figure;
   imshow(im_fixed1);
   
   %im_fixed1_without = MF4(IM,GH,array_size_for_median(uint8(p*10)));
   %[y1_im_fixed1_without,sigma1_im_fixed1_without] = PSNR_MSE(im, im_fixed1_without);
   %str_return = sprintf('1. p = %0.1f,  psnr = %f, sigma = %f (without noise)',p, y1_im_fixed1_without, sigma1_im_fixed1_without);
   %disp(str_return);
   %figure;
   %imshow(im_fixed1_without);
   
   %im_fixed2 = MF3(IM,Mask,array_size_for_median(uint8(p*10)));
   %[y2,sigma2] = PSNR_MSE(im, im_fixed2);
   %str_return = sprintf('2. p = %0.1f, psnr = %f, sigma = %f',p, y2, sigma2);
   %disp(str_return);
   %figure;
   %imshow(im_fixed2);
   
   %im_fixed2_without = MF4(IM,Mask,array_size_for_median(uint8(p*10)));
   %[y2_without,sigma2_without] = PSNR_MSE(im, im_fixed2_without);
   %str_return = sprintf('2. p = %0.1f,  psnr = %f, sigma = %f  (without noise)',p, y2_without, sigma2_without);
   %disp(str_return);
   %figure;
   %imshow(im_fixed2_without);
   
   
end


