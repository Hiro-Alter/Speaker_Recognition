clearvars; close all;
% Especifica la ruta del archivo de audio
%archivo_audio = 'prueba2.wav';

% Especifica la frecuencia de muestreo deseada
fs = 8000;  % Cambia esto según tu frecuencia de muestreo deseada
nfft = 512;    % Numero de puntos de la fft (512 parte positiva)
nfilters = 40;  % Cantidad de filtros MEL
ncoef = 13;     % Numero de coeficientes caracteristicos

% Lee el archivo de audio
%[x_aud, fs_original] = audioread(archivo_audio);

% Resample a la frecuencia de muestreo deseada
%x(1,:) = resample(x_aud(:,1), fs, fs_original);

clear x;

x(1,:) = grabar();


y = Eliminar_Silencio(x,fs);
y = Segmentar(y, fs);
y = MFCC(y,nfilters,fs,nfft,ncoef);


%Crear_Base_Datos_MFCC(fs, nfft, nfilters, ncoef);

% Prueba
matriz_Distancias = Comparar(y);
disp(matriz_Distancias);
Decidir(matriz_Distancias, 60);
imagesc(y)
colormap("gray")

function x = grabar()
   dlg_title = 'Record audio';
    prompt = { 'Recording time (s)','Bits/samples', 'Sampling Frequency (Hz)','Number of channels (1,2)'};
    num_lines = 1;
    defaultans = {'3', '16','8000', '1'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    if ~isempty(answer)
        tRec=str2num(answer{1});    % Tiempo de grabación en s
        nBit=str2num(answer{2});   % Número de bits por muestra
        Fs=str2num(answer{3});    % Frecuencia de muestreo  
        nChan=str2num(answer{4});   % Número de canales

        % Crear un objeto audiorecorder
        aud1 = audiorecorder(Fs,nBit,nChan);
        f = waitbar(0,'Recording');
        recordblocking(aud1, tRec); % Grabar  audio
        waitbar(1,f,'Recording');
        close(f);
        x = getaudiodata(aud1); % Obtener los datos de la señal x
    end
end