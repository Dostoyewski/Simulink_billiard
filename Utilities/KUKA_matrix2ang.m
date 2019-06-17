function [a,b,c] = KUKA_matrix2ang(M)
% ïðåîáðàçîâàíèå ìàòðèöû ïîâîðîòà â óãëû 
sy = sqrt(M(1,1) * M(1,1) +  M(2,1) * M(2,1));

if  sy > 1e-6 % not singular
    c = atan2(M(3,2) , M(3,3));
    b = atan2(-M(3,1), sy);
    a = atan2(M(2,1), M(1,1));
else
    c = atan2(-M(2,1), M(2,2));
    b = atan2(-M(3,1), sy);
    a = 0;
end
a=a*180/pi;
b=b*180/pi;
c=c*180/pi;


