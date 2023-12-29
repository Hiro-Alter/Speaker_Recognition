clc; clearvars; close all;

% Especifica la ruta del archivo de audio
archivo_audio = 'locutores\audios/hola.wav';
archivo_audio2 = 'locutores\audios/puerta.wav';

% Especifica la frecuencia de muestreo deseada
fs = 16000;  % Cambia esto según tu frecuencia de muestreo deseada

% Lee el archivo de audio
[x_aud, fs_original] = audioread(archivo_audio);

% Resample a la frecuencia de muestreo deseada
x(1,:) = resample(x_aud(:,1), fs, fs_original);

[x_aud, fs_original] = audioread(archivo_audio2);
x2(1,:) = resample(x_aud(:,1), fs, fs_original);


y = Eliminar_Silencio(x,fs);
y = Segmentar(y, fs);
y = MFCC(y,40,fs,1024,13);

y2 = Eliminar_Silencio(x2,fs);
y2 = Segmentar(y2, fs);
y2 = MFCC(y2,40,fs,1024,13);

%M=simmx(y,y);
distancia_Matrices = dtw(y,y2);

figure
subplot(1,2,1)
imagesc(y)
subplot(1,2,2)
imagesc(y2)

M = DTW_Lib(y,y2);
M2 = calculateDTW(y,y2);

figure
imagesc(M);
colorbar;
title('Matriz de Similitud');
xlabel('Columnas de B');
ylabel('Columnas de A');
