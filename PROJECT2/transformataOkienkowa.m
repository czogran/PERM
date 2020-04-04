[sig, fs] = audioread('./records/dzienDobry.wav');
win_len = 512;
win_overlap =256;
nfft = 512;


spectrogram(sig(:,1), win_len, win_overlap, nfft, fs, 'MinThreshold', -100, 'yaxis')
