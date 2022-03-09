kx= [-1 0 1;
    -2 0 2;
    -1 0 1];

ky= [-1 -2 -1;
     0 0 0;
     1 2 1];
 
 input=[1 3 5 4;
        1 2 5 5;
        2 3 5 5;
        1 2 4 5;
        0 3 5 5];
    
   sobelX=[] ;
   sobelY=[];
   for i=1:size(input,1)-size(kx,1)+1
       for j=1:size(input,2)-size(ky,1)+1
         
           x=input(i:i+size(kx,1)-1,j:j+size(kx,2)-1).*kx;
           y=input(i:i+size(ky,1)-1,j:j+size(ky,2)-1).*ky;
           sobelX(i,j)= sum(sum(x));
           sobelY(i,j)= sum(sum(y));
       end
   end
    
 s=abs(sobelX)+abs(sobelY);
 psi=atan2(sobelY,sobelX)*180/pi;
 
