

%
% Create random paths (solutions)
% 

function position=CreateRandomSolution(model)

    n=model.n;  % Load the number of path nodes
    startNode = [model.xs model.ys];
    path = zeros(n,2);  % path initialization
    MaxIt = 100; % Maximum number of trial iterations before resetting the path

    motions = [];
             
    should_restart = true;
    
    % Repeat until generating a valid path
    while should_restart
        should_restart = false;
        for i = 1:n
            path(i,:) = startNode;
        end
        position = zeros(n,2); % motion initialisation
        currentNode = startNode;
        for i=1:n
            
               
            % Restart the whole path
            if (it >= MaxIt)
                should_restart = true;
                break;
            else    % Path ok
                path(i,:) = nextNode;
                currentNode = nextNode;
                position(i,:) = motion;
            end
        end
    end
end
