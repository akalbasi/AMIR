function [ row ] = getRowNoColumn(states, S)
%getRowNoColumn returns the number of non-zero transition counts from the
%row

order = size(states, 2);

multiplier = S.^fliplr(0:order-1);

row = sum((states-1).*multiplier)+1;

end

