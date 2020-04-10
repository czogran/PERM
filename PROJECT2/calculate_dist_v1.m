% s: zarejestrowany sygna³
% fs: czêstotliwoœæ próbkowania
% fb: pasmo nadajnika

% dist: odleg³oœæ do przeszkody w metrach 

function [dist] = calculate_dist(s, fs, fb)

sound_speed=343; %[m/s]
 

[y,f]=bandFilter(s,0.1,0.3, 1000);

end