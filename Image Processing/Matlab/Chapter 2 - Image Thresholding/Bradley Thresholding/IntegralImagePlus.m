function J = IntegralImagePlus(I)
% Step 1: Get Size of Input Image
[High, Width] = size(I);

% Step 2: Initialize Integral Image Matrix
J = zeros(High, Width);

% Step 3: Loop Over Rows
for i = 1:High
    Sum = 0;
    
    % Step 4: Loop Over Columns
    for j = 1:Width
        % Step 5: Accumulate Row Sum
        Sum = Sum + I(i, j);
        
        % Step 6: Update Integral Image
        if i == 1
            J(i, j) = Sum;
        else
            J(i, j) = J(i - 1, j) + Sum;
        end
    end
end
end
