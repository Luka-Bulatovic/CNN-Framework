function [ CNN ] = addPoolLayer( CNN, poolDim, layerName )
%addPoolLayer adds pooling layer to existing CNN.
%   The parameter poolDim denotes stride (usually 2).

    assert(CNN.totalLayers < CNN.numLayers, ...
        'Cannot add more layers. The total number of layers is reached.');
    
    CNN.totalLayers = CNN.totalLayers + 1;
    cnt = CNN.totalLayers;
    
    CNN.layers(cnt).name = layerName;
    CNN.layers(cnt).type = 'pool';
    CNN.layers(cnt).poolDim = poolDim;
    CNN.layers(cnt).numFilters = CNN.layers(cnt-1).numFilters;
    
    CNN.layers(cnt).convDim = CNN.layers(cnt-1).convDim / poolDim;
    
    if CNN.gpumode == 0
        
        CNN.layers(cnt).activations = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize);
        CNN.layers(cnt).delta = ...
            zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize);

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;
    else
        CNN.layers(cnt).activations = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize);
        CNN.layers(cnt).delta = ...
            gpuArray.zeros(CNN.layers(cnt).convDim, CNN.layers(cnt).convDim, ... 
                CNN.layers(cnt).numFilters, CNN.minibatchSize);

        CNN.layers(cnt).outputNeurons = CNN.layers(cnt).convDim ^ 2 * ...
                CNN.layers(cnt).numFilters;
    end;
end