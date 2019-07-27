function [M, B] = optimalScheduleRecursive( A, vec_M_O_1, vec_P_O_1, P0, O, maxOrder, isComprehensive)
% Minimizes the schedule burstiness B^O given the arrival vector A and
% probability matrix P^0.
% vec_M_O_1 is vectorized M from last order (O-1)
% vec_P_O_1 is $$ vec(P^(O-1)) $$ (refer to eq. 21)
% P0 is the burstiness potential (refer to eq. 4)
% O is the optimization's current order O
% maxOrder is the highest order to optimize for
% isComprehensive == 1 -> comprehensive approach, isComprehensive == 0 ->
% direct approach


% Number of session classes
S = size(A,2);

% calculating P^O
P = vec_P_O_1 * P0;

% continuity check matrix
con = repmat(speye(S^(O-1)), 1, S);

% Optimization using CVX (Mosek) use "cvx_solver Mosek" to select Mosek
% cvx_begin
cvx_begin quiet

variable M(S^O, S) Integer;
% Minimizing Frobenius product
minimize sum(sum(M.*P));

% Constraints
subject toRc
% eq. 33
M >= 0;
% eq. 34
sum(M) == A;
% eq. 36
if(isComprehensive == 1)
    sum(M') == vec_M_O_1;
end
% eq. 35
reshape(M'*con', 1,[]) == sum(M');
cvx_end

% Rounding results to make sure they are integer values (e.g. 0.999999... ->
% 1)
M = round(M);

% Calculating burstiness
B = sum(sum(M.*P))/(sum(A));

% preparing eq. 36 constraint of the next order
vec_M_O_1 = reshape(M', 1, []);

% Preparing transition probabilities for next order
nextP = reshape(P, 1, []);

% Solving for the next order
if(O < maxOrder)
    [M B] = optimalScheduleRecursive(A, vec_M_O_1, nextP', P0, O+1, maxOrder, isComprehensive);
end

end

