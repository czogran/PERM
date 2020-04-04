function [y,f] = lowBandFilter(sig,fc,M)

n=1:M;

sinc_sig=2*fc*sinc(2*fc*(n-M/2));

w=0.42-0.5*cos(2*pi*n/(M))+0.08*cos(4*pi*n/(M-1));

f=(sinc_sig.*w);
K=sum(f);
f=f/K;

y=conv(sig,f);
end

