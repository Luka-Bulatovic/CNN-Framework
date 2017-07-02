brojMreza=size(all_thetas, 1);

acc=0;
its2=0;

for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize+1
    preds = zeros(CNN.numClasses, CNN.minibatchSize);
    for mreza = 1:brojMreza
        CNN = cnnRollActiveVector(CNN, all_thetas_active(mreza, :));
        curpreds=cnnCostForCombined(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),all_thetas(mreza, :),CNN,1);
        preds = max(preds, curpreds);
    end
    
    [~,preds] = max(preds,[],1);
    preds = preds';
    acc = acc + sum(full(sparse(preds))==CNN.testLabels(i:i+CNN.minibatchSize-1));
    its2 = its2+1;
    fprintf('Pogodjeno: %d/%d\n',acc, its2*CNN.minibatchSize);
end

acc = acc / (its2*CNN.minibatchSize);
fprintf('Accuracy is %f\n',acc);