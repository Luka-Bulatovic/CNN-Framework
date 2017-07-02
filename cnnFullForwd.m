function [ CNN ] = cnnFullForwd( CNN, layerNum )
%CNNFULLFORWD Summary of this function goes here
%   Detailed explanation goes here

    CNN.layers(layerNum).W = CNN.layers(layerNum).W .* CNN.layers(layerNum).W_active;

	act = reshape(CNN.layers(layerNum-1).activations, [], CNN.minibatchSize);
    
    CNN.layers(layerNum).activations = ... 
            bsxfun(@plus,CNN.layers(layerNum).W * act, CNN.layers(layerNum).b);
    
%     tmp = max(CNN.layers(layerNum).activations(:)) / 10;
%     CNN.layers(layerNum).activations = 1/tmp * CNN.layers(layerNum).activations;
     %provjera je li softmax layer ili obican
    
    if strcmp(CNN.layers(layerNum).name, 'Softmax') == 1
        CNN.layers(layerNum).activations = exp(CNN.layers(layerNum).activations);
        CNN.layers(layerNum).activations = bsxfun(@rdivide,CNN.layers(layerNum).activations,sum(CNN.layers(layerNum).activations,1));
    else
        CNN.layers(layerNum).act_z = CNN.layers(layerNum).activations;
        CNN.layers(layerNum).activations = cnnFuncActivation(CNN.layers(layerNum).activations, CNN.activation);
    end
end