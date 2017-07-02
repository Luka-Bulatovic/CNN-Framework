function [images, allLabels, testImages, testLabels] = loadCIFARImagesLabels()
%LOADCIFARIMAGES Summary of this function goes here
%   Detailed explanation goes here

    images = zeros(32, 32, 3, 50000);
    allLabels = zeros(50000, 1);
    
    
    for batch_num=1:5
        if batch_num==1
            load 'data_batch_1.mat';
        elseif batch_num==2
            load 'data_batch_2.mat';
        elseif batch_num==3
            load 'data_batch_3.mat';
        elseif batch_num==4
            load 'data_batch_4.mat';
        else
            load 'data_batch_5.mat';
        end;
        
        for i=1:10000
            images(:, :, 1, (batch_num-1)*10000 + i) = ...
                reshape(data(i, 1:1024), 32, 32)';
            images(:, :, 2, (batch_num-1)*10000 + i) = ...
                reshape(data(i, 1025:2048), 32, 32)';
            images(:, :, 3, (batch_num-1)*10000 + i) = ...
                reshape(data(i, 2049:3072), 32, 32)';
        end;
        allLabels((batch_num-1)*10000+1:batch_num*10000) = labels;
    end;
    
    
    
    
    load 'test_batch.mat';
    testImages = zeros(32,32,3,10000);
    for i=1:10000
        testImages(:, :, 1, i) = ...
            reshape(data(i, 1:1024), 32, 32)';
        testImages(:, :, 2, i) = ...
            reshape(data(i, 1025:2048), 32, 32)';
        testImages(:, :, 3, i) = ...
            reshape(data(i, 2049:3072), 32, 32)';
        
        tmp = testImages(:, :, 1, i)+testImages(:, :, 2, i)+testImages(:, :, 3, i);
        tmp = tmp/3;
        testImages(:, :, 1, i) = testImages(:, :, 1, i) - tmp;
        testImages(:, :, 2, i) = testImages(:, :, 2, i) - tmp;
        testImages(:, :, 3, i) = testImages(:, :, 3, i) - tmp;
    end;
    testLabels = labels;
    
    allLabels(allLabels==0) = 10;
    testLabels(testLabels==0) = 10;
    
    images = double(images);
    testImages = double(testImages);
    allLabels = double(allLabels);
    testLabels = double(testLabels);
end