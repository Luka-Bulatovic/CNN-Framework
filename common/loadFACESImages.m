function [images_train, images_test] = loadFACESImages()
    cd('../common/faces'); cd('face.train'); cd('train');
    sz1 = 2429;
    sz2 = 4548;
    sz3 = 472;
    sz4 = 23573;
    images_train = zeros(20, 20, 1, sz1+sz2);
    images_test = zeros(20, 20, 1, sz3+sz4);
    
    %faces - train
    cd('face');
    a = dir;
    
    for i=3:length(a)
        fajl = a(i).name;
        images_train(2:end,2:end,1,i-2) = imread(fajl);
    end;
    
    
    
    cd('..'); cd('non-face');
    a = dir;
    
    for i=3:length(a)%sz1+1:sz1+sz2
        fajl = a(i).name;
        images_train(2:end,2:end,1,i-2+sz1) = imread(fajl);
    end;
    
    %faces - test
    cd('..'); cd('..'); cd('..');
    cd('face.test'); cd('test');
    
    cd('face');
    a = dir;
    
    for i=3:length(a)
        fajl = a(i).name;
        images_test(2:end,2:end,1,i-2) = imread(fajl);
    end;
    
    
    
    cd('..'); cd('non-face'); 
    a = dir;
    
    for i=3:length(a)
        fajl = a(i).name;
        images_test(2:end,2:end,1,i-2+sz3) = imread(fajl);
    end;
    cd('..'); cd('..'); cd('..'); cd('..'); cd('..'); cd('deep_cnn');
    
    
    
    %skaliranje
    images_train = double(images_train) / 255.0;
    images_test = double(images_test) / 255.0;
    
end