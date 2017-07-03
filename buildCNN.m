function [ CNN ] = buildCNN( numLayers, minibatch, dataset, activation, gpumode )
%buildCNN initializes CNN
%   Loads images and labels, initializes parameters refering them, and
%   initializes layers array so that layers can later be added.

    addpath '../cifar-10-batches-mat/';
    addpath '../common/';
    
    CNN.gpumode = gpumode;
    CNN.numLayers = numLayers;
    
    if strcmp(dataset, 'mnist')==1
        CNN.images = loadMNISTImages('common/train-images-idx3-ubyte');
        CNN.labels = loadMNISTLabels('common/train-labels-idx1-ubyte');
        
        CNN.testImages = loadMNISTImages('common/t10k-images-idx3-ubyte');
        CNN.testLabels = loadMNISTLabels('common/t10k-labels-idx1-ubyte');
    elseif strcmp(dataset, 'cifar')==1
        [CNN.images, CNN.labels, CNN.testImages, CNN.testLabels] = ...
            loadCIFARImages();
    elseif strcmp(dataset, 'faces')==1
        [CNN.images, CNN.testImages] = loadFACESImages();
        [CNN.labels, CNN.testLabels] = loadFACESLabels();
    end;
    
    CNN.activation = activation;
    CNN.dim = size(CNN.images, 1);
    if strcmp(dataset, 'faces')==1
        CNN.dim = 20;
    end;
    CNN.numClasses = max(CNN.labels(:));
    CNN.totalLayers = 0; %denotes the number of layers currently in CNN
    
    %Check if pictures are single-channel or multi-channel
    if (size(CNN.images, 4) == 1)
        CNN.numImages = size(CNN.images, 3);
        CNN.numChannels = 1;
    else
        CNN.numImages = size(CNN.images, 4);
        CNN.numChannels = size(CNN.images, 3);
    end;
    
    CNN.minibatchSize = minibatch; %
    
    %Initialize layer variables
    CNN.layers(1).name = '';
    CNN.layers(1).type = '';
    CNN.layers(1).filterDim = 0;
    CNN.layers(1).numFilters = 0;
    CNN.layers(1).poolDim = 0;
    CNN.layers(1).convDim = 0;
    CNN.layers(1).W = 0;
    CNN.layers(1).b = 0;
    CNN.layers(1).W_grad = 0;
    CNN.layers(1).b_grad = 0;
    CNN.layers(1).activations = [];
    CNN.layers(1).delta = [];
    CNN.layers(1).W_active = [];
    CNN.layers(1).outputNeurons = 0;
    %Possibly something else will be added in layers
    
    
    CNN.delta_conv = [];
    %Extend layers array to numLayers elements
    CNN.layers(numLayers).name = '';
    
    
    if (CNN.gpumode==1)
        CNN.images=gpuArray(CNN.images);
        CNN.labels=gpuArray(CNN.labels);
        CNN.testImages=gpuArray(CNN.testImages);
        CNN.testLabels=gpuArray(CNN.testLabels);
        
        for i=1:numLayers
            CNN.layers(i).W = gpuArray(CNN.layers(i).W);
            CNN.layers(i).b = gpuArray(CNN.layers(i).b);
            CNN.layers(i).W_grad = gpuArray(CNN.layers(i).W_grad);
            CNN.layers(i).b_grad = gpuArray(CNN.layers(i).b_grad);
            CNN.layers(i).activations = gpuArray(CNN.layers(i).activations);
            CNN.layers(i).delta = gpuArray(CNN.layers(i).delta);
            CNN.layers(i).W_active = gpuArray(CNN.layers(i).W_active);
        end;
        CNN.delta_conv = gpuArray(CNN.delta_conv);
    end;
    
    
    
end