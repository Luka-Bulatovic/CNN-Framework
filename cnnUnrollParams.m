function [ vect, vect_active ] = cnnUnrollParams( CNN, mode )
%CNNUNROLLPARAMS Summary of this function goes here
%   Detailed explanation goes here

    vect=[];
    vect_active = [];
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                if mode == 1
                    vect = [vect ; CNN.layers(layerNum).W(:)];
                    vect_active = [vect_active ; CNN.layers(layerNum).W_active(:)];
                else
                    vect = [vect ; CNN.layers(layerNum).W_grad(:)];
                end
        end
    end

    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                if mode == 1
                    vect = [vect ; CNN.layers(layerNum).b(:)];
                else
                    vect = [vect ; CNN.layers(layerNum).b_grad(:)];
                end
        end
    end

end

