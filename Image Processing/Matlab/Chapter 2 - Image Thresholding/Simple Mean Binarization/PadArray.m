function PadIm = PadArray(I, Size, Dir, Type)
% The Function Accommodates Both Grayscale & Color Images. For Color Images,
% Each Color Channel Is Processed Independently, & the Final Padded Channels 
% Are Combined to Produce the Output Image `PadIm`. Based on the Selected 
% `Dir` & `Type`, Padding Is Applied Accordingly for Each Case to Handle 
% Boundaries Effectively & Create a Consistent Padded Result.

%% Step 1: Set Default Values for Dir and Type
if nargin < 3 || isempty(Dir)
    Dir = 'Both';                                                            % Default Direction is 'both'
end
if nargin < 4 || isempty(Type)
    Type = 'zeros';                                                          % Default Padding Type is 'zeros'
end

%% Step 2: Check if the Input is Grayscale or Color
if ndims(I) == 3
    % Step 2-1: Separate the Color Channels & Pad Each Channel Individually
    R = PadArray(I(:, :, 1), Size, Dir, Type);
    G = PadArray(I(:, :, 2), Size, Dir, Type);
    B = PadArray(I(:, :, 3), Size, Dir, Type);
    % Step 2-2: Concatenate Padded Channels to form a Color Image
    PadIm = cat(3, R, G, B);
    return;
end

%% Step 3: Initialize Variables
[r, c] = size(I);
Pr = Size(1); Pc = Size(2);

if strcmp(Dir, 'Both')
    % Step 3-1: Pad on both sides
    PadIm = zeros(r + 2 * Pr, c + 2 * Pc, 'like', I);
    Rs = Pr + 1;
    Re = Rs + r - 1;
    Cs = Pc + 1;
    Ce = Cs + c - 1;
elseif strcmp(Dir, 'Pre')
    % Step 3-2: Pad only before rows and columns
    PadIm = zeros(r + Pr, c + Pc, 'like', I);
    Rs = Pr + 1;
    Re = Rs + r - 1;
    Cs = Pc + 1;
    Ce = Cs + c - 1;
elseif strcmp(Dir, 'Post')
    % Step 3-3: Pad only after rows and columns
    PadIm = zeros(r + Pr, c + Pc, 'like', I);
    Rs = 1;
    Re = Rs + r - 1;
    Cs = 1;
    Ce = Cs + c - 1;
end
PadIm(Rs:Re, Cs:Ce) = I;

