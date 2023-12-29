clear all;
% Parámetros
sample_rate = 16000;
NFFT = 1024;
nfilt = 5;
low_freq_mel = 0;
high_freq_mel = 2595 * log10(1 + (sample_rate / 2) / 700);
mel_points = linspace(low_freq_mel, high_freq_mel, nfilt + 2);
hz_points = 700 * (10 .^ (mel_points / 2595) - 1);
bin = floor((NFFT + 1) * hz_points / sample_rate);

% Crear el banco de filtros mel
fbank = zeros(nfilt, floor(NFFT / 2 + 1));
for m = 2:nfilt+1
    f_m_minus = bin(m - 1);   % izquierda
    f_m = bin(m);             % centro
    f_m_plus = bin(m + 1);    % derecha

    for k = f_m_minus+1:f_m
        fbank(m-1, k) = (k - bin(m - 1)) / (bin(m) - bin(m - 1));
    end

    for k = f_m:f_m_plus
        fbank(m-1, k) = (bin(m + 1) - k) / (bin(m + 1) - bin(m));
    end
end

% Graficar el banco de filtros mel
% Graficar el banco de filtros mel en función de las frecuencias
figure;
hold on;
freq_axis = linspace(0, sample_rate/2, floor(NFFT/2)+1); % Eje de frecuencias

for i = 1:nfilt
    plot(freq_axis, fbank(i, :));
end

title('Banco de Filtros Mel');
xlabel('Frecuencia (Hz)');
ylabel('Peso del Filtro');
hold off;

% Asignar valores ficticios para las operaciones posteriores
pow_frames = randn(10, NFFT/2+1);
filter_banks = pow_frames * fbank(:, 1:NFFT/2+1)';  % Corregir la indexación

% Estabilidad numérica
filter_banks(filter_banks == 0) = eps;

% Conversión a dB
filter_banks = 20 * log10(filter_banks);
