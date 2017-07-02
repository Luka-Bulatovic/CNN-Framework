<<<<<<< HEAD
function [ CNN ] = cnnPool( CNN, layerNum )
%CNNPOOL Summary of this function goes here
%   Detailed explanation goes here

    poolDim = CNN.layers(layerNum).poolDim;
    if CNN.gpumode == 0
        filter = ones(poolDim, poolDim) ./ (poolDim * poolDim);
    else
        filter = gpuArray.ones(poolDim, poolDim) ./ (poolDim * poolDim);
    end;
    
    poolIndex = 1 : poolDim : (CNN.layers(layerNum-1).convDim - max(0, poolDim - 1));
    
    for imageNum = 1:CNN.minibatchSize
        for filterNum = 1:CNN.layers(layerNum).numFilters
            im = CNN.layers(layerNum-1).activations(:, :, filterNum, imageNum);
            konvolucija = conv2(im, filter, 'valid');
            CNN.layers(layerNum).activations(:, :, filterNum, imageNum) = konvolucija(... 
                poolIndex, poolIndex);
        end;
    end;

=======
function [ CNN ] = cnnPool( CNN, layerNum )
%CNNPOOL Summary of this function goes here
%   Detailed explanation goes here

    poolDim = CNN.layers(layerNum).poolDim;
    if CNN.gpumode == 0
        filter = ones(poolDim, poolDim) ./ (poolDim * poolDim);
    else
        filter = gpuArray.ones(poolDim, poolDim) ./ (poolDim * poolDim);
    end;
    
    poolIndex = 1 : poolDim : (CNN.layers(layerNum-1).convDim - max(0, poolDim - 1));
    
    for imageNum = 1:CNN.minibatchSize
        for filterNum = 1:CNN.layers(layerNum).numFilters
            im = CNN.layers(layerNum-1).activations(:, :, filterNum, imageNum);
            konvolucija = conv2(im, filter, 'valid');
            CNN.layers(layerNum).activations(:, :, filterNum, imageNum) = konvolucija(... 
                poolIndex, poolIndex);
        end;
    end;

>>>>>>> origin/master
end