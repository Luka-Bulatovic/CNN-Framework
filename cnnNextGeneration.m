<<<<<<< HEAD
function [ CNN ] = cnnNextGeneration( CNN, C1, C2 )
%CNNNEXTGENERATION Applies Evolutionary Synthesis method to the existing
%CNN generation, evolving it and producing the next generation. The
%function returns the newly evolved network.

    for layer=1:CNN.numLayers
        if strcmp(CNN.layers(layer).type, 'conv') == 1 && C1 > 0
            %Normalizaciona konstanta za sloj
            Z = ceil(max(CNN.layers(layer).W(:) .* CNN.layers(layer).W_active(:)));
            
            prob = ceil(CNN.layers(layer).W);
            prob = prob ./ Z - 1;
            prob = exp(prob);
            prob = prob .* CNN.layers(layer).W_active;
            prob = prob .* C1;
            
            roll = rand(size(prob));
            
            prob(prob>=roll) = 1;
            
            CNN.layers(layer).W_active(prob>=roll) = 1;
            CNN.layers(layer).W_active(prob<roll) = 0;
            
        elseif (strcmp(CNN.layers(layer).type, 'fc') == 1 && ...
                strcmp(CNN.layers(layer).name, 'Softmax') == 0) && C2 > 0
            
            Z = ceil(max(CNN.layers(layer).W(:) .* CNN.layers(layer).W_active(:)));
            
            prob = ceil(CNN.layers(layer).W);
            prob = prob ./ Z - 1;
            prob = exp(prob);
            prob = prob .* CNN.layers(layer).W_active;
            prob = prob .* C2;
            
            roll = rand(size(prob));
            
            prob(prob>=roll) = 1;
            
            CNN.layers(layer).W_active(prob>=roll) = 1;
            CNN.layers(layer).W_active(prob<roll) = 0;
        
        end;
        
    end;

end

=======
function [ CNN ] = cnnNextGeneration( CNN, C1, C2 )
%CNNNEXTGENERATION Applies Evolutionary Synthesis method to the existing
%CNN generation, evolving it and producing the next generation. The
%function returns the newly evolved network.

    for layer=1:CNN.numLayers
        if strcmp(CNN.layers(layer).type, 'conv') == 1 && C1 > 0
            %Normalizaciona konstanta za sloj
            Z = ceil(max(CNN.layers(layer).W(:) .* CNN.layers(layer).W_active(:)));
            
            prob = ceil(CNN.layers(layer).W);
            prob = prob ./ Z - 1;
            prob = exp(prob);
            prob = prob .* CNN.layers(layer).W_active;
            prob = prob .* C1;
            
            roll = rand(size(prob));
            
            prob(prob>=roll) = 1;
            
            CNN.layers(layer).W_active(prob>=roll) = 1;
            CNN.layers(layer).W_active(prob<roll) = 0;
            
        elseif (strcmp(CNN.layers(layer).type, 'fc') == 1 && ...
                strcmp(CNN.layers(layer).name, 'Softmax') == 0) && C2 > 0
            
            Z = ceil(max(CNN.layers(layer).W(:) .* CNN.layers(layer).W_active(:)));
            
            prob = ceil(CNN.layers(layer).W);
            prob = prob ./ Z - 1;
            prob = exp(prob);
            prob = prob .* CNN.layers(layer).W_active;
            prob = prob .* C2;
            
            roll = rand(size(prob));
            
            prob(prob>=roll) = 1;
            
            CNN.layers(layer).W_active(prob>=roll) = 1;
            CNN.layers(layer).W_active(prob<roll) = 0;
        
        end;
        
    end;

end

>>>>>>> origin/master
