% https://tomroelandts.com/articles/how-to-create-a-simple-low-pass-filter
% https://www.analog.com/media/en/technical-documentation/dsp-book/dsp_book_Ch16.pdf
clear all;

[sig, fs] = audioread('./records/dzienDobry.wav');

BW=176.4; % szerokosc pasma przejsciowego w Hz
BW=BW/fs;

% czestotliwosci w HZ
f_cutoff_LP=500;
f_cutoff_HP=7500;
f_cutoff_BP1=1500;
f_cutoff_BP2=3500;

% czestotliwosci wyrazone jako ulamek fs
fc_LP=f_cutoff_LP/fs;
fc_HP=f_cutoff_HP/fs;
fc_BP1=f_cutoff_BP1/fs;
fc_BP2=f_cutoff_BP2/fs;

[yLP,fLP]=lowPassFilter(sig(:,1),fc_LP, BW);
[yHP,fHP]=highPassFilter(sig(:,1),fc_HP, BW);

[yBP1,fBP1]=bandPassFilter(sig(:,1),fc_LP,fc_BP1, BW);
[yBP2,fBP2]=bandPassFilter(sig(:,1),fc_BP1,fc_BP2, BW);
[yBP3,fBP3]=bandPassFilter(sig(:,1),fc_BP2,fc_HP, BW);

win_len = 512;
win_overlap =256;
nfft = 512;

figure;
spectrogram(yLP, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany filtrem LP, fc=%dHz',f_cutoff_LP);
title(t);

figure;
spectrogram(yBP1, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_LP,f_cutoff_BP1);
title(t);

figure;
spectrogram(yBP2, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_BP1,f_cutoff_BP2);
title(t);

figure;
spectrogram(yBP3, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany filtrem BP, fc1=%dHz, fc2=%dHz',f_cutoff_BP2,f_cutoff_HP);
title(t);

figure;
spectrogram(yHP, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis');
t=sprintf('Sygna³ przefiltrowany filtrem HP, fc=%dHz',f_cutoff_HP);
title(t);


% figure;
% plot(fLP);
% title("Odp.imp. filtru LP");
% figure;
% plot(fHP);
% title("Odp.imp. filtru HP");
% figure;
% plot(fBP1);
% title("Odp.imp. filtru BP1");
% figure;
% plot(fBP2);
% title("Odp.imp. filtru BP2");
% figure;
% plot(fBP3);
% title("Odp.imp. filtru BP3");


% widmo=fft(fLP);
% widmo=widmo(1:floor(length(widmo)/2)+1); % wyciecie polowy probek
% plot(0:0.5/(length(widmo)-1):0.5,abs(widmo));
% title("Charakterystyka czêstotliwoœciowa filtru");
% xlabel('Czêstotliwoœæ (u³amek fs)');
% ylabel('Amplituda');
