function dcmshow(R, P, Length, Linewidth, Arrowhead)
% Ôóíêöèÿ äëÿ âèçóàëèçàöèè ìàòðèöû íàïðàâëÿþùèõ êîñèíóñîâ (ìàòðèöû ïîâîðîòà)
% Ïîâîðîò òîæäåñòâåíåí ïåðåõîäó â êîîðäèíàòíóþ ñèñòåìó ñ îñÿìè, çàäàííûìè ñòîëáöàìè ìàòðèöû ïîâîðîòà
% Öâåòà îñåé: XYZ == RGB
%
% R - ìàòðèöà ïîâîðîòà 3õ3 (èëè ìàòðèöà ïåðåõîäà 4x4)
% P - ïîëîæåíèå íà÷àëà êîîðäèíàò
% Length - äëèíà îñåé êîîðäèíàòíîé ñèñòåìû  
% Linewidth - òîëùèíà ëèíèé
% Arrowhead - ñòðåëêà (true/false)
% 
% Ïàðàìåòðû ìîãóò áûòü çàäàíû ÷àñòè÷íî 
% Åñëè R çàäàíî ìàòðèöåé ïåðåõîäà (ìàòðèöåé îäíîðîäíîãî ïðåîáðàçîâàíèÿ 4x4), òî ïîëîæåíèåì P áåðåòñÿ ÷åòâåðòûé ñòîëþåö R   


hold all
switch nargin
    case 4
        Arrowhead=true;
    case 3
        Linewidth=1;
        Arrowhead=true;
    case 2
        Length=1;
        Linewidth=1;
        Arrowhead=true;
    case 1       
        P=[0 0 0];
        Length=1;
        Linewidth=1;
        Arrowhead=true;
    case 0
        R=eye(3);
        P=[0 0 0];
        Length=1;
        Linewidth=1;
        Arrowhead=true;
end
if size(R,2)==4
    P=R(1:3,4);
    R=R(1:3,1:3);
end
if length(P)~=3
    P=[0 0 0];
end
if size(R,1)~=3 || size(R,2)~=3
    R=eye(3);
end


col=[1 0 0; 0 0.5 0; 0 0 1];
for i=1:3
    plot3(P(1)+[0 R(1,i)]*Length, P(2)+[0 R(2,i)]*Length, P(3)+[0 R(3,i)]*Length,'Color',col(i,:),'LineWidth',Linewidth)
end

if Arrowhead
    n=17;
    t=linspace(0,2*pi,n);
    s=[1 0.9*ones(1,n); 0 sin(t)*0.02; 0 cos(t)*0.02];
    p={[1 2],[1 4],[1 6],[1 8],[1 10],[1 12],[1 14],[1 16],2:n+1};
    for i=1:3
        v=R*s;
        for j=1:length(p)
            plot3(P(1)+v(1,p{j})*Length, P(2)+v(2,p{j})*Length, P(3)+v(3,p{j})*Length, 'Color',col(i,:),'LineWidth',Linewidth)
        end
        s=[s(3,:); s(1:2,:)];
    end
end
xlabel('x','FontSize',12,'FontWeight','bold','Color','r')
ylabel('y','FontSize',12,'FontWeight','bold','Color',[0 0.5 0])
zlabel('z','FontSize',12,'FontWeight','bold','Color','b')
grid on
set(gca,'Clipping','off')
axis equal
%axis vis3d
