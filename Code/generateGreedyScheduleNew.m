function [ schedule ] = generateGreedyScheduleNew( arrivals, burstinessPotential )
%generateGreedyScheduleNew generates a Greedy schedule


tmpSchedule = generateLowestOrHighestBurstinessPotentialFirst( arrivals, burstinessPotential, 'highestBurstinessFirst' );

forwardIndex = 1;
backwardIndex = size(tmpSchedule, 2);
index = 1;

schedule(1, 1:backwardIndex) = 0;

while forwardIndex < backwardIndex
    schedule(1, index) = tmpSchedule(1, forwardIndex);
    index = index + 1;
    schedule(1, index) = tmpSchedule(1, backwardIndex);
    index = index + 1;
    forwardIndex = forwardIndex + 1;
    backwardIndex = backwardIndex - 1;
end

if forwardIndex == backwardIndex
    schedule(1, index) = tmpSchedule(1, forwardIndex);
end

end

