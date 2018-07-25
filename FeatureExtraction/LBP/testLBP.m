
      I=imread('lena.jpg');
%       mapping=getmapping(8,'u2'); 
%       H1=LBP(I,1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood
%                                  %using uniform patterns
%       subplot(2,1,1),stem(H1);

      H2=lbp(I);
      subplot(1,2,1),stem(H2);

      SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
      I2=lbp(I,SP,0,'i'); %LBP code image using sampling points in SP
                          %and no mapping. Now H2 is equal to histogram
                          %of I2.
                          subplot(1,2,2);
      imshow(I2);