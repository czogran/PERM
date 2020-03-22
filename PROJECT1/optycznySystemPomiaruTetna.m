

% lista obrazów do analizy
% imds = imageDatastore('img/imgSample', 'FileExtension', '.jpg');

% Liczba ramek do wczytania (przy 10 sekundach i 30 FPS bêdzie to 300)
N = 300;

% wektor jasnoœci
br = zeros(1, N);

% alternatywnie mo¿na za³adowaæ bezpoœrednio plik wideo
v = VideoReader('video\sampleVideo.mp4');


% wczytanie pierwszych N obrazów i analiza jasnoœci
for i=1:N
    % wczytujemy obraz i przekszta³camy go do skali szaroœci
%     I = rgb2gray(imread(imds.Files{i}));
    % dla pliku wideo ³adowanie ramki z otwartego Ÿród³a
    I = rgb2gray(read(v,i));

    % wyznaczamy œredni¹ z ca³ego obrazu
    br(i) = mean(I, 'all');
end

% dla u³atwienia póŸniejszej analizy od razu mo¿na odj¹æ od sygna³u sk³adow¹ sta³¹
br = br - mean(br);

plot(br)

% tetno przy u¿yciu przejœæ przez 0
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

