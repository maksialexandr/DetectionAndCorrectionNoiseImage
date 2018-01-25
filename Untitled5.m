
[im,map] = imread('I15.BMP');
[n,m,k]=size(im);

for p=0.1
   [LIM,LMaska]=NoiseIM(im,p);
   for type=1
       GH = zeros(n,m);
       MRes = zeros(n,m);
       IM=LIM{type};
       %figure;
       %imshow(IM);
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
           
          
                    
           %SE = strel('line', 5, 5);

           %erode = imerode(im1, SE);
           %erode_dilate = imdilate(erode, SE);

           %dilate = imdilate(im1, SE);
           %dilate_erode = imerode(dilate, SE);

           %WTT = im1 - erode_dilate;
           %BTT = dilate_erode - im1;
           %M = zeros(n,m);
           %for i=1:n
           %     for j=1:m
           %         if WTT(i,j) > BTT(i,j)
           %             M(i,j) = WTT(i,j);     
           %         else
           %             M(i,j) = BTT(i,j); 
           %         end
           %     end
           %end
           %for i=1:n
            %    for j=1:m
           %         if M(i,j) > 5
           %             M(i,j) = 1;     
           %         else
           %             M(i,j) = 0; 
           %         end
           %     end
           %end
           %MRes = M|MRes;
       end
       maska = LMaska{type};
       %sum(sum(maska))
       %sum(sum(GH))
 
       disp('-------1-----------------');
       PrintError(maska, GH);
       
       %disp('-------2-----------------');
       %PrintErrors(maska, MRes);
       
       mset = 50; 
       pset = 255;
       level = 0.99; 

       %M11 = bwmorph(IM(:,:,1)- mset,'bothat')|bwmorph(IM(:,:,2)- mset,'bothat')|bwmorph(IM(:,:,3)- mset,'bothat');
       %disp('-------3-----------------');
       %PrintErrors(maska, M11);
       
       %M12 = bwmorph(pset - IM(:,:,1),'bothat')|bwmorph(pset - IM(:,:,2),'bothat')|bwmorph(pset - IM(:,:,3),'bothat');
       %M1 = M11|M12;
       %disp('-------4-----------------');
       %PrintErrors(maska, M1);
       
       %M11_plus_mset = bwmorph(IM(:,:,1) + mset,'tophat')|bwmorph(IM(:,:,2) + mset,'tophat')|bwmorph(IM(:,:,3) + mset,'tophat');
       %disp('-------5.1-----------------');
       %PrintErrors(maska, M11_plus_mset);
       
       %M11_minus_mset = bwmorph(IM(:,:,1) - mset,'tophat')|bwmorph(IM(:,:,2) - mset,'tophat')|bwmorph(IM(:,:,3) - mset,'tophat');
       %disp('-------5.2-----------------');
       %PrintErrors(maska, M11_minus_mset);
       
       %M12_minus_pset = bwmorph(mset - IM(:,:,1),'tophat')|bwmorph(pset - IM(:,:,2),'tophat')|bwmorph(pset - IM(:,:,3),'tophat');
       %disp('-------6-----------------');
       %PrintErrors(maska, M12_minus_pset);
       
       %M11_or_M11_plus_mset = M11|M11_plus_mset;
       %disp('-------7.1-----------------');
       %PrintErrors(maska, M11_or_M11_minus_mset);
       
       %M11_or_M11_minus_mset = M11|M11_minus_mset;
       %disp('-------7.2-----------------');
       %PrintErrors(maska, M11_or_M11_minus_mset);
       
       %M1_or_M11_plus_mset = M11|M11_plus_mset;
       %disp('-------8.1-----------------');
       %PrintErrors(maska, M1_or_M11_plus_mset);
       
       %M1_or_M11_minus_mset = M11|M11_minus_mset;
       %disp('-------8.2-----------------');
       %PrintErrors(maska, M1_or_M11_minus_mset);
       
       Mask=zeros(n,m);
       M11=bwmorph(IM(:,:,1)- mset,'bothat')|bwmorph(IM(:,:,2)- mset,'bothat')|bwmorph(IM(:,:,3)- mset,'bothat');
       M12=bwmorph(pset - IM(:,:,1),'bothat')|bwmorph(pset - IM(:,:,2),'bothat')|bwmorph(pset - IM(:,:,3),'bothat');
       M1=M11|M12;
       M2=bwmorph(im2bw(pset-IM(:,:,1),level)|im2bw(pset-IM(:,:,2),level)|im2bw(pset-IM(:,:,3),level),'remove');
       M3=bwmorph(im2bw(mset+IM(:,:,1),level)|im2bw(mset+IM(:,:,2),level)|im2bw(mset+IM(:,:,3),level),'remove');
       M4=bwmorph(im2bw(rgb2gray(IM),level),'bothat');
       M5=bwmorph(im2bw(rgb2gray(pset-IM),level),'bothat');
       Mask=M1|M2|M3|M4|M5;
       disp('-------10-----------------');
       PrintError(maska, Mask);
        
   end
   %IM=LIM{type};
   %figure;
   %imshow(IM);
   %im_fixed1 = MF2(IM,GH);
   %[y,sigma] = PSNR_MSE(im, im_fixed1)
   %figure;
   %imshow(im_fixed1);
   
   %im_fixed3 = MF2(IM,M12_minus_pset);
   %figure;
   %imshow(im_fixed3);
   %[y,sigma] = PSNR_MSE(im, im_fixed3)
   
end


