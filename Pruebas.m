clearvars; close all;

% Especifica la ruta del archivo de audio
archivo_audio = 'prueba2.wav';
archivo_audio2 = 'locutores\audios/locutor_A2.wav';

% Especifica la frecuencia de muestreo deseada
fs = 8000;  % Cambia esto según tu frecuencia de muestreo deseada
nfft = 512;    % Numero de puntos de la fft (512 parte positiva)
nfilters = 40;  % Cantidad de filtros MEL
ncoef = 13;     % Numero de coeficientes caracteristicos

% Lee el archivo de audio
[x_aud, fs_original] = audioread(archivo_audio);

% Resample a la frecuencia de muestreo deseada
x(1,:) = resample(x_aud(:,1), fs, fs_original);

[x_aud, fs_original] = audioread(archivo_audio2);
x2(1,:) = resample(x_aud(:,1), fs, fs_original);

y = Eliminar_Silencio(x,fs);
y = Segmentar(y, fs);
y = MFCC(y,nfilters,fs,nfft,ncoef);


%Crear_Base_Datos_MFCC(fs, nfft, nfilters, ncoef);

% Prueba
matriz_Distancias = Comparar(y);
disp(matriz_Distancias);
Decidir(matriz_Distancias, 60);