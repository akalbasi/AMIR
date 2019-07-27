function [ states ] = getStates( row, column, classCount, order )
%getStates returns states for given row and column
% This implementation doesn't work for class count larger than 36!

rowZero = row - 1; %zero indexing for conversion
s = dec2base(rowZero, classCount);

b=sprintf(strcat('%0', num2str(order), 's'),s);

states = [(base2dec(b(:), classCount)+1)' column];

end

