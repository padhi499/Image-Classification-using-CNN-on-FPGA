function convolvedFeature = cnnNdConvolution(image, W, b)

[imageDim, imageDim, imageChannel] = size(image);
[filterDim, filterDim, filterChannel] = size(W);

convDim = imageDim - filterDim + 1;

convolvedFeature = zeros(convDim, convDim);

for channel = 1:filterChannel
    
    convolvedImage(:,:,channel) = cnn2dConvolution(image(:,:,channel),W(:,:,channel),b);
    
    convolvedFeature = convolvedFeature + convolvedImage(:,:,channel);
    
end

end