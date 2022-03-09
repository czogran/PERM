clc
close all
clear all

input = [0 1 1 4 3 ;
        2 2 1 5 4];
    
  h=  histogram(input);
  
  minimum=min(min(input));
  maximum=max(max(input));
  range=maximum-minimum+1;
  dim=size(input,1)*size(input,2);
  
  P1=[];
  P2=[];
  P1P2=[];
  m1=[];
  m2=[];
  m1_m2=[];
  psi=[];
  indeks=1;
 
  for k = 1:range-1
      P1(k)=sum(h.Values(1:k))/dim;
      P2(k)=1-P1(k);
      m1(k)=sum(h.Values(1:k).*[minimum:minimum+k-1])/sum(h.Values(1:k));
      m2(k)=sum(h.Values(k+1:range).*[minimum+k:maximum])/sum(h.Values(k+1:range));
      P1P2(k)=P1(k)*P2(k);
      m1_m2(k)=(m1(k)-m2(k))^2;
      psi(k)=P1P2(k)*m1_m2(k);
  end