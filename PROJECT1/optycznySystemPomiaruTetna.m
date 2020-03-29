

% lista obrazów do analizy
% imds = imageDatastore('img/img1', 'FileExtension', '.jpg');

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

% c=br(100:250)
% br=[c c c c c c c c];
dlugosc_filmiku=10;

probki=length(br);
czestotliwosc_probkowania=probki/dlugosc_filmiku;


% tetno przy u¿yciu przejœæ przez 0
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
