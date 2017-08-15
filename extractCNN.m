% Author: Yong Yuan
% Homepage: yongyuan.name
% If matconvnet-1.0-beta18 is used, and get the error "Reference to
% non-existent field 'precious'". You must download the lastest pre-trained model
% https://github.com/vlfeat/matconvnet/issues/389

clear all;close all;clc;

% version: matconvnet-1.0-beta17
%run ./matconvnet-1.0-beta17/matlab/vl_compilenn
run ./matconvnet-1.0-beta17/matlab/vl_setupnn

%% Step 1 lOADING PATHS
path_imgDB = './database/';
addpath(path_imgDB);
addpath tools;

% viesion: matconvnet-1.0-beta17
net = load('imagenet-vgg-f.mat') ;

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
       im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
       im_ = im_ - net.meta.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       
       % viesion: matconvnet-1.0-beta17
       featVec = res(20).x;
       
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   else
       im_ = single(repmat(oriImg,[1 1 3])) ; % note: 255 range
       im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
       im_ = im_ - net.meta.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       
       % viesion: matconvnet-1.0-beta17
       featVec = res(20).x;
       
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
   end
end

% reduce demension by PCA, recomend to reduce it to 128 dimension.
%[coeff, score, latent] = princomp(feat);
%feat = feat*coeff(:, 1:128);

feat_norm = normalize1(feat);
save('feat4096Norml.mat','feat_norm', 'imgNamList', '-v7.3');
