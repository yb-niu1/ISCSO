
% Create the search map with initial belief
%

function model=CreateModel()
    
    %% Create a grid map
    MAP_SIZE = 40;
    x = 1:1:MAP_SIZE; y = 1:1:MAP_SIZE; 
    [X,Y] = meshgrid(x,y); % replicate x & y to create a rectangular grid (X,Y) 

    % Generate the probability map
    mu1 = [10 10];  % Mean of the first distribution (Potential target position)
    Sigma1 = MAP_SIZE*[0.1 0;0 0.1]; % Covarian of the distribution
    F1 = mvnpdf([X(:) Y(:)],mu1,Sigma1);
    F1 = reshape(F1,length(y),length(x));  % Convert F to a matrix
    F1 = F1/sum(F1(:)); % Scale to the total of one
    

    
    Pmap = F1; % Scale the probability for two information sources about the target
    
    %% Settings
    % Map limits
    xmin= -floor(MAP_SIZE/2);
    xmax= floor(MAP_SIZE/2);
    
    ymin= -floor(MAP_SIZE/2);
    ymax= floor(MAP_SIZE/2);
    
    % Initial searching position
    xs=0;
    ys=0;
    
    % Number of path nodes (not including the start position (start node))
    n=20;
    
    % Motion range
    MRANGE = 4;
    
    %% Incorporate the map and search parameters into a model
    model.xs=xs;
    model.ys=ys;
    model.Pmap=Pmap;
    model.n=n;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    model.MRANGE = MRANGE;
    model.MAPSIZE = MAP_SIZE;
    model.X = X;
    model.Y = Y;
    model.targetMoves = 10; % Must be divisible by the path length (e.g, mod(N,move)=0)
    model.targetDir = 'E';  % The target moves in East direction 

end
