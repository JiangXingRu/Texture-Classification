clear all; close all; clc;

img=double(imread('lena.jpg'));
imshow(img,[]);
[m n]=size(img);

img=sqrt(img);      %٤��У��

%���������Ե
fy=[-1 0 1];        %������ֱģ��
fx=fy';             %����ˮƽģ��
Iy=imfilter(img,fy,'replicate');    %��ֱ��Ե
Ix=imfilter(img,fx,'replicate');    %ˮƽ��Ե
Ied=sqrt(Ix.^2+Iy.^2);              %��Եǿ��
Iphase=Iy./Ix;              %��Եб�ʣ���ЩΪinf,-inf,nan������nan��Ҫ�ٴ���һ��


%��������cell
step=32;                     %step*step��������Ϊһ����Ԫ
orient=9;                    %����ֱ��ͼ�ķ������
jiao=360/orient;             %ÿ����������ĽǶ���
Cell=cell(1,1);              %���еĽǶ�ֱ��ͼ,cell�ǿ��Զ�̬���ӵģ�����������һ��
ii=1;                      
jj=1;
for i=1:step:m               %��������m/step���������������i=1:step:m-step
    ii=1;
    for j=1:step:n           %ע��ͬ��
        tmpx=Ix(i:i+step-1,j:j+step-1);
        tmped=Ied(i:i+step-1,j:j+step-1);
        tmped=tmped/sum(sum(tmped));        %�ֲ���Եǿ�ȹ�һ��
        tmpphase=Iphase(i:i+step-1,j:j+step-1);
        Hist=zeros(1,orient);               %��ǰstep*step���ؿ�ͳ�ƽǶ�ֱ��ͼ,����cell
        for p=1:step
            for q=1:step
                if isnan(tmpphase(p,q))==1  %0/0��õ�nan�����������nan������Ϊ0
                    tmpphase(p,q)=0;
                end
                ang=atan(tmpphase(p,q));    %atan�����[-90 90]��֮��
                ang=mod(ang*180/pi,360);    %ȫ��������-90��270
                if tmpx(p,q)<0              %����x����ȷ�������ĽǶ�
                    if ang<90               %����ǵ�һ����
                        ang=ang+180;        %�Ƶ���������
                    end
                    if ang>270              %����ǵ�������
                        ang=ang-180;        %�Ƶ��ڶ�����
                    end
                end
                ang=ang+0.0000001;          %��ֹangΪ0
                Hist(ceil(ang/jiao))=Hist(ceil(ang/jiao))+tmped(p,q);   %ceil����ȡ����ʹ�ñ�Եǿ�ȼ�Ȩ
            end
        end
        %Hist=Hist/sum(Hist);    %����ֱ��ͼ��һ������һ������û�У���Ϊ�����block�Ժ��ٽ��й�һ���Ϳ���
        Cell{ii,jj}=Hist;       %����Cell��
        ii=ii+1;                %���Cell��y����ѭ������
    end
    jj=jj+1;                    %���Cell��x����ѭ������
end

%��������feature,2*2��cell�ϳ�һ��block,û����ʽ����block
[m n]=size(Cell);
feature=cell(1,(m-1)*(n-1));
for i=1:m-1
   for j=1:n-1           
        f=[];
        f=[Cell{i,j}(:)' Cell{i,j+1}(:)' Cell{i+1,j}(:)' Cell{i+1,j+1}(:)'];
	    f=f./sum(f);%��һ��
        feature{(i-1)*(n-1)+j}=f;
   end
end

% %���˽�����feature��Ϊ����
% %������Ϊ����ʾ��д��
% l=length(feature);
% f=[];
% for i=1:l
%     f=[f;feature{i}(:)'];  
% end 
% figure
% mesh(f)