function [ schedule ] = generateSimpleSchedule( arrivals )
% This function generates a simple schedule from the arrivals vector that
% have sessions from classes in order like 11..1122..22333..33... with
% correct number of sessions from each session class

schedule = [];
for i = 1:size(arrivals, 2),
    if(size(schedule, 2) == 0)
        schedule(1:arrivals(i)) = i;
    else
        schedule(end+1:end+arrivals(i)) = i;
    end
    
end
end

