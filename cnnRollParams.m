<<<<<<< HEAD
function [ CNN ] = cnnRollParams( CNN, vect )
%CNNROLLPARAMS Summary of this function goes here
%   Detailed explanation goes here
    
    tempPos = 1;
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).W);
                CNN.layers(layerNum).W = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).W));
                tempPos = tempPos + t;
        end
    end
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).b);
                CNN.layers(layerNum).b = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).b));
                tempPos = tempPos + t;
        end;
    end;
    
=======
function [ CNN ] = cnnRollParams( CNN, vect )
%CNNROLLPARAMS Summary of this function goes here
%   Detailed explanation goes here
    
    tempPos = 1;
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).W);
                CNN.layers(layerNum).W = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).W));
                tempPos = tempPos + t;
        end
    end
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).b);
                CNN.layers(layerNum).b = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).b));
                tempPos = tempPos + t;
        end;
    end;
    
>>>>>>> origin/master
end