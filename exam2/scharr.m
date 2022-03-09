gx= [-3 0 3;
    -10 0 10;
    -3 0 3];

gy= [-3 -10 -3;
     0 0 0;
     3 10 3];
 
  input=[1 3 5 4;
        1 2 5 5;
        2 3 5 5;
        1 2 4 5;
        0 3 5 5];
    
   scharrX=[] ;
   scharY=[];
   for i=1:size(input,1)-size(gx,1)+1
       for j=1:size(input,2)-size(gy,1)+1
         
           x=input(i:i+size(gx,1)-1,j:j+size(gx,2)-1).*gx;
           y=input(i:i+size(gy,1)-1,j:j+size(gy,2)-1).*gy;
           scharX(i,j)= sum(sum(x));
           scharY(i,j)= sum(sum(y));
       end
   end
   
   