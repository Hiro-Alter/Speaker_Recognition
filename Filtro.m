function [y] = Filtro()
    % Especificaciones
    f = [0 0.3 0.4 0.5 0.6 1];
    a = [1 1 1 1 0 0];
    M=150;
    % Calculo del filtro
    y = firpm(M-1,f,a);
    y = y.';
end