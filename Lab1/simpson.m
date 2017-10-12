function z = simpson(x, y, dim)
%SIMPSON Simpson numerical integration.
% 
%Requrements: 
%   Y has odd number of elements across dim, and is spaced in
%   such manner that:
%   Y(2i - 1) = f(x(i));
%   Y(2i) = f((x(i) + (x(i+1)) / 2);
%   Y(2i + 1) = f(x(i + 1));
% 
%Usage:
% Z = SIMPSON(Y)computes an approximation of the integral of Y via
%     the right rectangular method (with unit spacing).  To compute the integral
%     for spacing different from one, multiply Z by the spacing increment.
%     
%     For vectors, SIMPSON(Y) is the integral of Y. For matrices, SIMPSON(Y)
%     is a row vector with the integral over each column. For N-D
%     arrays, SIMPSON(Y) works across the first non-singleton dimension.
% 
% Z = SIMPSON(X, Y) computes the integral of Y with respect to X using
%     the Simpson method.  X and Y must be vectors of such length that
%     length(Y) = 2 * length(X) - 1, or X must be a column vector and Y an array whose first
%     non-singleton dimension is 2 * length(X) - 1.  SIMPSON operates along this
%     dimension.
% 
% Z = SIMPSON(X, Y, dim) or SIMPSON(Y, DIM) integrates across dimension DIM
%     of Y. The length of X must be the same as (size(Y,DIM) + 1 )/ 2).
% 
%See also: RECTANGLES, TRAPZ.
if (nargin <= 0)
    error('Not enough arguments!');
    return;
end
perm = [];
nshifts = 0;
if nargin == 3 % simpson(x,y,dim)
    perm = [dim:max(ndims(y),dim) 1:dim-1];
    y = permute(y,perm);
    m = size(y,1);
elseif nargin==2 && isscalar(y) % simpson(y,dim)
    dim = y; 
    y = x;
    perm = [dim:max(ndims(y),dim) 1:dim-1];
    y = permute(y,perm);
    m = size(y,1);
    x = 1:2:m;
else % simpson(y) or simpson(x,y)
    if nargin < 2
    y = x;
    end
    [y,nshifts] = shiftdim(y);
    dim = nshifts + 1;
    m = size(y,1);
    if nargin < 2
    x = 1:2:m; 
    end
end
if ~isvector(x)
    error(message('MATLAB:trapz:xNotVector'));
end
x = x(:);
if (m < 3) || (mod(m, 2) == 0)
    error('Y is wrongly spaced!');
end
if length(x) ~= (m + 1) / 2
    error(['Length X must equal (length Y + 1) / 2 in dim ',num2str(dim)]);
end

% The output size for [] is a special case when DIM is not given.
if isempty(perm) && isequal(y,[])
    z = zeros(1,class(y));
    return;
end

%Simpson sum computed with vector-matrix multiply.
z = (diff(x, 1, 1).' / 6) * (y(1:2:m - 2, :) + 4 * y(2:2:m-1, :) + y(3:2:m, :));
siz = size(y); siz(1) = 1;
z = reshape(z,[ones(1,nshifts),siz]);
if ~isempty(perm), z = ipermute(z,perm); end