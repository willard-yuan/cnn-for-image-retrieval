function retrieval_virsulazation_tags( queryID, numRetrieval, featNorm, rgbImgList, queryClass, rgbImgListClass)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% virsulazation

QueryVec = featNorm(queryID, :);
score = zeros(length(featNorm), 1);

for loop = 1:length(featNorm)
    VecTemp = featNorm(loop, :);
    score(loop) = QueryVec*VecTemp';
end

[~, index] = sort(score, 'descend');
rank_image_ID = index;

k = 0;

I2 = uint8(zeros(100, 100, 3, numRetrieval)); % 32 and 32 are the size of the output image
for i=1:length(rank_image_ID)
    imName = rgbImgList{rank_image_ID(i, 1), 1};
    imClass = rgbImgListClass(1:3, rank_image_ID(i, 1));
    shareClass = intersect(imClass, queryClass);
    if length(shareClass)>=1
        im = imread(imName);
        im = imresize(im, [100 100]);
        k = k+1;
        if (ndims(im)~=3)
            I2(:, :, 1, k) = im;
            I2(:, :, 2, k) = im;
            I2(:, :, 3, k) = im;
        else
            I2(:, :, :, k) = im;
        end
    end
    if k == numRetrieval
        break;
    end
end

figure;
montage(I2(:, :, :, (1:numRetrieval)));
title('search result');

QueryName = rgbImgList{queryID, 1};
im = imread(QueryName);
imQuery = imresize(im, [100 100]);
figure;
imshow(imQuery);
title('query image');

end