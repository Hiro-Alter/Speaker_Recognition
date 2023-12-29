function matriz_Filtros = Banco_de_Filtros_MEL(n, fs, nfft)
    % Parámetros
    sample_rate = fs;                                                   % Frecuencia de muestreo
    NFFT = nfft;                                                        % Numero de puntos de la FFT (completa)
    nfilt = n;                                                          % Cantidad de filtros MEL
    low_freq_mel = 0;                                                   % Frecuencia minima
    high_freq_mel = 2595 * log10(1 + (sample_rate / 2) / 700);          % Frecuencia maxima
    mel_points = linspace(low_freq_mel, high_freq_mel, nfilt + 2);      % Puntos en la escala MEL
    hz_points = 700 * (10 .^ (mel_points / 2595) - 1);                  % Puntos en Hz
    bin = floor((NFFT + 1) * hz_points / sample_rate);                  % Pasos

    % Crear el banco de filtros mel
    matriz_Filtros = zeros(nfilt, floor(NFFT / 2 + 1));

    % Calcular los filtros
    for m = 2:nfilt+1
        f_m_minus = bin(m - 1);   % izquierda
        f_m = bin(m);             % centro
        f_m_plus = bin(m + 1);    % derecha
    
        for k = f_m_minus+1:f_m
            matriz_Filtros(m-1, k) = (k - bin(m - 1)) / (bin(m) - bin(m - 1));
        end
    
        for k = f_m:f_m_plus
            matriz_Filtros(m-1, k) = (bin(m + 1) - k) / (bin(m + 1) - bin(m));
        end
    end
    matriz_Filtros = matriz_Filtros.';
end