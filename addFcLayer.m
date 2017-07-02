function [ CNN ] = addFcLayer( CNN, outputNeurons, layerName )
%addFcLayer(CNN,outputNeurons,layerName) adds fully-connected layer to the existing CNN.
%   Parameter outputNeurons specifies the number of neurons we want this
%   layer to have as output. If this layer is the last one added to
%   network, it is automatically considered a soft-max layer, and the
%   number of its output neurons is equal to the number of classes -
%   numClasses.

    assert(CNN.totalLayers < CNN.numLayers, ...
        'Cannot add more layers. The total number of layers is reached.');
    
    CNN.totalLayers = CNN.totalLayers + 1;
    cnt = CNN.totalLayers;
    
    CNN.layers(cnt).name = layerName;
    CNN.layers(cnt).type = 'fc';
    
    if cnt == CNN.numLayers
        CNN.layers(cnt).outputNeurons = CNN.numClasses; %OK
    else
        CNN.layers(cnt).outputNeurons = outputNeurons; %OK
    end
    
    
    if CNN.gpumode == 0
    
        CNN.layers(cnt).W = ... 
            zeros(CNN.layers(cnt).outputNeurons, CNN.layers(cnt-1).outputNeurons); %OK

        CNN.layers(cnt).b = zeros(CNN.layers(cnt).outputNeurons, 1); %?

        CNN.layers(cnt).activations = ...
            zeros(CNN.layers(cnt).outputNeurons, CNN.minibatchSize);
        CNN.layers(cnt).delta = ...
            zeros(CNN.layers(cnt).outputNeurons, CNN.minibatchSize);

        CNN.layers(cnt).W_grad = zeros(size(CNN.layers(cnt).W));
        CNN.layers(cnt).b_grad = zeros(size(CNN.layers(cnt).b));
        CNN.layers(cnt).W_active = ones(size(CNN.layers(cnt).W));
    else
        CNN.layers(cnt).W = ... 
            gpuArray.zeros(CNN.layers(cnt).outputNeurons, CNN.layers(cnt-1).outputNeurons); %OK

        CNN.layers(cnt).b = gpuArray.zeros(CNN.layers(cnt).outputNeurons, 1);
        CNN.layers(cnt).activations = ...
            gpuArray.zeros(CNN.layers(cnt).outputNeurons, CNN.minibatchSize);
        CNN.layers(cnt).delta = ...
            gpuArray.zeros(CNN.layers(cnt).outputNeurons, CNN.minibatchSize);

        CNN.layers(cnt).W_grad = gpuArray.zeros(size(CNN.layers(cnt).W));
        CNN.layers(cnt).b_grad = gpuArray.zeros(size(CNN.layers(cnt).b));
        CNN.layers(cnt).W_active = gpuArray.ones(size(CNN.layers(cnt).W));
    end
end