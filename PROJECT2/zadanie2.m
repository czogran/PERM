% Filtry rekurencyjne IIR
clear all;
close all;

[sig, fs] = audioread('./records/dzienDobry.wav');

% czestotliwosci w HZ
f_cutoff_LP=500;
f_cutoff_HP=7500;
f_cutoff_BP1=1500;
f_cutoff_BP2=3500;

% czestotliwosci wyrazone jako ulamek fs
fc_LP=f_cutoff_LP/fs; %0.0113
fc_HP=f_cutoff_HP/fs; %0.1701
fc_BP1=f_cutoff_BP1/fs; %0.0340
fc_BP2=f_cutoff_BP2/fs; %0.0794


% FILTR LP
f_LP = [0 2*fc_LP 2*fc_LP+0.015 1]; % czestotliwosc, 0->0fs, 1->0.5fs
m_LP = [1 1 0 0 ]; % wzmocnienie
[b_LP,a_LP] = yulewalk(22,f_LP,m_LP); % filtr IIR rzedu 22
[h_LP,w_LP] = freqz(b_LP,a_LP); % odpowiedz czestotliwosciowa filtru


% FILTR BP1
f_BP1 = [0 2*fc_LP 2*fc_LP+0.02 2*fc_BP1 2*fc_BP1+0.02 1]; % czestotliwosc, 0->0fs, 1->0.5fs
m_BP1 = [0 0 1 1 0 0 ]; % wzmocnienie
[b_BP1,a_BP1] = yulewalk(19,f_BP1,m_BP1); % filtr IIR rzedu 19
[h_BP1,w_BP1] = freqz(b_BP1,a_BP1); % odpowiedz czestotliwosciowa filtru


% FILTR BP2
f_BP2 = [0 2*fc_BP1 2*fc_BP1+0.02 2*fc_BP2 2*fc_BP2+0.02 1]; % czestotliwosc, 0->0fs, 1->0.5fs
m_BP2 = [0 0 1 1 0 0 ]; % wzmocnienie
[b_BP2,a_BP2] = yulewalk(20,f_BP2,m_BP2); % filtr IIR rzedu 20
[h_BP2,w_BP2] = freqz(b_BP2,a_BP2); % odpowiedz czestotliwosciowa filtru


% FILTR BP3
f_BP3 = [0 2*fc_BP2 2*fc_BP2+0.02 2*fc_HP 2*fc_HP+0.02 1]; % czestotliwosc, 0->0fs, 1->0.5fs
m_BP3 = [0 0 1 1 0 0 ]; % wzmocnienie
[b_BP3,a_BP3] = yulewalk(17,f_BP3,m_BP3); % filtr IIR rzedu 17
[h_BP3,w_BP3] = freqz(b_BP3,a_BP3); % odpowiedz czestotliwosciowa filtru


% FILTR HP 
f_HP = [0 2*fc_HP-0.03 2*fc_HP+0.02 1]; % czestotliwosc, 0->0fs, 1->0.5fs
m_HP = [0 0 1 1 ]; % wzmocnienie
[b_HP,a_HP] = yulewalk(20,f_HP,m_HP); % filtr IIR rzedu 20
[h_HP,w_HP] = freqz(b_HP,a_HP); % odpowiedz czestotliwosciowa


yLP=filter(b_LP,a_LP,sig(:,1));
yBP1=filter(b_BP1,a_BP1,sig(:,1));
yBP2=filter(b_BP2,a_BP2,sig(:,1));
yBP3=filter(b_BP3,a_BP3,sig(:,1));
yHP=filter(b_HP,a_HP,sig(:,1));

% % FILTR LP - wykres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(w_LP/pi,(abs(h_LP))); % skala liniowa
% plot(w_LP/pi,mag2db(abs(h_LP))); % skala dB
% yl = ylim;
hold on;
plot(f_LP,m_LP,'--');
% plot(f(2:3),yl,'--');
xlabel('Radian frequency (\omega/\pi)');
ylabel('Magnitude');
title("Charakterystyka filtra LP");
legend("Filtr rzeczywisty","Filtr idealny");
grid on;


% % FILTR BP1 - wykres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(w_BP1/pi,(abs(h_BP1)));
% plot(w_BP1/pi,mag2db(abs(h_BP1))); % skala dB
hold on;
plot(f_BP1,m_BP1,'--');
xlabel('Radian frequency (\omega/\pi)');
ylabel('Magnitude');
title("Charakterystyka filtra BP1");
legend("Filtr rzeczywisty","Filtr idealny");
grid on;


% FILTR BP2 - wykres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(w_BP2/pi,(abs(h_BP2)));
% plot(w_BP2/pi,mag2db(abs(h_BP2))); % skala dB
hold on;
plot(f_BP2,m_BP2,'--');
xlabel('Radian frequency (\omega/\pi)');
ylabel('Magnitude');
title("Charakterystyka filtra BP2");
legend("Filtr rzeczywisty","Filtr idealny");
grid on;


% FILTR BP3 - wykres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(w_BP3/pi,(abs(h_BP3)));
% plot(w_BP3/pi,mag2db(abs(h_BP3))); % skala dB
hold on;
plot(f_BP3,m_BP3,'--');
xlabel('Radian frequency (\omega/\pi)');
ylabel('Magnitude');
title("Charakterystyka filtra BP3");
legend("Filtr rzeczywisty","Filtr idealny");
grid on;


% FILTR HP - wykres %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(w_HP/pi,(abs(h_HP)));
% plot(w_HP/pi,mag2db(abs(h_HP))); % skala dB
hold on;
plot(f_HP,m_HP,'--');
xlabel('Radian frequency (\omega/\pi)');
ylabel('Magnitude');
title("Charakterystyka filtra HP");
legend("Filtr rzeczywisty","Filtr idealny");
grid on;



win_len = 512;
win_overlap =256;
nfft = 512;

figure;
spectrogram(yLP, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany rekurencyjnym filtrem LP, fc=%dHz',f_cutoff_LP);
title(t);
saveas(gcf,'.\rysunki\zad2_spect_LP.png');

figure;
spectrogram(yBP1, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany rekurencyjnym filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_LP,f_cutoff_BP1);
title(t);
saveas(gcf,'.\rysunki\zad2_spect_BP1.png');


figure;
spectrogram(yBP2, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany rekurencyjnym filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_BP1,f_cutoff_BP2);
title(t);
saveas(gcf,'.\rysunki\zad2_spect_BP2.png');


figure;
spectrogram(yBP3, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany rekurencyjnym filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_BP2,f_cutoff_HP);
title(t);
saveas(gcf,'.\rysunki\zad2_spect_BP3.png');


figure;
spectrogram(yHP, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany rekurencyjnym filtrem HP, fc=%dHz',f_cutoff_HP);
title(t);
saveas(gcf,'.\rysunki\zad2_spect_HP.png');

