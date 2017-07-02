imageDim = CNN.dim;

acc=0;
its2=0;
for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize
    [cost2,grad2,CNN,preds2]=cnnCost(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),theta,CNN,1);
    acc = acc + sum(full(sparse(preds2))==CNN.testLabels(i:i+CNN.minibatchSize-1));
    its2 = its2+1;
end
acc = acc / (its2*CNN.minibatchSize);

fprintf('Accuracy is %f\n',acc);