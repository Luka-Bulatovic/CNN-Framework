function [ CNN ] = cnnInitParams( CNN )
%CNNINITPARAMS Summary of this function goes here
%   Detailed explanation goes here

    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'conv'
                CNN.layers(layerNum).W = 1e-1 * randn(size(CNN.layers(layerNum).W));
                CNN.layers(layerNum).W_active = ones(size(CNN.layers(layerNum).W_active));
            case 'fc'
                r  = sqrt(6) / sqrt(size(CNN.layers(layerNum).W, 1)+...
                    size(CNN.layers(layerNum).W, 2)+1);
                CNN.layers(layerNum).W = rand(size(CNN.layers(layerNum).W)) * 2 * r - r;
                CNN.layers(layerNum).W_active = ones(size(CNN.layers(layerNum).W_active));
            otherwise
                %
        end;
    end;

end