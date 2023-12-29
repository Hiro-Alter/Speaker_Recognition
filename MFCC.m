function [matriz_MFCC] = MFCC(matriz_Audio, n, fs, nfft, ncoef)
    % FFT
    [~, M] = size(matriz_Audio);
    matriz_FFT = [];
    for i=1:M
        x = fft(matriz_Audio(:,i), nfft);
        x = x(1:length(x)/2+1);
        x = abs(x);
        matriz_FFT(:,i) = x;
    end

    %figure
    %f = linspace(0, fs/2, length(matriz_FFT(:,1).'));
    %stem(f, (matriz_FFT(:,2).').^2/(nfft/2));

    % Obtencion de los filtros MEL
    filtros = Banco_de_Filtros_MEL(n, fs, nfft);
    
    % Energia
    matriz_P = matriz_FFT.^2/(nfft/2);            %    No confirmado

    % Energia aportada por cada filtro MEL
    aux = zeros(size(filtros,2), 1);
    matriz_MFCC_Aux = [];
    for i=1:size(matriz_P,2)
        for n=1:size(filtros,2)
            energy_Filter = 0;
            for m=1:size(filtros,1)
                energy_Filter = energy_Filter + matriz_P(m,i).*filtros(m,n);
            end   
            aux(n,1) = log10(energy_Filter);         % Escala logaritmica
        end
        matriz_MFCC_Aux(:,i) = dct(aux);                % Transformada del coseno
    end
    matriz_MFCC = matriz_MFCC_Aux(2:ncoef,1:end);
    
    % Levantamiento sinusoidal
    [~, ncoeff] = size(matriz_MFCC);
    cep_lifter = 22;
    n = (0:ncoeff-1)';
    lift = 1 + (cep_lifter / 2) * sin(pi * n / cep_lifter);
    
    % Aplicar el levantamiento a los coeficientes de MFCC
    mfcc_lifted = matriz_MFCC .* lift.';
    mfcc_lifted2 = mfcc_lifted;
    
    % Normalizar MFCC
    media = mean(mfcc_lifted2);
    varianza = var(mfcc_lifted2);
    mfcc_lifted2 = (mfcc_lifted2 - media) ./ sqrt(varianza);
    matriz_MFCC = mfcc_lifted2;
    
    % Visualizar resultados
    %figure;
    %subplot(3, 1, 1);
    %imagesc(matriz_MFCC);
    %colorbar;
    %title('MFCC Originales');
    
    %subplot(3, 1, 2);
    %imagesc(mfcc_lifted);
    %colorbar;
    %title('MFCC con Levantamiento Sinusoidal');

    %subplot(3, 1, 3);
    %imagesc(mfcc_lifted2);
    %colorbar;
    %title('MFCC con Levantamiento Sinusoidal Normalizado');
end