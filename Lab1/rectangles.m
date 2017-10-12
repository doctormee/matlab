function z = rectangles(x, y, dim)
%RECTANGLES Rectangle numerical integration.
% 
%Usage:
% Z = RECTANGLES(Y)computes an approximation of the integral of Y via
%     the right rectangular method (with unit spacing).  To compute the integral
%     for spacing different from one, multiply Z by the spacing increment.
%     
%     For vectors, RECTANGLES(Y) is the integral of Y. For matrices, RECTANGLES(Y)
%     is a row vector with the integral over each column. For N-D
%     arrays, RECTANGLES(Y) works across the first non-singleton dimension.
% 
% Z = RECTANGLES(X, Y) computes the integral of Y with respect to X using
%     the right rectangular method.  X and Y must be vectors of the same
%     length, or X must be a column vector and Y an array whose first
%     non-singleton dimension is length(X).  RECTANGLES operates along this
%     dimension.
% 
% Z = RECTANGLES(X, Y, dim) or RECTANGLES(Y, DIM) integrates across dimension DIM
%     of Y. The length of X must be the same as size(Y,DIM)).
% 
%See also: SIMPSON, TRAPZ.
if (nargin <= 0)
    error('Not enough arguments!');
    return;
end
perm = [];
nshifts = 0;
if nargin == 3 % rectangles(x,y,dim)
    perm = [dim:max(ndims(y),dim) 1:dim-1];
    y = permute(y,perm);
    m = size(y,1);
elseif nargin==2 && isscalar(y) % rectangles(y,dim)
    dim = y; 
    y = x;
    perm = [dim:max(ndims(y),dim) 1:dim-1];
    y = permute(y,perm);
    m = size(y,1);
    x = 1:m;
else % rectangles(y) or rectangles(x,y)
    if nargin < 2
    y = x;
    end
    [y,nshifts] = shiftdim(y);
    dim = nshifts + 1;
    m = size(y,1);
    if nargin < 2
    x = 1:m; 
    end
end
if ~isvector(x)
    error(message('MATLAB:trapz:xNotVector'));
end
x = x(:);
if length(x) ~= m
    error(message('MATLAB:trapz:LengthXmismatchY',dim));
end

% The output size for [] is a special case when DIM is not given.
if isempty(perm) && isequal(y,[])
    z = zeros(1,class(y));
    return;
end

%Right-rectangle sum computed with vector-matrix multiply.
z = diff(x,1,1).' * y(2:m,:);

siz = size(y); siz(1) = 1;
z = reshape(z,[ones(1,nshifts),siz]);
if ~isempty(perm), z = ipermute(z,perm); end