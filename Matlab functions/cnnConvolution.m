function convolvedFeatures = cnnConvolution(images, W, b)

[imageDim, imageDim, imageChannel, numImages] = size(images);
[filterDim, filterDim, filterChannel, numFilters] = size(W);
[numImages, numFilters] = size(b);
convDim = imageDim - filterDim + 1;

convolvedFeatures = zeros(convDim, convDim, numFilters, numImages);

for imageNum = 1:numImages
    for filterNum = 1:numFilters  
        
        convolvedFeatures(:,:,filterNum,imageNum) = cnnNdConvolution(images(:,:,:,imageNum),W(:,:,:,filterNum),b(imageNum,filterNum));
            
    end
end

end