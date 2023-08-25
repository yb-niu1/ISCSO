

% Plot the search path

function PlotSolution(tour,model)
    
    MAP_SIZE = model.MAPSIZE;
    N = model.n; % Path length
    x = 1:1:MAP_SIZE; y = 1:1:MAP_SIZE; % x & y from 0 to 20
    [X,Y] = meshgrid(x,y); % Replicate x & y to create a rectangular grid (X,Y) 
    clf('reset');
    h = pcolor(X,Y,model.Pmap);
    hold on;
    
    tourX =  tour(:,1) + model.xmax+0.5 ;
    tourY = tour(:,2) + model.ymax+0.5 ;

    plot(tourX,tourY,'w-o',...
        'MarkerSize',3,...
        'MarkerFaceColor','w',...
        'LineWidth',1);

    plot(tourX(1),tourY(1),'r-o',...
        'MarkerSize',2,...
        'MarkerFaceColor','r',...
        'LineWidth',1);
      
    xlabel('x (cell)');
    ylabel('y (cell)');
    
    % Set properties
    set(h,'linewidth',0.1);
    cb = colorbar; 
    cb.Ruler.Exponent = -3;
    gcaP=get(gca,'position');
    cbP=get(cb,'Position');
    cbP(3)=cbP(3)/2; % change the colorbar width
    set(cb,'Position',cbP)
    set(gca,'position',gcaP)
    set(gcf,'position',[300,100,350,250]); % Set the map size

end