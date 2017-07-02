function [ CNN ] = cnnFullBackwd( CNN, layerNum )
%CNNFULLBACKWD Summary of this function goes here
%   Detailed explanation goes here

    delta_prethodnog = (CNN.layers(layerNum).W' * CNN.layers(layerNum).delta);

    if strcmp(CNN.layers(layerNum-1).type, 'fc') == 0
        CNN.layers(layerNum-1).delta = reshape(delta_prethodnog, ...
            size(CNN.layers(layerNum-1).delta));
    else
        CNN.layers(layerNum-1).delta = delta_prethodnog .* ...
            cnnFuncGradient(CNN.layers(layerNum-1).act_z, CNN.activation);
    end
end