% MATLAB PROJECT - MINESWEEPER
clear
clc
% Initialise the game

% Prompt user for difficulty level
validDifficulty = false;
while ~validDifficulty
    difficulty = input('Choose a difficulty level (1 = easy, 2 = medium, 3 = hard): ', 's');
    if ~isempty(difficulty) && all(isstrprop(difficulty, 'digit')) && ismember(str2double(difficulty), [1 2 3])
        validDifficulty = true;
    else
        fprintf('Invalid difficulty. Please try again.\n');
    end
end


% Initialise the board based on chosen difficulty
board = initialiseBoard(str2double(difficulty));


% Create a new matrix to store the number of adjacent mines

adjMinesBoard = zeros(size(board));

[rows, cols] = size(board);

% Count number of mines
numMines = 0;

for i = 1:rows % Loop through each element of matrix
    for j = 1:cols
        if board(i,j) == -1
            numMines = numMines + 1;
        end
    end
end 
% Calculate the number of adjacent mines for each square on the board and
% update those values

for r = 1:rows % Loop through each element in the matrix
    for c = 1:cols
        % Check if the current element is a mine
        if board(r, c) == -1
            adjMinesBoard(r, c) = -1;  % Set the adjacent mines to -1
        else
            % Count the number of adjacent mines
            count = 0;
            for i = -1:1
                for j = -1:1
                    % Skip the current element
                    if i == 0 && j == 0
                        continue;
                    end                                                         %Inner Nested Loop ref(Chatgpt, chat.openai.com)
                    % Check if the adjacent element is a mine
                    if r+i >= 1 && r+i <= rows && c+j >= 1 && c+j <= cols && board(r+i, c+j) == -1
                        count = count + 1; % Add 1 to number
                    end
                end
            end
            adjMinesBoard(r, c) = count; % Change cell number to number of adjacent mines
        end
    end
end

% Initialize game state
gameOver = false;
numUncovered = 0;
revealed = zeros(rows,cols); % keeps track of which cells have been revealed
flagged = zeros(rows,cols); % keeps track of which cells have been flagged

% Game loop
while ~gameOver
    % Print the board
    % Print column numbers
    fprintf('   ');
    for j = 1:cols
        fprintf('%d ', j);
    end
    fprintf('\n');
    
    % Print row numbers and cells
    for i = 1:rows
        % Print row number
        fprintf('%2d ', i);
        
        % Print cells in the row
        for j = 1:cols
            if flagged(i,j) == 1 % print flag
                fprintf('F');
            elseif revealed(i,j) == 1 % print cell contents
                if board(i,j) == -1 % print mine
                    fprintf('*');
                else % print number of adjacent mines
                    fprintf('%d', adjMinesBoard(i,j));
                end
            else % print hidden cell
                fprintf('-');
            end
            fprintf(' '); % add space between cells
        end
        
        fprintf('\n'); % add newline after each row
    end
    
    % Prompt user for input
    validInput = false;
    while ~validInput
        row = input('Enter row: ', 's'); % accept input as string
        col = input('Enter column: ', 's'); % accept input as string
        action = input('Enter action (1 = reveal, 2 = flag/unflag): ', 's'); % accept input as string
        
        % check if input is not empty and contains only digits
        if ~isempty(row) && ~isempty(col) && ~isempty(action) && all(isstrprop(row, 'digit')) && all(isstrprop(col, 'digit')) && all(isstrprop(action, 'digit'))
            % convert inputs to numeric type
            row = str2double(row);
            col = str2double(col);
            action = str2double(action);
            
            % check if inputs are within valid range
            if row >= 1 && row <= rows && col >= 1 && col <= cols && (action == 1 || action == 2)
                validInput = true;
            end
        end
        
        if ~validInput
            fprintf('Invalid input. Please try again.\n');
        end
    end


    % Process user input
    if action == 1 % reveal cell
        if flagged(row,col) == 1 % Check if cell is flagged
            fprintf("Cell is flagged! Unflag it to proceed\n")
        elseif board(row,col) == -1 % lose condition
            fprintf('You lose!\n');
            gameOver = true; 
        elseif revealed(row,col) == 1 % Check if cell is already revealed
            fprintf("Cell is already revealed!\n")
        else % reveal cell and check for win condition
            numUncovered = numUncovered + 1;
            revealed(row,col) = 1;
            if numUncovered == rows*cols - numMines % win condition
                fprintf('You win!\n');
                gameOver = true;
            end
        end
    elseif action == 2 % flag/unflag cell
        if flagged(row,col) == 1 % unflag cell
            flagged(row,col) = 0;
        elseif revealed(row,col) == 0 % flag cell
            flagged(row,col) = 1;
        elseif revealed(row,col) == 1 % Cell already revealed
            fprintf("Cell is already revealed!\n")
        end
    end
end

% References:
% Chatgpt, chat.openai.com (Line 114, Line 56)
% Mathworks, Mathworks.com (Line 114)
% Github, Github.com



