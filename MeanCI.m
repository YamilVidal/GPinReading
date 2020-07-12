function [m,ci] = MeanCI(x,a)
% Get the mean and CI of a sample.
%
% Usage:
%   [m,ci] = MeanCI(x,a)
% Where:
%   In:
%       x: Vector of values
%       a: Alpha level. Scalar from 0 to 1. Default is 0.05, corresponding
%       to a 95% CI
%   Out:
%       m: Mean of x
%       ci: Confidence interval
%
% Created by Yamil Vidal (hvidaldossantos@gmail.com)

if ~exist('a','var'); a = 0.05; end
    
m = mean(x);
n = length(x);

sem = std(x)/sqrt(n);
CI  = tinv([a/2, 1-(a/2)], n-1); 

ci = [m+sem*CI(1), m+sem*CI(2)];
end

