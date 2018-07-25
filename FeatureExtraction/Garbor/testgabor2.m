clear all
clc
close all
ori=imread('lena.jpg');  
gim=im2double(ori);     
Sx=32;  
Sy=32;  
f=sqrt(2);  
theta=pi/6;  
u=8;  
v=0;  
%[G,gabout] = gaborfilter1(gim,Sx,Sy,f,theta);  
%[G,gabout] = gaborfilter1(gim,Sx,Sy,u,v);  
[G1,G2,gabout1,gabout2] = gaborfilter2(gim,Sx,Sy,f,theta);  
  
R=real(G2);  
k=127.5/max(max(abs(R)));  
imshow(uint8(k*R+127.5));  
%imshow(real(G2));  
figure;
gabout = mapminmax(gabout1);
% imshow(abs(real(gabout))); 
imshow(abs(real(gabout + 1)/2)); 