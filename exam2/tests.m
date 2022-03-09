clc
close all
clear all
% CHODZENIE PO SIECI

x=[0.1 0.3]';
W1=[0.5 -1;
  1 -0.2;
  0.3 0.8];
W2=[-0.3 0.1 -0.1];

l1=W1*x;
% dlY = sigmoid(l1,'SSCB')


out1=[];
for k=1: size(l1)
    out1(k)=1/(1+exp(-l1(k)));
end

l2=W2*out1';

out2=[];
for k=1: size(l2)
    out2(k)=1/(1+exp(-l2(k)));
end

x3=out1(3);
x=1/(1+exp(-x3));
h=exp(-x)/(1+exp(-x))^2;
h*(1-0.4668)
