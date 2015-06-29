% Author: Yong Yuan
% Homepage: yongyuan.name

clear all;close all;clc;

% viesion: matconvnet-1.0-beta10
%run ./matconvnet-1.0-beta10/matlab/vl_setupnn

% viesion: matconvnet-1.0-beta12
run ./matconvnet-1.0-beta12/matlab/vl_setupnn

%% Step 1 lOADING PATHS
path_imgDB = './database/';
addpath(path_imgDB);
addpath tools;

% viesion: matconvnet-1.0-beta10
%net = load('I:/E/科研代码/imagenetMat/imagenet-vgg-f.mat') ;

% viesion: matconvnet-1.0-beta12
net = load('I:/E/科研代码/CNN-for-Image-Retrieval/beta12/imagenet-vgg-f.mat') ;

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
       
       % viesion: matconvnet-1.0-beta10
       %featVec = res(19).x;
       % viesion: matconvnet-1.0-beta12
       featVec = res(20).x;
       
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   else
       im_ = single(repmat(oriImg,[1 1 3])) ; % note: 255 range
       im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
       im_ = im_ - net.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       
       % viesion: matconvnet-1.0-beta10
       %featVec = res(19).x;
       % viesion: matconvnet-1.0-beta12
       featVec = res(20).x;
       
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   end
end

feat_norm = normalize1(feat);
save('feat4096Norml.mat','feat_norm', 'imgNamList', '-v7.3');