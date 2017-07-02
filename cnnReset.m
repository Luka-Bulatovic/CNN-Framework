for i=1:CNN.numLayers
    if CNN.gpumode == 0
        CNN.layers(i).W_grad = zeros(size(CNN.layers(i).W_grad));
        CNN.layers(i).b_grad = zeros(size(CNN.layers(i).b_grad));
        CNN.layers(i).activations = zeros(size(CNN.layers(i).activations));
        CNN.layers(i).delta = zeros(size(CNN.layers(i).delta));
    else
        CNN.layers(i).W_grad = gpuArray.zeros(size(CNN.layers(i).W_grad));
        CNN.layers(i).b_grad = gpuArray.zeros(size(CNN.layers(i).b_grad));
        CNN.layers(i).activations = gpuArray.zeros(size(CNN.layers(i).activations));
        CNN.layers(i).delta = gpuArray.zeros(size(CNN.layers(i).delta));
    end
end