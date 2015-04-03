function avergePre = avergePresion( queryID, featNorm, rgbImgList, numRetrieval)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

QueryVec = featNorm(queryID, :);
score = zeros(length(featNorm), 1);

for loop = 1:length(featNorm)
    VecTemp = featNorm(loop, :);
    score(loop) = QueryVec*VecTemp';
end

[~, index] = sort(score, 'descend');
rank_image_ID = index;

searchClass = zeros(length(featNorm), 1);

for i=1:length(featNorm)
    imName = rgbImgList{rank_image_ID(i, 1), 1};
    searchClass(i, 1) = str2double(imName(1:3));
    searchReslt{i, 1} = imName;
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

