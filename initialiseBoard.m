function board = initialiseBoard(difficulty)
% Set board size and number of mines based on difficulty level
if difficulty == 1 % Easy
    numRows = 5;
    numColumns = 5;
    numMines = 5;
elseif difficulty == 2 % Medium
    numRows = 8;
    numColumns = 8;
    numMines = 8;
elseif difficulty == 3 % Hard
    numRows = 11;
    numColumns = 11;
    numMines = 11;
else
    error('Invalid difficulty level'); % Invalid difficulty
end

boardSize = [numRows, numColumns]; % Board size

% Initialise board with zeros
board = zeros(boardSize);

% Place mines randomly on board
for i = 1:numMines
    while true
        rndRow = randi(numRows);
        rndCol = randi(numColumns);
        if board(rndRow,rndCol) ~= -1 % Make sure the position is not already a mine
            board(rndRow,rndCol) = -1;
            break;
        end
    end
end

end
