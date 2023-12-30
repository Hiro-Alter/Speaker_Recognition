function [matriz_Distancias] = Comparar(MFCC1)

    % Cargar los audios en un arreglo
    carpeta = 'locutores\MFCCs';
    archivos = dir(fullfile(carpeta, '*.mat'));

    % Realizar el calculo de la distancia euclidiana
    matriz_Distancias = zeros(4,3);         % El # de filas corresponde a la cantidad de locutores, # columnas muestras de audio
    i = 1; z = 1;
    % Itera sobre cada archivo de la carpeta
    for j = 1:numel(archivos)
        % Cargar el archivo
        clear y;
        x_Title = fullfile(carpeta, archivos(j).name);
        
        % Lee los datos de audio del archivo
        matriz_Load = load(x_Title);
        x = matriz_Load.y;
        
        % Calcula la distancia euclidiana
        matriz_Distancias(i,z) = dtw(x,MFCC1);
        z = z+1;
        if z > 3
            i = i+1;
            z = 1;
        end
    end
end
