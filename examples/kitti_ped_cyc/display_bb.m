clear all; close all;

addpath('../../matlab/');
addpath('../../utils/');

% root_dir = 'mscnn-8s-768-trainval-pretrained/';
root_dir = 'mscnn-7s-576-2x/';

% binary_file = [root_dir 'mscnn_kitti_trainval_2nd_iter_35000.caffemodel'];
binary_file = [root_dir 'mscnn_kitti_train_2nd_iter_25000.caffemodel'];

assert(exist(binary_file, 'file') ~= 0);
definition_file = [root_dir 'mscnn_deploy.prototxt'];
assert(exist(definition_file, 'file') ~= 0);
use_gpu = true;
if (~use_gpu)
  caffe.set_mode_cpu();
else
  caffe.set_mode_gpu();  
  gpu_id = 0; caffe.set_device(gpu_id);
end
% Initialize a network
net = caffe.Net(definition_file, binary_file, 'test');

% set KITTI dataset directory
root_dir = '/home/yunpeng/Documents/mscnn_mat/data/kitti/';
% image_dir = [root_dir 'testing/image_2/'];
% comp_id = 'kitti_8s_768_35k_test';
% image_list = dir([image_dir '*.png']); 
% nImg=length(image_list);

image_dir = [root_dir 'training/image_2/'];
comp_id = 'kitti_7s_576_x2_val';
% Goal: read content of file as string. Append said string with .png
image_set = load('/home/yunpeng/Documents/mscnn_mat/data/kitti/ImageSets/val.txt');
nImg=length(image_set);

% choose the right input size
% imgW = 1280; imgH = 384;
imgW = 1920; imgH = 576;
% imgW = 2560; imgH = 768;

mu = ones(1,1,3); mu(:,:,1:3) = [104 117 123];
mu = repmat(mu,[imgH,imgW,1]);

% bbox de-normalization parameters
bbox_means = [0 0 0 0];
bbox_stds = [0.1 0.1 0.2 0.2];

% non-maxisum suppression parameters
pNms.type = 'maxg'; pNms.overlap = 0.5; pNms.ovrDnm = 'union';

cls_ids = [2 3]; num_cls=length(cls_ids);
obj_names = {'bg','ped','cyc'};
final_detect_boxes = cell(nImg,num_cls); final_proposals = cell(nImg,1);
proposal_thr = -10; usedtime=0;

show = 1; show_thr = 0.1;
if (show)
  fig=figure(1); set(fig,'Position',[-50 100 1350 375]);
  h.axes = axes('position',[0,0,1,1]);
end


ped_dets_path = '../kitti_ped_cyc/detections/kitti_7s_576_x2_val_ped.txt';
ped_dets = load(ped_dets_path);




for k = 1:nImg
  % test_image = imread([image_dir image_list(k).name]);
  test_image = imread(sprintf([image_dir, '%06i.png'], image_set(k)));

  if (show)
    imshow(test_image,'parent',h.axes); axis(h.axes,'image','off'); hold(h.axes,'on');
  end
end

