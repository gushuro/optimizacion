function [hijo1, hijo2] = crossover(padre1, padre2)
    hijo1 = padre1 + (padre2-padre1)*1/3;
    hijo2 = padre1 + (padre2-padre1)*2/3;
end
