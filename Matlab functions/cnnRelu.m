% Step 2 
% takes an input image (3d array) and performs a thresholding opreation on it
% set all neg numbers to 0

function out = relu(in)  
    out = max(in, 0);
end
