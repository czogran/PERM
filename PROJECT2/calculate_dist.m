% s: zarejestrowany sygna�
% fs: cz�stotliwo�� pr�bkowania
% fb: pasmo nadajnika

% dist: odleg�o�� do przeszkody w metrach 

function [dist] = calculate_dist(s, fs, fb)

sound_speed=343; %[m/s]
 

[y,f]=bandFilter(s,0.1,0.3, 1000);

end