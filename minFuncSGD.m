function [opttheta, CNN, efficiency] = minFuncSGD(theta,options,CNN)
%% Setup

assert(all(isfield(options,{'epochs','alpha','minibatch'})),...
        'Some options not defined');
assert(options.noOfMinibatches <= int32(floor(length(CNN.labels)/options.minibatch)), ...
    ['The number of minibatches is greater than the maximum number of minibatches: ' num2str(int32(floor(length(CNN.labels)/options.minibatch)))]);
if ~isfield(options,'momentum')
    options.momentum = 0.9;
end

epochs = options.epochs;
alpha = options.alpha;
minibatch = options.minibatch;
m = length(CNN.labels); % training set size
% Setup for momentum
mom = 0.5;
momIncrease = 20;
velocity = zeros(size(theta));

results = [];

% randomly permute indices of data for quick minibatch sampling
rp = randperm(m);
efficiency = zeros(options.generations, 1);

%%======================================================================
%% SGD loop
it = 0;
for gen = 1:options.generations
    alpha = options.alpha;
    
    [~, tmp_active] = cnnUnrollParams(CNN, 1);
    efficiency(gen) = sum(tmp_active)/numel(tmp_active);
    
    for e = 1:epochs

        %for s=1:minibatch:(m-minibatch+1)
        for s=1:minibatch:(options.noOfMinibatches*minibatch-minibatch+1)
            it = it + 1;

            % increase momentum after momIncrease iterations
            if it == momIncrease
                mom = options.momentum;
            end

            % get next randomly selected minibatch
            mb_data = CNN.images(:,:,:,rp(s:s+minibatch-1));
            mb_labels = CNN.labels(rp(s:s+minibatch-1));

            % evaluate the objective function on the next minibatch
            [cost, grad, CNN] = cnnCost(mb_data,mb_labels,theta,CNN,0);

            % Instructions: Add in the weighted velocity vector to the
            % gradient evaluated above scaled by the learning rate.
            % Then update the current weights theta according to the
            % sgd update rule
            
            velocity = alpha*grad + mom*velocity;
            theta=theta-velocity;

            fprintf('Generation %d, Epoch %d: Cost on iteration %d is %f\n',gen,e,it,cost);
        end

        % aneal learning rate by factor of two after each epoch
        if alpha > 0.003
            alpha = alpha/2.0;
        end
        
        cnnTest;
        results = [results acc];
    end
    
    if gen < options.generations
        CNN = cnnNextGeneration(CNN, options.C1, options.C2);
    end
end
opttheta = theta;

for gen=1:options.generations
    for e=1:epochs
        fprintf('Gen %d, Epoch %d - Accuracy: %f\n',gen,e,results((gen-1)*epochs + e));
    end
end

efficiency = 1 ./ efficiency;

end
