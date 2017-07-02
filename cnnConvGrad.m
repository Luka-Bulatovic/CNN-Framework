function [ CNN ] = cnnConvGrad( CNN, layerNum, images )
%CNNCONVGRAD Summary of this function goes here
%   Detailed explanation goes here

    pad = (CNN.layers(layerNum).filterDim-1)/2;
    
    if CNN.gpumode == 0
        CNN.layers(layerNum).W_grad = zeros(size(CNN.layers(layerNum).W_grad));
    else
        CNN.layers(layerNum).W_grad = gpuArray.zeros(size(CNN.layers(layerNum).W_grad));
    end;
    
    for filterNum=1:CNN.layers(layerNum).numFilters
        for imageNum=1:CNN.minibatchSize
            if layerNum == 1
                c = conv2(images(:, :, imageNum), rot90(CNN.layers(layerNum).delta(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum), 2), 'valid');
            else
                c = conv2(CNN.layers(layerNum-1).activations(:, :, filterNum, imageNum), ...
                    rot90(CNN.layers(layerNum).delta(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum), 2), 'valid');
            end
            
            CNN.layers(layerNum).W_grad(:, :, filterNum) = ... 
                CNN.layers(layerNum).W_grad(:, :, filterNum) + ...
                c;
        end;
        CNN.layers(layerNum).W_grad(:, :, filterNum) = CNN.layers(layerNum).W_grad(:, :, filterNum) ./ CNN.minibatchSize;
    end;
    for filterNum = 1 : CNN.layers(layerNum).numFilters
        CNN.layers(layerNum).b_grad(filterNum) = 1/CNN.minibatchSize*...
            sum(sum(sum(CNN.layers(layerNum).delta(:,:,filterNum,:))));
    end;

end