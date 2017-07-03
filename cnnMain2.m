clear all;

%% Build network architecture
minibatch = 100; %Size of minibatch

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
options.C1 = 0.7;
options.C2 = 0.7;
options.noOfMinibatches = 600;

%% Training
CNN = cnnInitParams(CNN);
[theta,~] = cnnUnrollParams(CNN, 1);

[~, CNN, efficiency] = minFuncSGD(theta,options,CNN);
[theta, theta_active] = cnnUnrollParams(CNN, 1);

CNN=cnnRollActiveVector(CNN, theta_active);
cnnTest;