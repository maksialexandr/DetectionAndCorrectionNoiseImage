function [GH] = M_D_5(IM)
    [n,m,v] = size(IM);
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
    GH=M1|M2|M3|M4|M5;


