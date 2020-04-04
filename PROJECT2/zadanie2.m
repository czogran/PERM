%--------- -------------------TEST SIGNAL---------------------------------% 
t=0:0.001:1
B = 1:10000 % Czêstotliwoœci kolejnych sygna³ów [Hz]
x = zeros(size(t));
for i = 1:length(t)
  x = x + cos(2 * pi * B(i) * t);
end

f = [0 0.3 0.4 1];
m = [1 1 0 0 ];

[b,a] = yulewalk(8,f,m);
[h,w] = freqz(b,a,128);

plot(w/pi,mag2db(abs(h)))
yl = ylim;
hold on
plot(f(2:3),yl,'--')
xlabel('\omega/\pi')
ylabel('Magnitude')
grid