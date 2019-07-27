function [ schedule, deadEnd ] = traverseLookAheadRandom( M, schedule )
%walkMarkovChainLookAheadRandom generates a schedule from M as in Algorithm
%1

S = size(M, 2);
order = round(log(size(M, 1))/log(S));

global deadEndCounter;

if (isempty(schedule)==1)
    [col row] = find(M'); % col and row reversed because M is transposed

    startingIndex = randi(size(row,1));
    schedule = getStates(row(startingIndex), col(startingIndex), S, order);
    M(row(startingIndex), col(startingIndex))= M(row(startingIndex), col(startingIndex))-1;
    
    [schedule, deadEnd] = traverseLookAheadRandom(M, schedule);
    
    
else
    stepsLeft = sum(sum(M));
    if(stepsLeft>0)
        currentRow = schedule(end-order+1:end);
        decRow = getRowNoColumn(currentRow, S);
        [tmp col2] = find(M(decRow,:));
        nonZeroColumns = size(col2, 2);
        if(nonZeroColumns == 0)
            deadEnd = 1;
            deadEndCounter = deadEndCounter + 1;
            schedule = schedule(1:end-1);
            return
        else
            randomColumnIndex = randperm(nonZeroColumns);
            for c=1:nonZeroColumns,
                MTemp = M;
                MTemp(decRow, col2(randomColumnIndex(c)))= MTemp(decRow, col2(randomColumnIndex(c)))-1;
                scheduleTemp = [schedule col2(randomColumnIndex(c))];
                [schedule, deadEnd] = traverseLookAheadRandom(MTemp, scheduleTemp);
                if(deadEnd == 0)
                    return;
                end
            end
            deadEnd = 1;
            deadEndCounter = deadEndCounter + 1;
            schedule = schedule(1:end-1);
            return;
        end

    end
end
deadEnd = 0;

end

