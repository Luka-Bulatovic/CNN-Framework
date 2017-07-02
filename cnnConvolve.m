<<<<<<< HEAD
CNN.layers(layerNum).W = CNN.layers(layerNum).W .* CNN.layers(layerNum).W_active;

pad = (CNN.layers(layerNum).filterDim-1) / 2;

if CNN.gpumode == 1
    CNN.layers(layerNum).activations = gpuArray.zeros(size(CNN.layers(layerNum).activations));
else
    CNN.layers(layerNum).activations = zeros(size(CNN.layers(layerNum).activations));
end

for imageNum = 1:CNN.minibatchSize
    for filterNum = 1:CNN.layers(layerNum).numFilters
        for filterD = 1:CNN.layers(layerNum).filterDepth
            c = conv2(convInput(:, :, filterD, imageNum), ... 
                rot90(CNN.layers(layerNum).W(:, :, filterD, filterNum), 2), 'valid');
            CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ...
                CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) + ...
                c;
        end

        CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ...
                CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) + ...
                CNN.layers(layerNum).b(filterNum);

        CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ... 
            cnnFuncActivation(CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum), CNN.activation);
    end
end

=======
CNN.layers(layerNum).W = CNN.layers(layerNum).W .* CNN.layers(layerNum).W_active;

pad = (CNN.layers(layerNum).filterDim-1) / 2;

if CNN.gpumode == 1
    CNN.layers(layerNum).activations = gpuArray.zeros(size(CNN.layers(layerNum).activations));
else
    CNN.layers(layerNum).activations = zeros(size(CNN.layers(layerNum).activations));
end

for imageNum = 1:CNN.minibatchSize
    for filterNum = 1:CNN.layers(layerNum).numFilters
        for filterD = 1:CNN.layers(layerNum).filterDepth
            c = conv2(convInput(:, :, filterD, imageNum), ... 
                rot90(CNN.layers(layerNum).W(:, :, filterD, filterNum), 2), 'valid');
            CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ...
                CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) + ...
                c;
        end

        CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ...
                CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) + ...
                CNN.layers(layerNum).b(filterNum);

        CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum) = ... 
            cnnFuncActivation(CNN.layers(layerNum).activations(pad+1:end-pad, pad+1:end-pad, filterNum, imageNum), CNN.activation);
    end
end

>>>>>>> origin/master
