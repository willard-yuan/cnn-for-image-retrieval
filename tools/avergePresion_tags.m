function avergePre = avergePresion_tags( queryID, numRetrieval, featNorm, rgbImgList, rgbImgListClass)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% virsulazation

QueryVec = featNorm(queryID, :);
score = zeros(length(featNorm), 1);

QueryName = rgbImgList{queryID, 1};
queryClass = extractTagsFunc( QueryName );

for loop = 1:length(featNorm)
    VecTemp = featNorm(loop, :);
    score(loop) = QueryVec*VecTemp';
end

[~, index] = sort(score, 'descend');
rank_image_ID = index;

k = 0;

searchClass = zeros(numRetrieval, 1);

for i=1:length(rank_image_ID)
    imName = rgbImgList{rank_image_ID(i, 1), 1};
    imClass = rgbImgListClass(1:3, rank_image_ID(i, 1));
    shareClass = intersect(imClass, queryClass);
    if length(shareClass)>=1
        k = k+1;
        searchClass(k, 1) = str2double(imName(1:3));
    end
    if k == numRetrieval
        break;
    end
end

% computer MAP
avergePre = 0;
similarNum = 0;
ifsimilar = zeros(numRetrieval, 1);
QueryName = rgbImgList{queryID, 1};
QueryClass = str2double(QueryName(1:3));
for i=1:numRetrieval
    if QueryClass == searchClass(i,1)
       similarNum = similarNum+1;
       avergePre = avergePre+similarNum/i;
       ifsimilar(i, 1) = 1;
    else
        continue;
    end
end

avergePre = avergePre/numRetrieval;
% fprintf('average presion is %f\n', avergePre);

end