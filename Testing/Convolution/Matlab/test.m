clc;
clear all;
close all;

img = imread('C:\Users\asus2\Desktop\FPGA\Testing & Matching\Convolution\images.png');

gray_img = rgb2Gray2Mat(img);

imshow(gray_img);

save gray_img.mat

data = load('gray_img.mat');

dlmwrite('C:\Users\asus2\Desktop\FPGA\Testing & Matching\Convolution\mat_input.txt',data.gray_img,'delimiter','\t');

%Reading from Text files

image = dlmread('C:\Users\asus2\Desktop\FPGA\Testing & Matching\Convolution\mat_input.txt');

W = dlmread('C:\Users\asus2\Desktop\FPGA\Testing & Matching\Convolution\filter_input2.txt');

b = dlmread('C:\Users\asus2\Desktop\FPGA\Testing & Matching\Convolution\bias.txt');

%Convolution Operation

conv = cnn2dConvolution(image,W,b);

imshow(conv);

save conv.mat

data = load('conv.mat');

dlmwrite('conv_output.txt',data.conv,'delimiter','\t');