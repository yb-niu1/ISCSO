

% Convert from the target direction to a corresponding move in the map 

function move = DirToMove(dir)
    switch dir
        case 'N'
            move = [1 0];
        case 'NE'
            move = [1 1];
        case 'E'
            move = [0 1];
        case 'SE'
            move = [-1 1];
        case 'S'
            move = [-1 0];
        case 'SW'
            move = [-1 -1];
        case 'W'
            move = [0 -1];
        case 'NW'
            move = [1 -1];
    end
end