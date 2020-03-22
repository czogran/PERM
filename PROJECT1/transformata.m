
function [A,F] = transformata(x)
L=length(x);     % d³ugoœæ sygna³u
Y = fft(x);     % transformata Fouriera

A = abs(Y);     % amplituda sygna³u
A = A/L;        % normalizacja amplitudy

A = A(1:L/2+1); % wyciêcie istotnej czêœci spektrum
A(2:end-1) = 2*A(2:end-1);

F = angle(Y);   % faza sygna³u
F = F(1:L/2+1); % wyciêcie istotnej czêœci spektrum

end

