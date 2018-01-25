function [GH] = M_D_5_1(IM)
    [n,m,v] = size(IM);
    mset = 50; 
    pset = 255;
    level = 0.99; 
    
    Mask=zeros(n,m);
    M11=bwmorph(IM(:,:,1)- mset,'bothat')|bwmorph(IM(:,:,2)- mset,'bothat')|bwmorph(IM(:,:,3)- mset,'bothat');
    M12=bwmorph(pset - IM(:,:,1),'bothat')|bwmorph(pset - IM(:,:,2),'bothat')|bwmorph(pset - IM(:,:,3),'bothat');
    M1=M11|M12;
    GH=M1;


