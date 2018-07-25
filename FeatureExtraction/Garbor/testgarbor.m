clear all;
clc;
ori=imread('lena.jpg');  
% grayimg=rgb2gray(ori);  
gim=im2double(ori);   
  
Sx=32;  
Sy=32;  
f=sqrt(8);  
theta=pi/2;  
u=4;  
v=4;  
%[G,gabout] = gaborfilter1(gim,Sx,Sy,f,theta);  
[G,gabout] = gaborfilter1(gim,Sx,Sy,u,v);  
  
imshow(real(G));  
% imshow(gabout); 