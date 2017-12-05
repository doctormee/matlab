function [ resVec ] = func2( tVec )
%func1 exp(-2 * abs(t)) * cos(t)
    isnZeroVec = abs( tVec ) >= eps;
    resVec = zeros( size( tVec ) );
    resVec(isnZeroVec) = ((exp(-1 .* abs(tVec(isnZeroVec))) - 1) ./ tVec(isnZeroVec));
end