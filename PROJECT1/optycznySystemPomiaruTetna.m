

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
    br(i) = mean(I, 'all');
end

% dla u�atwienia p�niejszej analizy od razu mo�na odj�� od sygna�u sk�adow� sta��
br = br - mean(br);

% c=br(100:250)
% br=[c c c c c c c c];
dlugosc_filmiku=10;

probki=length(br);
czestotliwosc_probkowania=probki/dlugosc_filmiku;


% tetno przy u�yciu przej�� przez 0
n=length(br);
zero=0;
for i=1:n-1;
    if(sign(br(i))~=sign(br(i+1)))
        zero=zero+1;
    end
end
% tetno na minute
tetno_zero=zero/dlugosc_filmiku*60/2;

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
tetno_auto=60*czestotliwosc_probkowania/maks;


% metoda fft
transformata=abs(fft(br));
transformata=transformata(1:length(transformata)/2+1);
[M czestotliwosc_fft]=max(transformata);

f_step=czestotliwosc_probkowania/probki;
tetno_fft=czestotliwosc_fft*f_step*60;
