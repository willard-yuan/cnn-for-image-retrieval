function retrieval_virsulazation( queryID, numRetrieval, featNorm, rgbImgList)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% virsulazation

QueryVec = featNorm(queryID, :);
[n,d] = size(featNorm);
score = zeros(n, 1);

%for loop = 1:n
%    VecTemp = featNorm(loop, :);
%    score(loop) = QueryVec*VecTemp';
%end

score = (QueryVec*featNorm')';

[~, index] = sort(score, 'descend');
rank_image_ID = index;

I2 = uint8(zeros(100, 100, 3, numRetrieval)); % 32 and 32 are the size of the output image
for i=1:numRetrieval
    imName = rgbImgList{rank_image_ID(i, 1), 1};
    im = imread(imName);
    im = imresize(im, [100 100]);
    if (ndims(im)~=3)
        I2(:, :, 1, i) = im;
        I2(:, :, 2, i) = im;
        I2(:, :, 3, i) = im;
    else
        I2(:, :, :, i) = im;
    end
end

figure('color',[1,1,1]);
montage(I2(:, :, :, (1:numRetrieval)));
title('search result');

QueryName = rgbImgList{queryID, 1};
im = imread(QueryName);
imQuery = imresize(im, [100 100]);
figure('color',[1,1,1]);
imshow(imQuery);
title('query image');


end
