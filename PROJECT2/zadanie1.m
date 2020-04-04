clear all
[sig, fs] = audioread('./records/dzienDobry.wav');

f_cutoff_d=100;
f_cutoff_u=100;
f_cutoff_d_p=100;
f_cutoff_u_p=100;

fc_d=f_cutoff_d/fs;
fc_u=f_cutoff_u/fs;
fc_d_p=f_cutoff_d_p/fs;
fc_u_p=f_cutoff_u_p/fs;

M=1000;

t=0:0.001:1
B = 1:10000 % Czêstotliwoœci kolejnych sygna³ów [Hz]
x = zeros(size(t));
for i = 1:length(t)
  x = x + cos(2 * pi * B(i) * t);
end
[yt,ft]=(bandFilter(x,0.3,0.1, M));
figure
plot(abs(fft(yt)))
hold off


[yd,fd]=(lowBandFilter(sig(:,1),fc_d, M));
[yu,fu]=(highBandFilter(sig(:,1),fc_u, M));


[yp,fp]=bandFilter(sig(:,1),fc_d_p,fc_u_p, M);


win_len = 512;
win_overlap =256;
nfft = 512;

figure
plot(fd,'g')
hold on
plot(fu,'r')
hold on
plot(fp,'g')
hold off
% figure
% spectrogram(y, win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis')
% sound(sig(:,1))
% sound(y)
sound(yp,fs);
