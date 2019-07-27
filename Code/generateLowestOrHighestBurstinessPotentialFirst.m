function [ schedule ] = generateLowestOrHighestBurstinessPotentialFirst( A, P0, sortDirection )
%generateLowestOrHighestBurstinessPotentialFirst generates an ordered
% schedule that is created by repeating each session class by its
% corresponding arrival count $$ As $$ while preserving the previously
% determined session class order.

if(size(A,2) ~= size(P0,2))
   error('The size of arrivals and burstinessPotential vectors donot match');
end

classCount = size(A,2);
scheduleOrder = [];
simpleSchedule = generateSimpleSchedule(A);

for class = 1:classCount,
    if(size(scheduleOrder, 2) == 0)
        scheduleOrder(1:A(class)) = P0(class);
    else
        scheduleOrder(end+1:end+A(class)) = P0(class);
    end
    
end
if(strcmp(sortDirection,'lowestBurstinessFirst') == 1)
    [tmp,ind] = sort(scheduleOrder, 'ascend');
else if(strcmp(sortDirection,'highestBurstinessFirst') == 1)
        [tmp,ind] = sort(scheduleOrder, 'descend');
    else
        error('order should be either ''lowestBurstinessFirst'' or ''highestBurstinessFirst''.');
    end
end

schedule = simpleSchedule(ind);

end

