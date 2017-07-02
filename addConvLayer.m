<<<<<<< HEAD
function [ CNN ] = addConvLayer( CNN, filterDim, numFilters, layerName )
%addConvLayer adds the convolutional layer to the existing CNN.
%    The CNN is given as parameter to the function, as well as filterDim,
%    numFilters representing dimension of filters in layer and number of
%    filters, respectively. The function returns obtained CNN.

    assert(CNN.totalLayers < CNN.numLayers, ...
        'Cannot add more layers. The total number of layers is reached.');
    
    CNN.totalLayers = CNN.totalLayers + 1;
    cnt = CNN.totalLayers;
    
    CNN.layers(cnt).name = layerName;
    CNN.layers(cnt).type = 'conv';
    CNN.layers(cnt).filterDim = filterDim;
    CNN.layers(cnt).numFilters = numFilters;
    
    if CNN.totalLayers == 1
        CNN.layers(cnt).convDim = CNN.dim;% - filterDim + 1;
        CNN.layers(cnt).filterDepth = CNN.numChannels;
    else
        CNN.layers(cnt).convDim = CNN.layers(cnt-1).convDim;% ...
            %- filterDim + 1;
        CNN.layers(cnt).filterDepth = CNN.layers(cnt-1).numFilters;
    end;
    
    
    if CNN.gpumode == 0
    
        CNN.layers(cnt).W = ... 
            zeros(filterDim, filterDim, CNN.layers(cnt).filterDepth, ... 
            CNN.layers(cnt).numFilters, 'single');

        CNN.layers(cnt).b = zeros(numFilters, 1, 'single');

        CNN.layers(cnt).activations = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');
        CNN.layers(cnt).delta = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;

        CNN.layers(cnt).W_grad = zeros(size(CNN.layers(cnt).W), 'single');
        CNN.layers(cnt).b_grad = zeros(size(CNN.layers(cnt).b), 'single');
        CNN.layers(cnt).W_active = ones(size(CNN.layers(cnt).W), 'single');
    else
        CNN.layers(cnt).W = ... 
            gpuArray.zeros(filterDim, filterDim, CNN.layers(cnt).filterDepth, ... 
            CNN.layers(cnt).numFilters, 'single');

        CNN.layers(cnt).b = gpuArray.zeros(numFilters, 1, 'single');

        CNN.layers(cnt).activations = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');
        CNN.layers(cnt).delta = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;

        CNN.layers(cnt).W_grad = gpuArray.zeros(size(CNN.layers(cnt).W), 'single');
        CNN.layers(cnt).b_grad = gpuArray.zeros(size(CNN.layers(cnt).b), 'single');
        CNN.layers(cnt).W_active = gpuArray.ones(size(CNN.layers(cnt).W), 'single');
    end;
    
=======
function [ CNN ] = addConvLayer( CNN, filterDim, numFilters, layerName )
%addConvLayer adds the convolutional layer to the existing CNN.
%    The CNN is given as parameter to the function, as well as filterDim,
%    numFilters representing dimension of filters in layer and number of
%    filters, respectively. The function returns obtained CNN.

    assert(CNN.totalLayers < CNN.numLayers, ...
        'Cannot add more layers. The total number of layers is reached.');
    
    CNN.totalLayers = CNN.totalLayers + 1;
    cnt = CNN.totalLayers;
    
    CNN.layers(cnt).name = layerName;
    CNN.layers(cnt).type = 'conv';
    CNN.layers(cnt).filterDim = filterDim;
    CNN.layers(cnt).numFilters = numFilters;
    
    if CNN.totalLayers == 1
        CNN.layers(cnt).convDim = CNN.dim;% - filterDim + 1;
        CNN.layers(cnt).filterDepth = CNN.numChannels;
    else
        CNN.layers(cnt).convDim = CNN.layers(cnt-1).convDim;% ...
            %- filterDim + 1;
        CNN.layers(cnt).filterDepth = CNN.layers(cnt-1).numFilters;
    end;
    
    
    if CNN.gpumode == 0
    
        CNN.layers(cnt).W = ... 
            zeros(filterDim, filterDim, CNN.layers(cnt).filterDepth, ... 
            CNN.layers(cnt).numFilters, 'single');

        CNN.layers(cnt).b = zeros(numFilters, 1, 'single');

        CNN.layers(cnt).activations = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');
        CNN.layers(cnt).delta = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;

        CNN.layers(cnt).W_grad = zeros(size(CNN.layers(cnt).W), 'single');
        CNN.layers(cnt).b_grad = zeros(size(CNN.layers(cnt).b), 'single');
        CNN.layers(cnt).W_active = ones(size(CNN.layers(cnt).W), 'single');
    else
        CNN.layers(cnt).W = ... 
            gpuArray.zeros(filterDim, filterDim, CNN.layers(cnt).filterDepth, ... 
            CNN.layers(cnt).numFilters, 'single');

        CNN.layers(cnt).b = gpuArray.zeros(numFilters, 1, 'single');

        CNN.layers(cnt).activations = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');
        CNN.layers(cnt).delta = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize, 'single');

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;

        CNN.layers(cnt).W_grad = gpuArray.zeros(size(CNN.layers(cnt).W), 'single');
        CNN.layers(cnt).b_grad = gpuArray.zeros(size(CNN.layers(cnt).b), 'single');
        CNN.layers(cnt).W_active = gpuArray.ones(size(CNN.layers(cnt).W), 'single');
    end;
    
>>>>>>> origin/master
end