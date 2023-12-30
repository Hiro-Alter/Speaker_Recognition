function Crear_Base_Datos_MFCC(fs, nfft, nfilters, ncoef)
    % Cargar los audios en un arreglo
    carpeta = 'locutores\audios';
    carpeta_Save = 'locutores\MFCCs';
    archivos = dir(fullfile(carpeta, '*.wav'));
    
    % Itera sobre cada archivo de la carpeta
    for i = 1:numel(archivos)
        % Cargar el archivo
        clear y;
        x_Title = fullfile(carpeta, archivos(i).name);
        
        % Lee los datos de audio del archivo
        [x, fs_original] = audioread(x_Title);

        % Resample
        y(1,:) = resample(x(:,1), fs, fs_original);
        
        % Crear la matriz MFCC
        y = Eliminar_Silencio(y, fs);
        y = Segmentar(y, fs);
        y = MFCC(y, nfilters, fs, nfft, ncoef);

        % Guardar la matriz
        save(fullfile(carpeta_Save,[strrep(archivos(i).name, '.wav', ''), '.mat']), 'y');
    end
end