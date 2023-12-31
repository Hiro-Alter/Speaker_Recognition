function [y] = Eliminar_Silencio(x, fs)
    % Parametros
    length_signal = length(x);                                  % Logitud de la señal
    length_segment = 0.01*fs;                                   % Longitud de los segmentos
    number_segments = ceil(length_signal/length_segment);       % Numero de segmentos
    threshold = 0.2;                                            % Umbral de energia
    y = [];

    % Normalizacion
    peak = max(abs(x));
    x = x/peak;
    avarege_Energy = sum(x.*x)/length_signal;

    %figure
    %subplot(1,2,1)
    %plot(x);

    % Verificar si se excede el tamaño de la señal de entrada
    if number_segments*length_segment > length_signal
        x = [x, zeros(1, number_segments*length_segment - length_signal)];
    end
    
    % Eliminar silencios
    for i = 0:number_segments-1
        aux = i*length_segment+1;
        segment = x(aux:aux+length_segment-1);
        energy = sum(segment.*segment)/length_segment;
        if energy > avarege_Energy*threshold
            y = [y, segment(1:end)];
            %disp("OK");
        end
    end

    % Aplicar filtro de enfasis
    y = Filtro(y);

    %peak = max(abs(y));
    %y = y/peak;
 
    %subplot(1,2,2)
    %plot(y)
end