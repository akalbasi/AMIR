function [ B ] = calculateScheduleBurstiness( schedule, order, P )
%UNTITLED6 Calculates burstiness for given order
%   Detailed explanation goes here

% if(circular == 1)
%     trim = 0;
%     
% else
%     trim = order;
% end
schedule = [schedule schedule(1:order)];
windowCount = size(schedule, 2)-order
sumBurstiness = 0;
for w=1:windowCount,
    currentWindowBurstiness = 1;
    currentWindow = schedule(w:w+order);
    for wi=1:size(currentWindow, 2),
       currentWindowBurstiness = currentWindowBurstiness * P(currentWindow(wi));
    end
   sumBurstiness = sumBurstiness + currentWindowBurstiness;
end

B = sumBurstiness/windowCount;

end

