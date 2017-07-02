function [preds] = cnnCostForCombined(images, labels, theta, CNN, pred)
%cnnCost calculates the cost function evaluated on the minibatch of images
%using the currently learnt parameters in the network. It also returns
%gradient vector used for updating theta, as well as probability
%predictions for all classes for all the images in the minibatch.

%% Step 0: Rolling parameters
%Reseting matrices
cnnReset;
CNN = cnnRollParams(CNN, theta);
grad = [];

%% Step 1: Forward Propagation
for layerNum = 1:CNN.numLayers
    switch CNN.layers(layerNum).type
        case 'conv'
            if layerNum == 1
                %CNN = cnnConvolve(CNN, layerNum, images);
                convInput = images;
                %cnnConvolve;
            else
                convInput = CNN.layers(layerNum-1).activations;
                %CNN = cnnConvolve(CNN, layerNum, CNN.layers(layerNum-1).activations);
                %cnnConvolve(layerNum, CNN.layers(layerNum-1).activations);
            end
            cnnConvolve;
        case 'pool'
            CNN = cnnPool(CNN, layerNum);
        case 'fc'
            CNN = cnnFullForwd(CNN, layerNum);
        otherwise
            %
    end;
end;
preds = CNN.layers(CNN.numLayers).activations;

%% Step 2: Calculate cost based on softmax layer
cost=0;
labels_full=full(sparse(labels,1:length(labels),1));

if pred == 1
    return;
end;

cost=cost-1/length(labels)*sum(sum(log(preds).*labels_full));
CNN.layers(CNN.numLayers).delta = (preds - labels_full);


%% Step 3: Backpropagation
for layerNum = CNN.numLayers:-1:2
    switch CNN.layers(layerNum).type
        case 'conv'
            CNN = cnnDeconvolve(CNN, layerNum);
        case 'pool'
            CNN = cnnUnpool(CNN, layerNum);
        case 'fc'
            CNN = cnnFullBackwd(CNN, layerNum);
        otherwise
            %
    end;
end;

%% Step 4: Gradients
% Calculate gradients
for layerNum = CNN.numLayers:-1:1
    switch CNN.layers(layerNum).type
        case 'conv'
            CNN = cnnConvGrad(CNN, layerNum, images);
        case 'fc'
            CNN = cnnFcGrad(CNN, layerNum);
        otherwise
            %
    end;
end;

% Unroll gradients
grad = cnnUnrollParams(CNN, 2);

end