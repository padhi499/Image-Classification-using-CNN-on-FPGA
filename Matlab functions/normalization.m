% Step 1 
% takes an input image (3d array) and normalizes it. 
% the output values should be between -.5 and .5

function out = normalization(in)
    out = in/255.0 - .5;
end