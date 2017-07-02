<<<<<<< HEAD
function [ CNN ] = cnnRollActiveVector( CNN, vect )
    tempPos = 1;
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).W_active);
                CNN.layers(layerNum).W_active = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).W_active));
                tempPos = tempPos + t;
        end;
    end;
=======
function [ CNN ] = cnnRollActiveVector( CNN, vect )
    tempPos = 1;
    
    for layerNum = 1:CNN.numLayers
        switch CNN.layers(layerNum).type
            case 'pool'
            otherwise
                t = numel(CNN.layers(layerNum).W_active);
                CNN.layers(layerNum).W_active = reshape(vect(tempPos:tempPos + ...
                    t-1), size(CNN.layers(layerNum).W_active));
                tempPos = tempPos + t;
        end;
    end;
>>>>>>> origin/master
end