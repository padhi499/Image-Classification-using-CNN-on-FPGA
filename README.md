# Image Classification using CNN on FPGA
Project is about designing a Trained Neural n/w (CIFAR-10 dataset) on FPGA to classify an Image I/P using deep-learning concept(CNN- Convolutional Neural Network).

There are 6 Layers(Sliding Window Convolution, ReLU Activation, Max Pooling, Flattening, Fully Connected and Softmax Activation) which decides the class of our I/P Image. Kernels/Filters are used for feature detection from an Image I/P. Image I/P can be a Greyscale/Colored one.

# Tools Used
Xilinx Vivado 17.4, Matlab R2018.a

# Tasks Achieved
1. Got some basic knowledge about FPGA and its Resources, Vivado 17.4, Matlab R2018a.
2. Verilog modules were created(Matrix Multiplication, Generic MUX, Matrix Convolution, ReLU Activation, Max Pooling) using Vivado 17.4.
3. Matrix functions were created using Matlab R2018a for reference purpose and matching results.
4. A Grey-scale Image was considered first (Took a Colored Image(3D Matrix) and Converted to Greyscale Image(2D Matrix) using Matlab) and compared results for both (Verilog modules & Matlab functions) for Matrix Multiplication and ReLU Activation. Results were matching. 

# Contributor
1. Abhinas Padhi(FPGA Design Engineer)
2. Shivkumar V(B. M. S. College of Engineering, Bangalore)
