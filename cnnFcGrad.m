<<<<<<< HEAD
function [ CNN ] = cnnFcGrad( CNN, layerNum )
%CNNFCGRAD Summary of this function goes here
%   Detailed explanation goes here

    if strcmp(CNN.layers(layerNum-1).type, 'fc') == 0
        CNN.layers(layerNum).W_grad=1/CNN.minibatchSize*CNN.layers(layerNum).delta* ...
        reshape(CNN.layers(layerNum-1).activations,[],CNN.minibatchSize)';
    else
        CNN.layers(layerNum).W_grad=1/CNN.minibatchSize*CNN.layers(layerNum).delta* ...
        CNN.layers(layerNum-1).activations';
    end
    
    CNN.layers(layerNum).b_grad=1/CNN.minibatchSize*sum(CNN.layers(layerNum).delta,2); %suma po vrstama(za svaku klasu po vrijednost)

end

=======
function [ CNN ] = cnnFcGrad( CNN, layerNum )
%CNNFCGRAD Summary of this function goes here
%   Detailed explanation goes here

    if strcmp(CNN.layers(layerNum-1).type, 'fc') == 0
        CNN.layers(layerNum).W_grad=1/CNN.minibatchSize*CNN.layers(layerNum).delta* ...
        reshape(CNN.layers(layerNum-1).activations,[],CNN.minibatchSize)';
    else
        CNN.layers(layerNum).W_grad=1/CNN.minibatchSize*CNN.layers(layerNum).delta* ...
        CNN.layers(layerNum-1).activations';
    end
    
    CNN.layers(layerNum).b_grad=1/CNN.minibatchSize*sum(CNN.layers(layerNum).delta,2); %suma po vrstama(za svaku klasu po vrijednost)

end

>>>>>>> origin/master
