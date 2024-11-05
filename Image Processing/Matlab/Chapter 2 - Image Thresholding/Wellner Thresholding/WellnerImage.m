function BW = WellnerImage(I, opts)
%% Start Analysis - Define Parameters
if isfield(opts, 'Method'),               Method = opts.Method; end
if isfield(opts, 'PadValue'),             PadValue = opts.PadValue; end


switch  PadValue
    case 'Cr';                          PadValue = 'Circular';
    case 'Sm';                          PadValue = 'Symmetric';
    case 'Rp';                          PadValue = 'Replicate';
end
%% step 1: Define S & T
[~, Width] = size(I);
T = 15; S = round(Width / 8);
switch Method
    case 'LR'
        %% step 2: Pre - Padding Image
        Nr = 0; Nc = S; Direction = 'Pre';
        J = PadArray(I, [Nr Nc], Direction, PadValue);
        [Rows, Colms] = size(J);
        BW = zeros(size(I));
        %% step 3: Thresholding based on Wellner Method
        for i = 1:Rows
            for j = Nc + 1:Colms
                Temp = J(i, j - Nc:j - 1);
                Fs = sum(Temp);
                Pn = J(i, j);
                if Pn > ( (Fs / S) * ((100 - T) / 100) )
                    BW(i, j - Nc) = 1;
                else
                    BW(i, j - Nc) = 0;
                end
            end
        end
    case 'RL'
        %% step 4: Post - Padding Image
        Nr = 0; Nc = S; Direction = 'Post';
        J = PadArray(I, [Nr Nc], Direction, PadValue);
        [Rows, Colms] = size(J);
        BW = zeros(size(I));
        %% step 3: Thresholding based on Sudo - Wellner Method
        for i = 1:Rows
            for j = 1:Colms - Nc
                Temp = J(i, j:j + Nc);
                Fs = sum(Temp);
                Pn = J(i, j);
                if Pn > ( (Fs / S) * ((100 - T) / 100) )
                    BW(i, j) = 1;
                else
                    BW(i, j) = 0;
                end
            end
        end
    case 'UD'
        %% step 5: Post - Padding Image
        Nr = S; Nc = 0; Direction = 'Pre';
        J = PadArray(I, [Nr Nc], Direction, PadValue);
        [Rows, Colms] = size(J);
        BW = zeros(size(I));
        %% step 6: Thresholding based on Sudo - Wellner Method
        for i = Nr + 1:Rows
            for j = 1:Colms
                Temp = J(i  - Nr:i - 1, j);
                Fs = sum(Temp);
                Pn = J(i, j);
                if Pn > ( (Fs / S) * ((100 - T) / 100) )
                    BW(i - Nr, j) = 1;
                else
                    BW(i - Nr, j) = 0;
                end
            end
        end
    case 'DU'
        %% step 7: Padding Image
        Nr = S; Nc = 0; Direction = 'Post';
        J = PadArray(I, [Nr Nc], Direction, PadValue);
        [Rows, Colms] = size(J);
        BW = zeros(size(I));
        %% step 8: Thresholding based on Wellner Method
        for i = Nr + 1:Rows
            for j = 1:Colms
                Temp = J(i  - Nr:i - 1, j);
                Fs = sum(Temp);
                Pn = J(i, j);
                if Pn > ( (Fs / S) * ((100 - T) / 100) )
                    BW(i - Nr, j) = 1;
                else
                    BW(i - Nr, j) = 0;
                end
            end
        end

end

end