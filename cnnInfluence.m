<<<<<<< HEAD
brojMreza = size(all_thetas, 1);
acc=0;
its2=0;
does_something = zeros(1, brojMreza);

for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize+1
    preds_combined = zeros(CNN.numClasses, CNN.minibatchSize);
    preds_combined_network = zeros(CNN.numClasses, CNN.minibatchSize);
    for curmreza = 1:brojMreza
        CNN = cnnRollActiveVector(CNN, all_thetas_active(curmreza, :));
        curpreds=cnnCostForCombined(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),all_thetas(curmreza, :),CNN,1);
        
        for inf_row=1:CNN.numClasses
            for inf_col=1:CNN.minibatchSize
                if preds_combined(inf_row, inf_col) < curpreds(inf_row, inf_col)
                    preds_combined(inf_row, inf_col) = curpreds(inf_row, inf_col);
                    preds_combined_network(inf_row, inf_col) = curmreza;
                end
            end
        end
    end
    
    [~,preds_combined] = max(preds_combined,[],1);
    preds_combined = preds_combined';
    for inf_col = 1:CNN.minibatchSize
        does_something( preds_combined_network(preds_combined(inf_col), inf_col) ) = ...
            does_something( preds_combined_network(preds_combined(inf_col), inf_col) ) + 1;
    end
    acc = acc + sum(full(sparse(preds_combined))==CNN.testLabels(i:i+CNN.minibatchSize-1));
    its2 = its2+1;
    fprintf('Pogodjeno: %d/%d\n',acc, its2*CNN.minibatchSize);
end

acc = acc / (its2*CNN.minibatchSize);
=======
brojMreza = size(all_thetas, 1);
acc=0;
its2=0;
does_something = zeros(1, brojMreza);

for i=1:CNN.minibatchSize:length(CNN.testLabels)-CNN.minibatchSize+1
    preds_combined = zeros(CNN.numClasses, CNN.minibatchSize);
    preds_combined_network = zeros(CNN.numClasses, CNN.minibatchSize);
    for curmreza = 1:brojMreza
        CNN = cnnRollActiveVector(CNN, all_thetas_active(curmreza, :));
        curpreds=cnnCostForCombined(CNN.testImages(:, :, :, i:i+CNN.minibatchSize-1),CNN.testLabels(i:i+CNN.minibatchSize-1),all_thetas(curmreza, :),CNN,1);
        
        for inf_row=1:CNN.numClasses
            for inf_col=1:CNN.minibatchSize
                if preds_combined(inf_row, inf_col) < curpreds(inf_row, inf_col)
                    preds_combined(inf_row, inf_col) = curpreds(inf_row, inf_col);
                    preds_combined_network(inf_row, inf_col) = curmreza;
                end
            end
        end
    end
    
    [~,preds_combined] = max(preds_combined,[],1);
    preds_combined = preds_combined';
    for inf_col = 1:CNN.minibatchSize
        does_something( preds_combined_network(preds_combined(inf_col), inf_col) ) = ...
            does_something( preds_combined_network(preds_combined(inf_col), inf_col) ) + 1;
    end
    acc = acc + sum(full(sparse(preds_combined))==CNN.testLabels(i:i+CNN.minibatchSize-1));
    its2 = its2+1;
    fprintf('Pogodjeno: %d/%d\n',acc, its2*CNN.minibatchSize);
end

acc = acc / (its2*CNN.minibatchSize);
>>>>>>> origin/master
fprintf('Accuracy is %f\n',acc);