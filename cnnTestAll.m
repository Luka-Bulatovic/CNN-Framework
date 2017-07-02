<<<<<<< HEAD
brojMreza=size(all_thetas,1);
for mreza = 1:brojMreza
    acc=0;
    its2=0;
    CNN = cnnRollActiveVector(CNN, all_thetas_active(mreza, :));
    for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize+1
        [cost2,grad2,CNN,preds2]=cnnCost(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),all_thetas(mreza, :),CNN,1);
        acc = acc + sum(full(sparse(preds2))==CNN.testLabels(i:i+CNN.minibatchSize-1));
        its2 = its2+1;
    end
    acc = acc / (its2*CNN.minibatchSize);
    fprintf('Accuracy is %f\n',acc);
=======
brojMreza=size(all_thetas,1);
for mreza = 1:brojMreza
    acc=0;
    its2=0;
    CNN = cnnRollActiveVector(CNN, all_thetas_active(mreza, :));
    for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize+1
        [cost2,grad2,CNN,preds2]=cnnCost(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),all_thetas(mreza, :),CNN,1);
        acc = acc + sum(full(sparse(preds2))==CNN.testLabels(i:i+CNN.minibatchSize-1));
        its2 = its2+1;
    end
    acc = acc / (its2*CNN.minibatchSize);
    fprintf('Accuracy is %f\n',acc);
>>>>>>> origin/master
end