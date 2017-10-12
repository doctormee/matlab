function [ out ] = rndi( num_to, varargin )
%RNDI User-defined uniform random integers from 1 to num_to
%   Usage: aMat = rndi(100, 3) - returns 3x3 matrix filled with uniform
%   random integers from 1 to 100
    nVarargs = length(varargin);
    out = floor( num_to * rand(varargin{1:nVarargs}) + 1);

end

