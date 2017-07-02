clear all;

addpath '../cifar-10-batches-mat/';
addpath '../common/';
%% Number of networks and whether you want to save them to file
brojMreza = 2;
cuvaj = 0;
imeFajla = 'arh1.mat';

%% Build network architecture
minibatch = 50; %Size of minibatch

CNN = buildCNN(4, minibatch, 'mnist', 'relu', 0);

CNN = addConvLayer(CNN, 9, 70, 'Conv1');
CNN = addPoolLayer(CNN, 2, 'Pool1');
CNN = addFcLayer(CNN, 256, 'FC1');
CNN = addFcLayer(CNN, 10, 'Softmax');

%% Parameters
options.epochs = 1;
options.minibatch = minibatch;
options.alpha = 1e-1;
options.momentum = .95;
options.generations = 2;
options.C1 = 0.55;
options.C2 = 0.55;
options.noOfMinibatches = int32(floor(length(CNN.labels)/minibatch));

%% Training
all_thetas = [];
all_thetas_active = [];

efficiency=[];

for kk=1:brojMreza
    CNN = cnnInitParams(CNN);
    [theta,~] = cnnUnrollParams(CNN, 1);
    
    [opttheta, CNN, efficiency] = minFuncSGD(@(x,y,z,c) cnnCost(x,y,z,c,0),theta,options,CNN);
    [opttheta, opttheta_active] = cnnUnrollParams(CNN, 1);
    
    if(~isempty(all_thetas))
        all_thetas = [all_thetas ; opttheta'];
        all_thetas_active = [all_thetas_active ; opttheta_active'];
    else
        all_thetas = opttheta';
        all_thetas_active = opttheta_active';
    end
    
    fprintf('Efficiencies:\n'); efficiency = 1./efficiency
    
    if cuvaj == 1
        save(imeFajla, 'all_thetas', 'all_thetas_active');
    end
end
