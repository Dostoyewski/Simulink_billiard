function Tt=kuka_forward(Q, TCP, show)
% 
% TCP - ìàòðèöà îäíîðîäíîãî ïðåîáðàçîâàíèÿ äëÿ èíñòðóìåíòà (îðèåíòàöèÿ è ïîëîæåíèå â ñèñòåìå êîîðäèíàò ôëàíöà)  
% Q - óãëû â îñÿõ, ãðàä
% show - ïîêàçàòü êèíåìàòè÷åñêóþ êîíôèãóðàöèþ ãðàôè÷åñêè 

%% Ïàðàìåòðû êèíåìàòè÷åñêîé ìîäåëè ðîáîòà
% KUKA KR10 R1100    
link1=400;
offset12=25;
link2=560;
offset23=35;
link34=515; 
link56=80; 

% % KUKA KR10 R900 
% link2=455;
% link34=420;

%% Âõîäíûå àðãóìåíòû 
if nargin<3
    show=false;
end
if nargin<2
    TCP=[];
end
if size(TCP,1)~=4 || size(TCP,2)~=4
    TCP =[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
end
if nargin==0
    Q=[0 0 0 0 0 0];
end

Q=Q/180*pi;  


%%

% ìàòðèöà ïåðåõîäà îò êîíå÷íîé òî÷êè ðîáîòà äî åãî ôëàíöà 
F =[0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
%F =[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];


T1=[Rz(-Q(1)) [0 0 0 1]'];
T2=T1*[Ry(Q(2)) [offset12 0 link1 1]'];
T3=T2*[Ry(Q(3)) [link2 0 0 1]'];
T4=T3*[Rx(-Q(4)) [0 0 offset23 1]'];
T5=T4*[Ry(Q(5)) [link34 0 0 1]'];
T6=T5*[Rx(-Q(6)) [link56 0 0 1]'];
Tf=T6*F;
Tt=Tf*TCP;



if show
    figure(11012019);
    set(11012019,'NumberTitle','off','Name', 'Êèíåìàòè÷åñêàÿ êîíôèãóðàöèÿ')
    clf
    x=[T1(1,4) T2(1,4) T3(1,4) T4(1,4) T5(1,4) T6(1,4) Tf(1,4)];
    y=[T1(2,4) T2(2,4) T3(2,4) T4(2,4) T5(2,4) T6(2,4) Tf(2,4)];
    z=[T1(3,4) T2(3,4) T3(3,4) T4(3,4) T5(3,4) T6(3,4) Tf(3,4)];
    plot3(x,y,z,'.-')
    dcmshow(T1,[],40,1,false)
    dcmshow(T2,[],40,1,false)
    dcmshow(T3,[],40,1,false)
    dcmshow(T4,[],40,1,false)
    dcmshow(T5,[],40,1,false)
    dcmshow(T6,[],40,1,false)
    dcmshow(Tf,[],50,2,false)
    dcmshow(Tt,[],50,2,true)
end


function R=Rx(q)
R=[1,      0,       0;
   0, cos(q), -sin(q);
   0, sin(q),  cos(q);
   0,      0,      0];
end


function R=Ry(q)
R=[cos(q)  0, sin(q);
     0     1,      0;
  -sin(q), 0, cos(q);
        0, 0,     0];
end


function R=Rz(q)
R=[cos(q), -sin(q), 0;
   sin(q),  cos(q), 0;
        0,       0, 1;
        0,       0, 0];
end

end