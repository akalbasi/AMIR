function [ schedule ] = generateShortestOrLongestFirstSchedule( A, probDists, sortDirection )
%generateShortestOrLongestFirstSchedule generates SJF or LJF schedules

if(size(A,2) ~= size(probDists,1))
   error('The size of arrivals and probDist vectors donot match');
end

serviceTimes = [];
scheduleOrder = [];
simpleSchedule = generateSimpleSchedule(A);

for class = 1:size(A,2),
    if(size(serviceTimes, 2) == 0)
        serviceTimes(class) = probDists(class, 1).mean;
        scheduleOrder(1:A(class)) = probDists(class, 1).mean;
    else
        serviceTimes(end+1) = probDists(class, 1).mean;
        scheduleOrder(end+1:end+A(class)) = probDists(class, 1).mean;
    end
    
end
if(strcmp(sortDirection,'shortestFirst') == 1)
    [tmp,ind] = sort(scheduleOrder, 'ascend');
else if(strcmp(sortDirection,'longestFirst') == 1)
        [tmp,ind] = sort(scheduleOrder, 'descend');
    else
        error('order should be either ''shortestFirst'' or ''longestFirst''.');
    end
end

schedule = simpleSchedule(ind);

end

