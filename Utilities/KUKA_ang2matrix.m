function [M] = KUKA_ang2matrix(a,b,c)
% ïðåîáðàçîâàíèå óãëîâ â ìàòðèöó ïîâîðîòà
A=a*pi/180;
B=b*pi/180;
C=c*pi/180;

Rx=[ 1, 0, 0;
     0, cos(C), -sin(C);
     0, sin(C), cos(C)];

Ry=[cos(B), 0, sin(B);
       0, 1, 0;
     -sin(B), 0, cos(B)];

Rz=[cos(A), -sin(A), 0;
      sin(A), cos(A), 0;
         0, 0, 1];

M=Rz*Ry*Rx;

