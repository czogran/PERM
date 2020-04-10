% s: zarejestrowany sygna³
% fs: czêstotliwoœæ próbkowania
% fb: pasmo nadajnika

% dist: odleg³oœæ do przeszkody w metrach 

function [dist] = calculate_dist_v1(s, fs, fb)

sound_speed=343; %[m/s]

BW=800; % w Hz
BW=BW/fs; % jako ulamek fs

f_cutoff1=fb(1);
f_cutoff2=fb(2);
fc1=f_cutoff1/fs;
fc2=f_cutoff2/fs;

[y,f]=bandPassFilter_v1(s,fc1,fc2, BW); % wykorzystanie filtra BP

for i=1:length(y) % znalezienie probki, w ktorej zaczal sie pojawiac odbity impuls
    if abs(y(i))>0.1
        k=i;
        break;
    end    
end

t=(k-1)/fs*1000; % zamiana nr probki na czas w [ms]
dist=sound_speed*t/1000/2; % obliczenie odleglosci do przeszkody w [m]

% echo wrocilo do odbiornika po czasie 62,98 ms
% odleglosc do przeszkody wynosi 10.8 m

end