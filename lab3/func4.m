function [ res ] = func4( t )
    res = t.^3 .* exp( -t.^4);
end