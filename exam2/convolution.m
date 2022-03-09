% MACIERZE KROKI SIECI NERURONOWEJ
a = [0 0 0 0 0 0 0 0 0;
    0 1 5 5 0 3 1 1 0;
    0 2 0 0 0 2 2 1 0;
    0 1 2 2 2 1 2 1 0;
    0 0 0 0 0 0 1 0 0;
    0 1 1 2 3 2 3 4 0;
    0 3 4 4 1 1 0 0 0;
    0 0 0 1 0 3 1 0 0;
    0 0 0 0 0 0 0 0 0;];

f2= [ 1 0 0;
     -2 0 0;
     0 0 1];
 step=2;
 layer=[];
 matr=[]
 for i=1:step:size(a,1)-step
     for j=1:step:size(a,1)-step
       layer=[layer sum(sum(a(i:i+step,j:j+step).*f2))];
 
     end
     matr=[matr; layer];
     layer=[];
 end
 
