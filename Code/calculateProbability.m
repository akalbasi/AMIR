function [ P, meanService ] = calculateProbability( arrivals, probDists )

classCount = size(arrivals,2);

P(1:classCount) = 0;
Mu(1:classCount) = 0;

for class = 1:classCount,
    Mu(class) = probDists(class).mean;
end
meanService = arrivals*Mu'/sum(arrivals);

for class = 1:classCount,
    P(class) = 1 - cdf(probDists(class),meanService);
end

end

