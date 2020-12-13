% Following MATLAB function will take a grayscale 
% or an RGB image as input and will return a 
% binary image as output 

function [img] = conv2Mat(img) 

	[x, y, z]=size(img); 

	% if Read Image is an RGB Image then convert 
	% it to a Gray Scale Image For an RGB image 
	% the value of z will be 3 and for a Grayscale 
	% Image the value of z will be 1 

	if z==3 
		img=rgb2gray(img); 
	end

	% change the class of image 
	% array from 'unit8' to 'double' 
	%img=double(img); 

end

