clear;

% disp();
addpath(genpath('../../external/toolbox'));

X1 = imread('../../data/kitti/training/image_2/000000.png');
size(X1)
X1(:,:,:,2)=imread('/media/data1/yunpeng/kitti/training/prev_2/000000_01.png');
size(X1)

% G = rgbConvert(X1, 'gray');
% size(G)
% I = [imread('../../data/kitti/training/image_2/000000.png') 
%     imread('/media/data1/yunpeng/kitti/training/prev_2/000000_01.png')];
%     %imread('/media/data1/yunpeng/kitti/training/prev_2/000000_02.png')
%     %imread('/media/data1/yunpeng/kitti/training/prev_2/000000_03.png')];
% disp(size(I));
pflow = {'smooth',1,'radius',25,'type','LK','maxScale',1};
[J,a,b] = imagesAlignSeq(X1,pflow,2,0);
% imshow(I);
