function who = Decidir(matriz_Distancias, criterio)
    who = 0;
    % Buscar candidatos
    for i = 1:size(matriz_Distancias,1)
        candidatos(i) = min(matriz_Distancias(i,:));
        candidatos_Promedio(i) = sum(matriz_Distancias(i,:))/size(matriz_Distancias, 2);
        if candidatos(i) > criterio
            candidatos(i) = 1000;
        end
        if candidatos_Promedio(i) > criterio
            candidatos_Promedio(i) = 1000;
        end
    end

    % Verificar que tanto el promedio e individual sean los menores
    for i = 1:size(matriz_Distancias,1)
        if candidatos_Promedio(i) == min(candidatos_Promedio) && candidatos(i) == min(candidatos)
            if min(candidatos) ~= 1000 && min(candidatos_Promedio) ~= 1000
                who = i;
            else 
                disp('No hay candidatos')
            end
        end
    end
    
    %[~,locutor] = min(candidatos);
    %disp(locutor)
end