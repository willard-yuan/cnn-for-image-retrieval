% Author: Yong Yuan
% Homepage: yongyuan.name

clear all;close all;clc;

run ./matconvnet-1.0-beta10/matlab/vl_setupnn

%% Step 1 lOADING PATHS
path_imgDB = './database/';
addpath(path_imgDB);
addpath tools;

net = load('D:/matlabTools/matconvnet-1.0-beta10/matlab/test/imagenet-vgg-verydeep-16.mat') ;

%% Step 2 LOADING IMAGE AND EXTRACTING FEATURE
imgFiles = dir(path_imgDB);
imgNamList = {imgFiles(~[imgFiles.isdir]).name};
clear imgFiles;
imgNamList = imgNamList';

numImg = length(imgNamList);
feat = [];
rgbImgList = {};

%parpool;

%parfor i = 1:numImg
for i = 1:numImg
   oriImg = imread(imgNamList{i, 1}); 
   if size(oriImg, 3) == 3
       im_ = single(oriImg) ; % note: 255 range
       im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
       im_ = im_ - net.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       featVec = res(36).x;
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   else
       im_ = single(repmat(oriImg,[1 1 3])) ; % note: 255 range
       im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
       im_ = im_ - net.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       featVec = res(36).x;
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   end
end

feat_norm = normalize1(feat);
save('feat4096Norml.mat','feat_norm', 'imgNamList', '-v7.3');