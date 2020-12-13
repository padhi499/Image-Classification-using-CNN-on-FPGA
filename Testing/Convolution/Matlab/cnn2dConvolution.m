function convolvedFeature = cnn2dConvolution(image, W, b)
    
    [imageDim, imageDim] = size(image);
    
    [filterDim, filterDim] = size(W);
    
    convDim = imageDim - filterDim + 1;

    convolvedImage = zeros(convDim, convDim);

    filter = rot90(squeeze(W),2);

    im = squeeze(image(:, :));

    convolvedImage = conv2(im,filter,'valid');
    
    convolvedImage = convolvedImage + b;
    
    convolvedFeature(:, :) = convolvedImage;

end