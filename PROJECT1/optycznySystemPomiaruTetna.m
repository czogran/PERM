

% lista obraz�w do analizy
% imds = imageDatastore('img/imgSample', 'FileExtension', '.jpg');

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
    br(i) = mean(I, 'all');
end

% dla u�atwienia p�niejszej analizy od razu mo�na odj�� od sygna�u sk�adow� sta��
br = br - mean(br);

plot(br)

% tetno przy u�yciu przej�� przez 0
n=length(br);
dlugosc_filmiku=10;
zero=0;
for i=1:n-1;
    if(sign(br(i))~=sign(br(i+1)))
        zero=zero+1;
    end
end
% tetno na minute
tetno_zero=zero/dlugosc_filmiku*60;

% metoda fft
[A,F] = transformata(br);
tetno_fft=find(A==max(A))

% autokorelaja
tetno_auto=max(xcorr(br));

