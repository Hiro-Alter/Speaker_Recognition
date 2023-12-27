function [matriz_Audio] = Segmentar(x, fs)
    % Definiciones
    length_signal = length(x);                                  % Logitud de la señal
    length_segment = 0.03*fs;                                   % Longitud de los segmentos
    number_segments = ceil(length_signal/length_segment);       % Numero de segmentos
    matriz_Audio = zeros(length_segment, number_segments);      % Matriz de segmentos
    window = hamming(length_segment).';                         % Ventana de hamming

    % Verificar si se excede el tamaño de la señal de entrada
    if number_segments*length_segment > length_signal
        x = [x, zeros(1, number_segments*length_segment - length_signal)];
    end

    % Operaciones
    for i = 0:number_segments-1
        aux = i*length_segment+1;
        matriz_Audio(1:length_segment,i+1) = (x(aux:aux+length_segment-1).*window);
        %disp("OK");
    end
end
