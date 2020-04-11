% s: zarejestrowany sygna³
% fs: czêstotliwoœæ próbkowania
% fb: pasmo nadajnika

% dist: odleg³oœæ do przeszkody w metrach 

function [dist] = calculate_dist(s, fs, fb)

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
% wziecie wartosci bezwglednej sygnalu, by mozna latwiej bylo uzyc splotu
y=abs(y);



% wyciecie wszystkich sygna³ow, których wartosc jest mniejsza od polowy
% œredniej z 30 najbardziej znaczacych probek sygnalu, ma to wade gdy
% sygnal jest bardzo dlugi, ale w przypadku syganlu srednije dlugosci
% syganlow sygnal zostanie, a szumy ponizej wartosci syganlu zostana
% usuniete

get_signal_mean=mean(maxk(y,30))/2;

for i=1:length(y)
    if(y(i)<get_signal_mean)
        y(i)=0;
    end
end



% splot z sygnalem prostokatym o dlugosci rownej sygnalowi wyslanemu z
% czujnika
rect=ones(3200,1);

max_signal=conv(y,rect);

% znalezienie najwiekszej wartosci w otrzymanym splocie, jezeli jest to
% przedzial to wziecie srodkowej wartosci
max_signal_range=find(max_signal==max(max_signal));

if length(max_signal_range)>1
    index= floor((1+length(max_signal_range))/2);
    max_signal_index=max_signal_range(index);
else
    max_signal_index=max_signal_range;
end


% znalezienie pierwszej niezerowej wartosci syganlu, sprawdzenie inedksow
% na przypadek wyjscia poza zakres tablicy
if(max_signal_index<3050)
    max_signal_index=3051;
end

k=max_signal_index-3050+min(find(y(max_signal_index-3050:max_signal_index-2950)));

t=(k-1)/fs*1000; % zamiana nr probki na czas w [ms]
dist=sound_speed*t/1000/2; % obliczenie odleglosci do przeszkody w [m]

end