function Decidir(matriz_Distancias, criterio)
    % Buscar candidatos
    for i = 1:size(matriz_Distancias,1)
        candidatos(i) = min(matriz_Distancias(i,:));
        if candidatos(i) > criterio
            candidatos(i) = 1000;
        end
    end
    [~,locutor] = min(candidatos);
    disp(locutor)
end