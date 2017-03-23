clear all; close all; clc;
addpath('tools');

db_name = '256_ObjectCategories'; % '256_ObjectCategories' as a option
numRetrieval = 10;

% load dataset
if strcmp(db_name, 'faceDataset')
    load feat4096Norml.mat;
    path_imgDB = './faceDataset/';
    addpath(path_imgDB);
    queryID = 1900;
elseif strcmp(db_name, '256_ObjectCategories')
    %load 256feat2048Norml.mat; % 0.495471
    % load 256feat4096Norml.mat; % 0.484413
    load feat4096Norml.mat;
    path_imgDB = './database/';
    addpath(path_imgDB);
    %example
    queryID = 1; %
end

%if not normalize, then do
% featNorm = normalize1(feat);
% save('feat4096Norml.mat','featNorm', 'rgbImgList');

% [pc, ~] = eigs(double(cov(feat)), 128);
% feat = feat*pc;

%virsulazation
retrieval_virsulazation( queryID, numRetrieval, feat_norm, imgNamList);
