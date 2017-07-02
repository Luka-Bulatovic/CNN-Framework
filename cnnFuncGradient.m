function [ y ] = cnnFuncGradient( x, type )
%CNNFUNCGRADIENT Summary of this function goes here
%   Detailed explanation goes here

    if strcmp(type, 'sigmoid') == 1
        y = sigmoid(x) .* (1 - sigmoid(x));
    elseif strcmp(type, 'relu') == 1
        y = (x > 0);
    else
    end;

end

