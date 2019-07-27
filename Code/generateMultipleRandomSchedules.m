function [ schedules ] = generateMultipleRandomSchedules( A, n)
%generateMultipleRandomSchedules generates n  Random schedules

for i = 1:n,
   schedules(i, :) = generateRandomSchedule(A);
end


end

