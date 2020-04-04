function [y,f] = bandFilter(sig,fd,fu,M)

n=1:M;
sinc_sig_d=2*fd*sinc(2*fd*(n-M/2));

sinc_sig_u=2*fu*sinc(2*fu*(n-M/2));

w=0.42-0.5*cos(2*pi*n/(M))+0.08*cos(4*pi*n/(M-1));

fd=sinc_sig_d.*w;
fu=sinc_sig_u.*w;


Kd=sum(fd)
Ku=sum(fu)

fd=fd/Kd;

fu=-fu/Ku;
fu(find(fu==min(fu)))=fu(find(fu==min(fu)))+1;

f=-(fd+fu);
f(find(f==min(f)))=f(find(f==min(f)))+1;

y=conv(sig,f);
end

