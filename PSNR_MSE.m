function [y,sigma]=PSNR_MSE(X,Y)
 
% Y= PSNR_RGB(X,Y)
% Computes the Peak Signal to Noise Ratio for two RGB images
% Class input : double [0,1] ,
% july ,25, 2012
% KHMOU Youssef
 
 
 
if size(X)~=size(Y)
    error('The images must have the same size');
end
 
%if ~isa(X,'double') 
%   X=double(X)./255.00;
%end
%if  ~isa(Y,'double')
%    Y=double(Y)./255.00;
%end
 
% begin
d1=max(X(:));
d2=max(Y(:));
d=double(max(d1,d2)).^2;
sigma=mean2((double(X)-double(Y)).^2);
 
y=10*log10(d./sigma);