function [ schedules ] = generateMultipleOptimalSchedules( M, n)
% Generates n schedules by traversing the M matrix
%
S = size(M, 2);
order = round(log(size(M, 1))/log(S));
schedules = zeros(n, sum(sum(M))+ order);
for i = 1:n,
   [schedules(i, :), deadEnd ] = traverseLookAheadRandom( M, [] );
   if deadEnd==1
       error('Incorrect schedule');
   end
end

end

