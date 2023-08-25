
% Convert the encoded motion from an array of 8 numbers to a move
% Eight numbers encode the magnitude of a vector with the angle of
% NW, N, NE, W, E, SW, S, SE
% 1   2   3  4  5   6  7  8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function move = MotionDecode(motion)
    
    % Find the angle of the sum vector
    angle = atan2(motion(2), motion(1));
    
    % Map the angle to its corresponding octant (0, 45, 90, 135 ...)
    octant = mod(round( 8 * angle / (2*pi) + 8 ),8) + 1;

     % Map the octant to a move
     move = moveArray(octant,:);
end
