

function [scaleFactor, newMap] = UpdateMap(currentStep,pathLength,totalMoves,dir, location, map)

    mapSize = size(map);
    mapSizeX = mapSize(1);
    mapSizeY = mapSize(2);
    
    % Target move direction (totalMoves in the total path)
    move = DirToMove(dir);
    
    
end
