clear all;

s = textread('signal.txt','%f'); % odebrany sygnal
fs = 200e3; % czestotliwosc probkowania
fb = [35000 45000]; % pasmo do odfiltrowania

dist=calculate_dist_v1(s, fs, fb); % obliczenie odleglosci
% echo wrocilo do odbiornika po czasie 62,98 ms
% odleglosc do przeszkody wynosi 10.8 m

% Sporzadzenie wykresow
f_cutoff1=fb(1);
f_cutoff2=fb(2);
fc1=f_cutoff1/fs;
fc2=f_cutoff2/fs;
BW=800; % w Hz
BW=BW/fs; % jako ulamek fs

[y,f]=bandPassFilter_v1(s,fc1,fc2, BW); % filtracja BP

figure;
plot(0:1/fs*1000:(length(s)-1)/fs*1000,s);
xlabel("czas [ms]");
ylabel("amplituda");
title("Sygna³ zarejestrowany i sygna³ przefiltrowany");
hold on;
plot(0:1/fs*1000:(length(y)-1)/fs*1000,y);
legend("Sygna³ zarejestrowany","Sygna³ przefiltrowany filtrem BP");
grid on;
hold off;

figure;
win_len = 512;
win_overlap =256;
nfft = 512;
spectrogram(y, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
tit=sprintf('Sygna³ przefiltrowany filtrem BP, fc1=%dHz, fc2=%dHz',fb(1),fb(2));
title(tit);