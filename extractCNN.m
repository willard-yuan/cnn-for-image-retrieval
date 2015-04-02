% Author: Yong Yuan
% Homepage: yongyuan.name

clear all;close all;clc;

run D:/matlabTools/matconvnet-1.0-beta10/matlab/vl_setupnn  % 换成你的vl_setupnn.m具体路径

%% Step 1 lOADING PATHS
path_imgDB = './database/';
addpath(path_imgDB);
addpath tools;

net = load('imagenet-vgg-f.mat') ;  % 换成你下载的imagenet-vgg-f.mat具体路径

%% Step 2 LOADING IMAGE AND EXTRACTING FEATURE
imgFiles = dir(path_imgDB);
imgNamList = {imgFiles(~[imgFiles.isdir]).name};
clear imgFiles;
imgNamList = imgNamList';

numImg = length(imgNamList);
feat = [];
k = 0;
rgbImgList = {};

for i = 1:numImg
   oriImg = imread(imgNamList{i, 1}); 
   tmpNam = imgNamList{i, 1};
   if size(oriImg, 3) == 3
       k = k+1;
       im_ = single(oriImg) ; % note: 255 range
       im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
       im_ = im_ - net.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       featVec = res(19).x;
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
       rgbImgList{k,1} = tmpNam;
   else
       rgbImg(:,:,1) = oriImg;
       rgbImg(:,:,2) = oriImg;
       rgbImg(:,:,3) = oriImg;
       k = k+1;
       im_ = single(rgbImg) ; % note: 255 range
       im_ = imresize(im_, net.normalization.imageSize(1:2)) ;
       im_ = im_ - net.normalization.averageImage ;
       res = vl_simplenn(net, im_) ;
       featVec = res(19).x;
       featVec = featVec(:);
       feat = [feat; featVec'];
       fprintf('extract %d image\n\n', i);
       rgbImgList{k,1} = tmpNam;
       clear rgbImg;
   end
end

feat = normalize1(feat);
save('Feat4096Norml.mat','feat', 'rgbImgList', '-v7.3');