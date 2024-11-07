function J = IntegralImage(I)
% step 1: Get Size of Input Image
[High, Width] = size(I);

% step 2: Initialize Integral Image Matrix
J = zeros(High, Width);

% step 3: Loop Over Columns
for j = 1:Width
    Sum = 0;
    
    % step 4: Loop Over Rows
    for i = 1:High
        % step 5: Accumulate Column Sum
        Sum = Sum + I(i, j);
        
        % step 6: Update Integral Image
        if j == 1
            J(i, j) = Sum;
        else
            J(i, j) = J(i, j - 1) + Sum;
        end
    end
end
end
