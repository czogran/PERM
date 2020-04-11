clear all
s = textread('signal.txt','%f');
fs = 200e3;
fb = 40e3;
 
dist=calculate_dist(s,fs,fb)


% predkosc dzwieku
sound_speed=343; %[m/s]

% FILTRACJA SYGNA£U
BW=800; % w Hz
BW=BW/fs; % jako ulamek fs

f_cutoff1=fb-0.1*fb;
f_cutoff2=fb+0.1*fb;
fc1=f_cutoff1/fs;
fc2=f_cutoff2/fs;

[y,f]=bandPassFilter(s,fc1,fc2, BW); % wykorzystanie filtra BP

% OBROBKA ODFILTOWANEGO SYGNALU
% 
y=abs(y);

% wyciecie wszystkich sygna³ow, których wartosc jest mniejsza od polowy
% najbardziej znaczacego sygnalu, ma to na 

get_signal_mean=mean(maxk(y,30))/2;
for i=1:length(y)
    if(y(i)<get_signal_mean)
        y(i)=0;
    end
end


rect=ones(3200,1);

max_signal=conv(y,rect);

max_signal_range=find(max_signal==max(max_signal));

if length(max_signal_range)>1
    index= floor((1+length(max_signal_range))/2);
    max_signal_index=max_signal_range(index);
else
    max_signal_index=max_signal_range;
end

if(max_signal_index<3050)
    max_signal_index=3051;
end

k=max_signal_index-3050+min(find(y(max_signal_index-3050:max_signal_index-2950)));

t=(k-1)/fs*1000; % zamiana nr probki na czas w [ms]
dist=sound_speed*t/1000/2; % obliczenie odleglosci do przeszkody w [m]

figure
plot(s,'Color',uint8([200 200 200]))
hold on
plot(y,'b')
hold on
plot(max_signal/200,'r')
hold off
axis([0 length(s) -2 2])
xlabel('k')
title("korelacja odfiltrowanego sygna³u czujnika"+newline+...
"z sygna³em prostok¹tnym")
legend('sygna³ zaszumiony','sygna³ odfiltrowany','korelacja (przeskalowana)','Location', 'best');
 
 saveas(gcf,'.\rysunki\zad3_korelacja.png');
