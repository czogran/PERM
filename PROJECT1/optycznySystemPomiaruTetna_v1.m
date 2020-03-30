
clear all;
% lista obraz�w do analizy
% imds = imageDatastore('img/img1', 'FileExtension', '.jpg');

% Liczba ramek do wczytania (przy 10 sekundach i 30 FPS b�dzie to 300)
N = 300;

% wektor jasno�ci
br = zeros(1, N);

% alternatywnie mo�na za�adowa� bezpo�rednio plik wideo
v = VideoReader('video\sampleVideo.mp4');


% wczytanie pierwszych N obraz�w i analiza jasno�ci
for i=1:N
    % wczytujemy obraz i przekszta�camy go do skali szaro�ci
%     I = rgb2gray(imread(imds.Files{i}));
    % dla pliku wideo �adowanie ramki z otwartego �r�d�a
    I = rgb2gray(read(v,i));

    % wyznaczamy �redni� z ca�ego obrazu
    br(i) = mean(mean(I));
end

% dla u�atwienia p�niejszej analizy od razu mo�na odj�� od sygna�u sk�adow� sta��
br = br - mean(br);

figure;
plot(br);
hold on;
plot(zeros(1,N),'--');
title("Wykres jasno�ci i przej�cia przez zero");
hold off;


dlugosc_filmiku=10; % w sekundach
Fs=N/dlugosc_filmiku; % czestotliwosc probkowania


% tetno przy u�yciu przej�� przez 0
zero=0; %liczba przejsc przez zero
for i=1:N-1
    if(sign(br(i))~=sign(br(i+1))) %wykrycie zmiany znaku sygnalu
        zero=zero+1;
    end
end
zero=zero/2; % na 1 uderzenie serca przypadaja 2 przejscia przez zero
tetno_zero=zero/dlugosc_filmiku*60; % tetno na minute


% autokorelaja
auto_kor=xcorr(br);
auto_kor=auto_kor(length(auto_kor)/2+1:length(auto_kor));
maks=0;
auto_value=0;
for k=2:1:length(auto_kor)-1
    if(auto_kor(k-1)<auto_kor(k) && auto_kor(k)<auto_kor(k+1))
        if(auto_kor(k)>auto_value)
             maks=k;
            auto_value=auto_kor(k);
        end
    end
end
tetno_auto=Fs/maks*60;

figure;
plot(auto_kor);
title("Autokorelacja sygna�u jasno�ci");


% metoda fft
A=abs(fft(br)); % wyznaczenie amplitudy
A=A/N; % normalizacja amplitudy
A=A(1:length(A)/2+1); % wyciecie istotnej czesci widma
A(2:end-1) = 2*A(2:end-1);
[max, index]=max(A); % znalezienie czestotliwosci dominujacej

f_step=Fs/N; % zmiana czestotliwosci w 1 kroku
tetno_fft=(index-1)*f_step*60; % tetno na minute (trzeba przesunac indeks o 1, bo f_step liczy sie od 0 a nie od 1)

figure;
plot(0:f_step:Fs/2,A)
title("Wykres amplitudowy sygna�u jasno�ci");
xlabel('f[Hz]');
ylabel('amplituda');
