function [ schedule ] = generateRandomSchedule( arrivals )
%generateRandomSchedule generates a Random schedule

simpleSchedule = generateSimpleSchedule(arrivals);
s = RandStream('mt19937ar','Seed','shuffle');
index = randperm(s, size(simpleSchedule,2));
schedule = simpleSchedule(index);

end

