
function valid = CheckMotion(position, model)
    
    % Load model parameters
    n=model.n;
    xs = model.xs;
    ys = model.ys;
    path = zeros(n,2);  % The path consists of n nodes, each node is (x,y)
    currentNode = [xs ys];
    valid = true;
    
    % Decode from the motions to a path
    for i=1:n
      
    end
   
    % Check duplicate rows
    [u,I,J] = unique(path, 'rows', 'first');
    if size(u,1) < size(path,1)
        valid = false;
        return
    end

end
