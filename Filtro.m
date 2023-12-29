function [y] = Filtro(x)
    % Especificaciones
    b = [1 -0.98];
    % Pendiente
    y = filter(b,1,x);
end