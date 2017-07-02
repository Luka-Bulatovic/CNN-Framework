<<<<<<< HEAD
function [ CNN ] = cnnDeconvolve( CNN, layerNum )
%CNNDECONVOLVE Summary of this function goes here
%   Detailed explanation goes here

%     if layerNum > 1
%         CNN.layers(layerNum-1).delta = CNN.layers(layerNum).delta .* ...
%             CNN.layers(layerNum).activations .* (1 - CNN.layers(layerNum).activations);
%     else
%         CNN.delta_conv = CNN.layers(layerNum).delta .* ...
%             CNN.layers(layerNum).activations .* (1 - CNN.layers(layerNum).activations);
%     end;


    %layerNum????????????????????
    pad = (CNN.layers(layerNum).filterDim-1)/2;

    CNN.layers(layerNum-1).delta = zeros(size(CNN.layers(layerNum-1).delta));
    
    for imageNum = 1:CNN.minibatchSize
        for filterNum = 1:CNN.layers(layerNum-1).numFilters
            for filterNum2 = 1:CNN.layers(layerNum).numFilters
                CNN.layers(layerNum-1).delta(pad+1:end-pad,pad+1:end-pad,filterNum,imageNum) = ...
                    CNN.layers(layerNum-1).delta(pad+1:end-pad,pad+1:end-pad,filterNum,imageNum) + ...
                    conv2(CNN.layers(layerNum).delta(:,:,filterNum2),...
                    rot90(CNN.layers(layerNum).W(:,:,filterNum,filterNum2),2),'valid');
            end;
        end;
    end;
    
    if strcmp(CNN.layers(layerNum-1).type, 'conv') == 1
        CNN.layers(layerNum-1).delta = CNN.layers(layerNum-1).delta .* ...
             cnnFuncGradient(CNN.layers(layerNum-1).activations, CNN.activation);
    end;
end

=======
function [ CNN ] = cnnDeconvolve( CNN, layerNum )
%CNNDECONVOLVE Summary of this function goes here
%   Detailed explanation goes here

%     if layerNum > 1
%         CNN.layers(layerNum-1).delta = CNN.layers(layerNum).delta .* ...
%             CNN.layers(layerNum).activations .* (1 - CNN.layers(layerNum).activations);
%     else
%         CNN.delta_conv = CNN.layers(layerNum).delta .* ...
%             CNN.layers(layerNum).activations .* (1 - CNN.layers(layerNum).activations);
%     end;


    %layerNum????????????????????
    pad = (CNN.layers(layerNum).filterDim-1)/2;

    CNN.layers(layerNum-1).delta = zeros(size(CNN.layers(layerNum-1).delta));
    
    for imageNum = 1:CNN.minibatchSize
        for filterNum = 1:CNN.layers(layerNum-1).numFilters
            for filterNum2 = 1:CNN.layers(layerNum).numFilters
                CNN.layers(layerNum-1).delta(pad+1:end-pad,pad+1:end-pad,filterNum,imageNum) = ...
                    CNN.layers(layerNum-1).delta(pad+1:end-pad,pad+1:end-pad,filterNum,imageNum) + ...
                    conv2(CNN.layers(layerNum).delta(:,:,filterNum2),...
                    rot90(CNN.layers(layerNum).W(:,:,filterNum,filterNum2),2),'valid');
            end;
        end;
    end;
    
    if strcmp(CNN.layers(layerNum-1).type, 'conv') == 1
        CNN.layers(layerNum-1).delta = CNN.layers(layerNum-1).delta .* ...
             cnnFuncGradient(CNN.layers(layerNum-1).activations, CNN.activation);
    end;
end

>>>>>>> origin/master
