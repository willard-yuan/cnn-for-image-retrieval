% 下面mAP的具体计算过程请参阅：http://yongyuan.name/blog/evaluation-of-information-retrieval.html

clear;clear all;
addpath('./database/');

queryFile = './queryImgs.txt';
classesFile = './databaseClasses.txt';
load feat4096Norml.mat

N = 9; % 如果用于论文中，把这个值设为你所用数据库的大小

fid = fopen(queryFile,'rt');
queryImgs = textscan(fid, '%s');
fclose(fid);

fid = fopen(classesFile,'rt');
classesAndNum = textscan(fid, '%s %d');
fclose(fid);

for i = 1:length(classesAndNum{1, 1})
    classes{i,1} = classesAndNum{1, 1}{i,1}(1:3);
end

[numImg,d] = size(feat_norm);
querysNum = length(queryImgs{1, 1});

ap = zeros(querysNum,1);

for i =1:querysNum
    queryName = queryImgs{1, 1}{i, 1};
    queryClass = queryName(1:3);
    
    [row,col]=ind2sub(size(imgNamList),strmatch(queryName,imgNamList,'exact'));
    queryFeat = feat_norm(row, :);
    
    [row1,col1]=ind2sub(size(classesAndNum{1, 1}),strmatch(queryClass,classes,'exact'));
    queryClassNum = double(classesAndNum{1, 2}(row1,1));
    
    %dist = distMat(queryFeat,feat_norm);
    %dist = dist';
    %[~, rank] = sort(dist, 'ascend');
    
    dist = zeros(numImg, 1);
    for j = 1:numImg
        VecTemp = feat_norm(j, :);
        dist(j) = queryFeat*VecTemp';
    end
    [~, rank] = sort(dist, 'descend');
    
    similarTerm = 0;
    
    precision = zeros(N,1);
    
    for k = 1:N
        topkClass = imgNamList{rank(k, 1), 1}(1:3);        
        if strcmp(queryClass,topkClass)==1;
            similarTerm = similarTerm+1;
            precision(k,1) = similarTerm/k;
        end
    end
    
    
    for k = 1:N
        topkClass = imgNamList{rank(k, 1), 1}(1:3); 
        % use for configure
        subplot(4,3,k);
        im = imread(imgNamList{rank(k, 1), 1});
        imshow(im);
    end
    

    ap(i,1) = sum(precision)/queryClassNum;
    
    fprintf('%s ap is %f \n',queryName,ap(i,1));
    
end

mAP = sum(ap)/querysNum;
fprintf('mAP is %f \n',mAP);
