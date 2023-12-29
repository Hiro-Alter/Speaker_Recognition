function dtwDistance = calculateDTW(mfccMatrix1, mfccMatrix2)
    % Calcula la distancia DTW entre dos matrices de MFCC
    
    % Obtén las longitudes de las secuencias
    len1 = size(mfccMatrix1, 2);
    len2 = size(mfccMatrix2, 2);

    % Inicializa la matriz de costos acumulativos
    costMatrix = zeros(len1, len2);

    % Calcula la matriz de costos acumulativos
    for i = 1:len1
        for j = 1:len2
            % Calcula la distancia euclidiana entre los vectores de MFCC en los puntos i y j
            cost = norm(mfccMatrix1(:, i) - mfccMatrix2(:, j));
            
            % Rellena la matriz de costos acumulativos
            if i == 1 && j == 1
                costMatrix(i, j) = cost;
            elseif i == 1
                costMatrix(i, j) = cost + costMatrix(i, j - 1);
            elseif j == 1
                costMatrix(i, j) = cost + costMatrix(i - 1, j);
            else
                costMatrix(i, j) = cost + min([costMatrix(i - 1, j), costMatrix(i, j - 1), costMatrix(i - 1, j - 1)]);
            end
        end
    end
    figure;
    imagesc(costMatrix);
    % La distancia DTW es el valor en la esquina inferior derecha de la matriz de costos acumulativos
    dtwDistance = costMatrix(len1, len2);
end
