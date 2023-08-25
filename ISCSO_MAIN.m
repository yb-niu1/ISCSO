% Find a path that maximizes the probability of finding object
% 
clc;
clear;
close all;

%% Create the search scenario

model = CreateModel(); % Create search map and parameters

CostFunction=@(x) MyCost(x,model);    % Cost Function

nVar = model.n;       % Number of Decision Variables = searching dimension of PSO = number of movements

VarSize=[nVar 2];   % Size of Decision Variables Matrix

VarMin=-model.MRANGE;           % Lower Bound of particles (Variables)
VarMax = model.MRANGE;          % Upper Bound of particles 

MaxIt=100;          % Maximum Number of Iterations
nPop=100;           % Population Size (Swarm Size)

p=[1:360];
empty_particle.Position=[];
empty_particle.Cost=[];
% Initialize Global Best

% Create an empty particle matrix, each particle is a solution (searching path)
particle=repmat(empty_particle,nPop,1);
% Initialization Loop
for i=1:nPop   
    % Initialize Position
    particle(i).Position=CreateRandomSolution(model);   
end

% Array to Hold Best Cost Values at Each Iteration
BestCost=zeros(MaxIt,1);

%% ICSO Main Loop


%% Results
% Updade Map in Accordance to the Target Moves
targetMoves = model.targetMoves; % Number of Target Moves (Zero means static)
moveDir = DirToMove(model.targetDir); % Direction of the Target Movement
moveArr = targetMoves*moveDir;
updatedMap = noncircshift(model.Pmap, moveArr);
newModel = model;
newModel.Pmap = updatedMap;

% Plot Solution
figure(1);
path=PathFromMotion(GlobalBest.Position,model); % Convert from Motion to Cartesian Space 
PlotSolution(path,newModel);  

% Plot Best Cost Over Iterations
figure(2);
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
