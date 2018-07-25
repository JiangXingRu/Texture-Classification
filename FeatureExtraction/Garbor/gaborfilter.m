function [ G,gabout ] = gaborfilter( I,Sx,Sy,U,V )
%The Gabor filter is basically a Gaussian(with variances sx and sy along x and y-axes respectively)
%modulated by a complex sinusoid (with center frequencies Uand V along x and y-axes respectively)
%described by the following equation
% G(x,y) = (1 / (2*pi*Sx*Sy)) * exp(-((x/Sx)^2+(y/Sy)^2)/2 + 2*pi*i*(Ux+Vy))

%% Describtion:
% I     : Input image
% Sx&Sy : Variances along x and y-axes respectively
% U & V : Center frequencies along x and y-axes respectively
% G     : The output filter as described above
%gabout : The output filtered image
%%
if isa(I,'double')~=1
    I = double(I);
end

for x = -fix(Sx):fix(Sx)
    for y = -fix(Sy):fix(Sy)
        G(fix(Sx)+x+1,fix(Sy)+y+1) = (1/(2*pi*Sx*Sy))*exp(-.5*((x/Sx)^2+(y/Sy)^2)+2*pi*1i*(U*x+V*y));
    end
end

Imgabout = conv2(I,double(imag(G)),'same');
Regabout = conv2(I,double(real(G)),'same');

gabout = uint8(sqrt(Imgabout.*Imgabout + Regabout.*Regabout));


end

