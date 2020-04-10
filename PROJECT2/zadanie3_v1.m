clear all
s = textread('signal.txt','%f');
fs = 200e3;
fb = 40e3;

sound_speed=343; %[m/s]
 

[y,f]=bandFilter(s,0.15,0.25, 1000);

y=abs(y);

get_signal_mean=max(y)/2;

for i=1:length(y)
    if(y(i)<get_signal_mean)
        y(i)=0;
    end
end






figure
plot(s);
hold on
% plot(y,'r')
hold on
plot(y)
hold off