function [ labels_train, labels_test ] = loadFACESLabels()
    sz1 = 2429;
    sz2 = 4548;
    sz3 = 472;
    sz4 = 23573;
    labels_train = zeros(sz1+sz2, 1);
    labels_test = zeros(sz3+sz4, 1);
    
    labels_train(1:sz1) = 1; labels_train(sz1+1:sz1+sz2) = 2;
    labels_test(1:sz3) = 1; labels_test(sz3+1:sz3+sz4) = 2;
end

