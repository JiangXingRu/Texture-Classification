function feature = gabor( I )
%��ȡ��ͬ���� ��ͬƵ�ʵ�Gabor����
f = [0.5 0.2 0.1];
theta = [0 pi/4 pi/2 3*pi/4];
Sx=32;  
Sy=32;  
% f=sqrt(2);       
% theta=pi/6;  
gim=im2double(I);
for fnumber = 1:3
    for thetanumber = 1:4
        [G1,G2,gabout1,gabout2] = gaborfilter2(gim,Sx,Sy,f(fnumber),theta(thetanumber));  
        gabout = (mapminmax(gabout2) + 1.0) / 2;
        step = 16;
        [m n] = size(gabout);      % �������ͼ��ĳߴ�
        u = m / step;              % ͼ��ķֿ���Ŀ
        v = n / step;
        for i = 1:u                 % ���任���ͼ����зֿ�����ÿ�������
            for j = 1:v
                sum = 0;
                for s = 1:step
                    for t = 1:step
                        temp = gabout(((i-1)*step+s),((j-1)*step+t));
                        sum = sum + temp * temp;                
                    end
                end 
                Cell((i-1)*v+j) = sum;       
            end
        end    
        feature{(fnumber - 1) * 4 + thetanumber} = Cell;
    end
end


% imshow(abs(real(gabout))); 

end

