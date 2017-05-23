function gradNumerico=gradNumerico(f,x,w) % f=f(x,w)
    z = zeros(size(x,2)-1,1);
    for j = 1:size(x,2)-1
        h = x(j+1) - x(j);
        z(j) = (f(x(j+1),w(j)) - f(x(j),w(j)))/h; % forward para fx
    end

    for j = 1:size(x,2)-1
        h = w(j+1) - w(j);
        z1(j) = (f(x(j),w(j+1)) - f(x(j),w(j)))/h; % forward para fw
    end
    gradNumerico= [z,z1];
     
    % REVISAR