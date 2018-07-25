function [ G,gabout ] = gaborfilter1( I,Sx,Sy,f,theta )
%The Gabor filter is basically a Gaussian(with variances sx and sy along x and y-axes respectively)
%modulated by a complex sinusoid (with center frequencies Uand V along x and y-axes respectively)
%described by the following equation
%   G(x,y,theta,f) = exp(-((x'/sx')^2+(y'/sy')^2)/2)*cos(2*pi*f*x);
%   x' = x*cos(theta)+y*sin(theta);
%   y' = y*cos(theta)+-x*sin(theta);

%% Describtion:
%I       :Input image
%Sx & Sy : Variance along x and y-axes respectively
%f       : The frquence of the sinusoidal function
%theta   : The orientation of Gabor filter
%%
if isa(I,'double')~=1
    I = double(I);
end

for x = -fix(Sx):fix(Sx)
    for y = -fix(Sy):fix(Sy)
        xPrime = x * cos(theta) + y * sin(theta);  
        yPrime = y * cos(theta) - x * sin(theta);  
        G(fix(Sx)+x+1,fix(Sy)+y+1) = exp(-.5*((xPrime/Sx)^2+(yPrime/Sy)^2))*cos(2*pi*f*xPrime);  
    end
end

Imgabout = conv2(I,double(imag(G)),'same');
Regabout = conv2(I,double(real(G)),'same');

gabout = sqrt(Imgabout.*Imgabout + Regabout.*Regabout);



end

