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
m=MaxIt/10;
aaaa=exp(log(m)/(m));
p=[1:360];
empty_particle.Position=[];
empty_particle.Cost=[];
% Initialize Global Best
GlobalBest.Cost = -1; % Maximization problem
GlobalBest2.Cost = -1;
GlobalBest3.Cost = -1;
GlobalBest4.Cost = -1;
% Create an empty particle matrix, each particle is a solution (searching path)
particle=repmat(empty_particle,nPop,1);
% Initialization Loop
for i=1:nPop   
    % Initialize Position
    particle(i).Position=CreateRandomSolution(model);   
end

% Array to Hold Best Cost Values at Each Iteration
BestCost=zeros(MaxIt,1);

%% MCSO Main Loop
for it=1:MaxIt
    for i=1:nPop
        % Update Position Bounds
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        % Evaluation
        costP = CostFunction(particle(i).Position);
        particle(i).Cost= costP;
        % Update Global Best
        if particle(i).Cost>GlobalBest.Cost
           GlobalBest=particle(i);
        elseif particle(i).Cost<GlobalBest.Cost && particle(i).Cost>GlobalBest2.Cost
            GlobalBest2=particle(i);
        elseif particle(i).Cost<GlobalBest.Cost && particle(i).Cost<GlobalBest2.Cost && particle(i).Cost>GlobalBest3.Cost
            GlobalBest3=particle(i);
        elseif particle(i).Cost<GlobalBest.Cost && particle(i).Cost<GlobalBest2.Cost && particle(i).Cost<GlobalBest3.Cost && particle(i).Cost>GlobalBest4.Cost
            GlobalBest4=particle(i);
        end
    end
    Globalavg.Position=(GlobalBest.Position+GlobalBest2.Position+GlobalBest3.Position+GlobalBest4.Position)/4;  
    Globalavg.Cost=1;% averaged candidate 
    C_pool=[GlobalBest.Cost; GlobalBest2.Cost; GlobalBest3.Cost;GlobalBest4.Cost; Globalavg.Cost];                     % Equilibrium pool
    for i=1:nPop
        Q1=trnd(aaaa^it/10,[nVar,2]);
        number=randi(size(C_pool,1));
        if number==1
          Ceq=GlobalBest;
        end
        if number==2
          Ceq=GlobalBest2;
        end
        if number==3
          Ceq=GlobalBest3;
        end
        if number==4
          Ceq=GlobalBest4;
        end
        if number==5
          Ceq=Globalavg;
        end
        for j=1:nVar
               teta=RouletteWheelSelection(p);
               BB=(1-exp((1-it/MaxIt)^3))*(2*rand-1)+1;
               AA=(1-it/MaxIt)*(2*rand-1);
                   Rand_position=abs(BB*Ceq.Position(j,:)-particle(i).Position(j,:));
                   cp=floor(nPop*rand()+1);
                   CandidatePosition =particle(cp);
                   Rand_position2=abs(CandidatePosition.Position(j,:)-rand*particle(i).Position(j,:));
                   particle(i).Position(j,:)=Ceq.Position(j,:)-Rand_position*(1-AA)*cos(teta)+Q1(j,:).*Rand_position2*(AA)*sin(teta);

         end    
    end

     BestCost(it)=GlobalBest.Cost;
   
end


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