%% Step 4: Apply Padding Based on Type
switch Type
    % Step 4-1: Zero Padding is Already set by Default During Initialization
    case 'zeros'

    case 'ones'
        PadIm(:) = 1;                                                       % Fill the Entire Padded Image with Ones
        PadIm(Rs:Re, Cs:Ce) = I;                                            % Place the Original Image in the Center of the Padded Image

    case 'Replicate'
        if strcmp(Dir, 'Both') || strcmp(Dir, 'Pre')
            PadIm(1:Rs - 1, Cs:Ce) = repmat(I(1, :), Pr, 1);                % Top Padding: Replicate the First Row of the Image
            PadIm(Rs:Re, 1:Cs - 1) = repmat(I(:, 1), 1, Pc);                % Left Padding: Replicate the First Column of the Image
            PadIm(1:Rs - 1, 1:Cs - 1) = I(1, 1);                            % Top-Left Corner
            PadIm(1:Rs - 1, Ce + 1:end) = I(1, end);                        % Top-Right Corner
        end
        if strcmp(Dir, 'Both') || strcmp(Dir, 'Post')
            PadIm(Re + 1:end, Cs:Ce) = repmat(I(end, :), Pr, 1);            % Bottom Padding: Replicate the Last Row of the Image
            PadIm(Rs:Re, Ce + 1:end) = repmat(I(:, end), 1, Pc);            % Right Padding
            PadIm(Re + 1:end, 1:Cs - 1) = I(end, 1);                        % Bottom-Left Corner
            PadIm(Re + 1:end, Ce + 1:end) = I(end, end);                    % Bottom-Right Corner
        end

    case 'Circular'
        if strcmp(Dir, 'Pre')
            % Step 4-2: Pre-padding for circular
            PadIm(1:Rs - 1, Cs:Ce) = I(end - Pr + 1:end, :);                % Top Padding
            PadIm(Rs:Re, 1:Cs - 1) = I(:, end - Pc + 1:end);                % Left Padding
            PadIm(1:Rs - 1, 1:Cs - 1) = I(end - Pr + 1:end, end - Pc + 1:end); % Top-Left Corner
        elseif strcmp(Dir, 'Post')
            % Step 4-3: Post-padding for circular
            PadIm(Re + 1:end, Cs:Ce) = I(1:Pr, :);                          % Bottom Padding
            PadIm(Rs:Re, Ce + 1:end) = I(:, 1:Pc);                          % Right Padding
            PadIm(Re + 1:end, Ce + 1:end) = I(1:Pr, 1:Pc);                  % Bottom-Right Corner
        elseif strcmp(Dir, 'Both')
            % Step 4-4: Both-sides padding for circular
            PadIm(1:Rs - 1, Cs:Ce) = I(end - Pr + 1:end, :);                % Top Padding
            PadIm(Re + 1:end, Cs:Ce) = I(1:Pr, :);                          % Bottom Padding
            PadIm(Rs:Re, 1:Cs - 1) = I(:, end - Pc + 1:end);                % Left Padding
            PadIm(Rs:Re, Ce + 1:end) = I(:, 1:Pc);                          % Right Padding
            PadIm(1:Rs - 1, 1:Cs - 1) = I(end - Pr + 1:end, end - Pc + 1:end); % Top-Left Corner
            PadIm(1:Rs - 1, Ce + 1:end) = I(end - Pr + 1:end, 1:Pc);        % Top-Right Corner
            PadIm(Re + 1:end, 1:Cs - 1) = I(1:Pr, end - Pc + 1:end);        % Bottom-Left Corner
            PadIm(Re + 1:end, Ce + 1:end) = I(1:Pr, 1:Pc);                  % Bottom-Right Corner
        end

    case 'Symmetric'
        if strcmp(Dir, 'Pre')
            % Step 4-5: Pre-padding for symmetric
            PadIm(1:Rs - 1, Cs:Ce) = flipud(I(1:Pr, :));                    % Top Padding
            PadIm(Rs:Re, 1:Cs - 1) = fliplr(I(:, 1:Pc));                    % Left Padding
            PadIm(1:Rs - 1, 1:Cs - 1) = flipud(fliplr(I(1:Pr, 1:Pc)));      % Top-Left Corner
        elseif strcmp(Dir, 'Post')
            % Step 4-6: Post-padding for symmetric
            PadIm(Re + 1:end, Cs:Ce) = flipud(I(end - Pr + 1:end, :));      % Bottom Padding
            PadIm(Rs:Re, Ce + 1:end) = fliplr(I(:, end - Pc + 1:end));      % Right Padding
            PadIm(Re + 1:end, Ce + 1:end) = flipud(fliplr(I(end - Pr + 1:end, end - Pc + 1:end))); % Bottom-Right Corner
        elseif strcmp(Dir, 'Both')
            % Step 4-7: Both-sides padding for symmetric
            PadIm(1:Rs - 1, Cs:Ce) = flipud(I(1:Pr, :));                    % Top Padding
            PadIm(Re + 1:end, Cs:Ce) = flipud(I(end - Pr + 1:end, :));      % Bottom Padding
            PadIm(Rs:Re, 1:Cs - 1) = fliplr(I(:, 1:Pc));                    % Left Padding
            PadIm(Rs:Re, Ce + 1:end) = fliplr(I(:, end - Pc + 1:end));      % Right Padding
            PadIm(1:Rs - 1, 1:Cs - 1) = flipud(fliplr(I(1:Pr, 1:Pc)));      % Top-Left Corner
            PadIm(1:Rs - 1, Ce + 1:end) = flipud(fliplr(I(1:Pr, end - Pc + 1:end))); % Top-Right Corner
            PadIm(Re + 1:end, 1:Cs - 1) = flipud(fliplr(I(end - Pr + 1:end, 1:Pc))); % Bottom-Left Corner
            PadIm(Re + 1:end, Ce + 1:end) = flipud(fliplr(I(end - Pr + 1:end, end - Pc + 1:end))); % Bottom-Right Corner
        end
end
end
