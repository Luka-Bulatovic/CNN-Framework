function [ CNN ] = cnnUnpool( CNN, layerNum )
%CNNUNPOOL Summary of this function goes here
%   Detailed explanation goes here

    poolDim = CNN.layers(layerNum).poolDim;

    for imageNum=1:CNN.minibatchSize
        for filterNum=1:CNN.layers(layerNum).numFilters
            CNN.layers(layerNum-1).delta(:,:,filterNum,imageNum)=(1/poolDim^2)*...
                kron(CNN.layers(layerNum).delta(:,:,filterNum,imageNum),ones(poolDim,poolDim)); % upsampling
        end
    end
    
    CNN.layers(layerNum-1).delta = CNN.layers(layerNum-1).delta .* ...
        cnnFuncGradient(CNN.layers(layerNum-1).activations, CNN.activation);
end