function Mu = ImageMean(I, Nr, Nc, Dir)
% Calculates a Local Mean Threshold Matrix, Mu, for Grayscale Image I
% Based on a Neighborhood Defined by Nr and Nc. The Direction Parameter
% Determines Whether the Mean Is Calculated with Pre, Post, or Both Padding.

[Rows, Colms] = size(I);
switch Dir
    case 'Pre'
        % Step 1: Loop Over Rows with Pre Padding
        for i = Nr + 1:Rows
            % Step 2: Loop Over Columns, Avoiding Boundaries
            for j = Nc + 1:Colms
                % Step 3: Extract Neighborhood Around (i, j)
                Temp = I(i - Nr:i, j - Nc:j);
                % Step 4: Assign Mean of Neighborhood to Mu
                Mu(i - Nr, j - Nc) = mean(Temp(:));
            end
        end

    case 'Post'
        % Step 5: Loop Over Rows with Post Padding
        for i = 1:Rows - Nr
            % Step 6: Loop Over Columns with Post Padding
            for j = 1:Colms - Nc
                % Step 7: Extract Neighborhood Region (Post)
                Temp = I(i:i + Nr, j:j + Nc);
                % Step 8: Store Mean in Mu (Post)
                Mu(i, j) = mean(Temp(:));
            end
        end

    case 'Both'
        % Step 9: Loop Over Rows with Both Padding
        for i = Nr + 1:Rows - Nr
            % Step 10: Loop Over Columns with Both Padding
            for j = Nc + 1:Colms - Nc
                % Step 11: Extract Neighborhood Region (Both)
                Temp = I(i - Nr:i + Nr, j - Nc:j + Nc);
                % Step 12: Store Mean in Mu (Both)
                Mu(i - Nr, j - Nc) = mean(Temp(:));
            end
        end

    otherwise
        error('Invalid Direction. Choose from "Pre", "Post", or "Both".');
end
end
