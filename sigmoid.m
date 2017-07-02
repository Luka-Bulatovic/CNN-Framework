function [ y ] = sigmoid( x )
%SIGMOID returns the value of sigmoid activation function for all elements
%of x.

    y = 1 ./ (1 + exp(-x));

end