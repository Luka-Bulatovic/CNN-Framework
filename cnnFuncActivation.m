function [ y ] = cnnFuncActivation( x, type )
%CNNFUNCACTIVATION Summary of this function goes here
%   Detailed explanation goes here

    if strcmp(type, 'sigmoid') == 1
        y = sigmoid(x);
    elseif strcmp(type, 'relu') == 1
        y = relu(x);
    else
    end;


end

