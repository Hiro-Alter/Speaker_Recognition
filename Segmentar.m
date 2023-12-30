function [matriz_Audio] = Segmentar(x, fs)
    % Parametros
    length_signal = length(x);                                      % Logitud de la señal
    length_segment = round(0.03*fs);                                % Longitud de los segmentos
    overlap = round(0.01*fs);                                       % Solapamiento
    step = length_segment - overlap;                                % Paso entre segmentos

    % Calcular el número total de segmentos
    number_segments = floor((length_signal - overlap) / step);

    % Ajustar la longitud de la señal para que se pueda dividir en segmentos
    x = x(1:number_segments * step + overlap);

    % Inicializar la matriz de segmentos
    matriz_Audio = zeros(length_segment, number_segments);

    % Ventana de Hamming
    window = hamming(length_segment).';

    % Operaciones
    for i = 1:number_segments
        start_idx = (i-1) * step + 1;
        end_idx = start_idx + length_segment - 1;
        matriz_Audio(:, i) = (x(start_idx:end_idx) .* window).';
    end
end

