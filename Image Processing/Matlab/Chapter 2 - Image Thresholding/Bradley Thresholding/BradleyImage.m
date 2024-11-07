function BW = BradleyImage(I, opts)
%% Start Analysis - Define Parameters
% step 1: Retrieve & Set Options from 'opts' Structure
if isfield(opts, 'Direction'),            Direction = opts.Direction; end
if isfield(opts, 'PadValue'),             PadValue = opts.PadValue;   end

% step 2: Convert Abbreviated Options to Full Descriptions
switch Direction
    case 'Bo';                            Direction = 'Both';
    case 'Pr';                            Direction = 'Pre';
    case 'Po';                            Direction = 'Post';
end
switch PadValue
    case 'Cr';                            PadValue = 'Circular';
    case 'Sm';                            PadValue = 'Symmetric';
    case 'Rp';                            PadValue = 'Replicate';
end

%% step 3: Calculate Integral of Image
% step 3-1: Compute Integral Image & Display It
J = IntegralImage(I);

%% step 4: Binarize Image Based on Bradley Method
BW = zeros(size(I));  % Initialize Binary Output
NeighbourhoodSize = round(size(I) / 8);  % Define Neighborhood Size
S1 = NeighbourhoodSize(1); S2 = NeighbourhoodSize(2);

% step 4-1: Set Sensitivity & Padding Parameters
Nr = round(S1 / 2) + 1; Nc = round(S2 / 2) + 1; T = 20;
JNew = PadArray(J, [Nr, Nc], Direction, PadValue);  % Apply Padding

[Rows, Colms] = size(JNew);

%% step 5: Apply Bradley Thresholding for Each Pixel
for i = Nr + 1:Rows - Nr
    for j = Nc + 1:Colms - Nc
        x1 = i - round(S1 / 2);
        x2 = i + round(S1 / 2);
        y1 = j - round(S2 / 2);
        y2 = j + round(S2 / 2);

        % step 5-1: Compute Local Sum & Compare with Threshold
        Count = (x2 - x1) * (y2 - y1);
        Sum = JNew(x2, y2) - JNew(x1 - 1, y2) - JNew(x2, y1 - 1) + JNew(x1 - 1, y1 - 1);

        if (I(i - Nr, j - Nc) * Count) <= (Sum * (100 - T) / 100)
            BW(i - Nr, j - Nc) = 0;
        else
            BW(i - Nr, j - Nc) = 1;
        end
    end
end
end
