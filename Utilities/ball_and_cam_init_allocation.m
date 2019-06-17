function [ball_x, ball_y, ball_col] = ball_and_cam_init_allocation(ball_mode, ball_rndfix, ball_seed, foto_mode, foto_rndfix, foto_seed)
% Ôóíêöèÿ: 
% à) âîçâðâùàåò êîîðäèíàòû íà÷àëüíîé ðàññòàíîâêè øàðîâ íà ñòîëå; 
% á) ãåíåðèðóåò 5 ôàéëîâ (image1.bmp ... image5.bmp) ñ ôîòîãðàôèÿìè áèëüÿðäíîãî ñòîëà äëÿ ñèñòåìû êîìïüþòåðíîãî çðåíèÿ;
% â) ôîðìèðóåò ôàéë cam_pos.mat ñ ïåðåìåííûìè Q è TCP, ãäå 
%    Q - ïÿòü ïîç ðîáîòà äëÿ ôîòî, ïîçû çàäàíû îñåâûìè êîîðäèíàòàìè, 
%    TCP - ìàòðèöà ñ îïèñàíèåì ðàçìåùåíèÿ êàìåðû íà ôëàíöå ðîáîòà.
% ã) âîçâðàùàåò öâåòà øàðîâ ball_col
%
% Ïàðàìåòðû:
% ball_mode    - ñõåìà ðàçìåùåíèÿ øàðîâ íà ñòîëå (îò 1 äî 5 - ïðåäóñòàíîâëåííûå ðàññòàíîâêè, 6 - ñëó÷àéíàÿ)
% ball_rndfix  - çàôèêñèðîâàòü ñëó÷àéíóþ ïîñëåäîâàòåëüíîñòü (ball_rndfix=1) ñ ïîìîùüþ seed  
% ball_seed    - seed äëÿ ãåíåðàòîðà, åñëè ball_rndfix ~=0 
% foto_mode    - çàäàåò ãðóïïó èç 5 ðàêóðñîâ ñòîëà ñ øàðàìè äëÿ ñèñòåìû êîìïüþòåðíîãî çðåíèÿ (îò 1 äî 5 - ïðåäóñòàíîâëåííûå íàáîðû ðàêóðñîâ (âñåãî 25 øò.), 6 - ñëó÷àéíûé (5 èç 25))
% foto_rndfix  - çàôèêñèðîâàòü ñëó÷àéíóþ ïîñëåäîâàòåëüíîñòü ðàêóðñîâ äëÿ êàìåðû (foto_rndfix=1) ñ ïîìîùüþ seed  
% foto_seed    - seed äëÿ ãåíåðàòîðà, åñëè foto_rndfix ~=0

AX=[        0     -69.533      85.799           0      73.734         -90;
       39.611      -44.36      45.753           0      88.607     -50.389;
       22.479     -63.398      76.957           0      76.441     -67.521;
      -22.479     -63.398      76.957           0      76.441     -112.48;
      -39.611      -44.36      45.753           0      88.607     -129.61;
            0     -70.618      69.423           0      91.195         180;
       39.611      -44.36      45.753           0      88.607      309.61;
       22.479     -63.657      59.509           0      94.147      292.48;
      -22.479     -63.657      59.509           0      94.147      247.52;
      -39.611      -44.36      45.753           0      88.607      230.39;
            0     -29.128      42.523           0      116.61        -180;
       60.861     -49.113      115.53     -100.77      46.744     -208.68;
        22.98     -25.301      46.314      15.143      106.12     -157.71;
      -60.861     -49.113      115.53      100.77      46.744     -151.32;
       -22.98     -25.301      46.314     -15.143      106.12     -202.29;
      -22.411     -63.816      60.516      18.766      100.62     -110.11;
       -47.36     -18.274       27.98      35.459      116.56     -131.72;
      -28.809     -43.658      87.227      49.421      87.579     -140.55;
       28.809     -43.658      87.227     -49.421      87.579     -219.45;
        47.36     -18.275       27.98     -35.459      116.56     -228.28;
        38.34     -38.442      69.135     -40.488       98.29     -42.968;
       78.514      -25.54      61.178     -37.785      92.866      77.526;
      -15.944     -16.141      42.667      39.701      109.49       221.3;
      -65.984     -43.242      84.574      45.454      82.114      286.04;
   0.00032137     -59.308      153.66         180      59.356         180];

BALLSEED=[24022019 25022019 26022019 27022019 28022019];

TCP = [0 1 0 0; -1 0 0 0; 0 0 1 34; 0 0 0 1];
f = 500;   % ôîêóñ êàìåðû
hx = 854;  % øèðèíà êàäðà
hy = 480;  % âûñîòà êàäðà 

numfoto=5;       % ÷èñëî ôîòîê
r=34;            % ðàäèóñ øàðà
x_min=333;       % ïåðèìåòð ñòîëà ïî øàðó (ñ ïîïðàâêîé íà r)
x_max=1116;      % ---
y_min=-806.5;    % ---
y_max=806.5;     % --- 
z_0=103;         % óðîâåíü ñòîëà ïî øàðó (ñ ïîïðàâêîé íà r)
Rlim=1050;       % ðàáî÷èé âûëåò ðóêè 

ball_col=[255 198 0;
          72 0 255;
          237 28 36;
          146 39 143;
          247 148 29;
          22 95 39;
          128 0 0;
          0 0 0;
          0 204 255]/255;

ball_x=zeros(1,9);
ball_y=zeros(1,9);

if ball_mode==6
    if ball_rndfix~=0
        rng(ball_seed)
    else
        rng('shuffle')
    end
else
    rng(BALLSEED(ball_mode))
end

regen=true;
for i=1:9
    while regen
        ball_x(i)=x_min+rand*(Rlim-x_min);
        ball_y(i)=y_min+rand*(y_max-y_min);
        regen=sqrt(ball_x(i)^2+ball_y(i)^2)>Rlim;
        for j=1:i-1
            if sqrt((ball_x(i)-ball_x(j))^2+(ball_y(i)-ball_y(j))^2)<2*r
                regen=true;
            end
        end
    end
    regen=true;
end

if foto_mode==6
    if foto_rndfix~=0
        rng(foto_seed)
    else
        rng('shuffle')
    end
    nq=randperm(size(AX,1),numfoto);
else
    nq=(foto_mode-1)*numfoto+1:foto_mode*numfoto;
end
Q = AX(nq,:);



hf=figure;
set(hf,'units','pixels','Position',[100 100 hx,hy],'visible','off');
ha=axes;
axis ij;
set(ha,'units','pixels','Position',[0.5 0.5 hx+0.5 hy+0.5],'visible','off')
axis off
axis equal
xlim([0.5 hx+0.5])
ylim([0.5 hy+0.5])

RL=50;
cx=[x_max x_min x_min x_min  x_max x_max];
cy=[y_max y_max   0   y_min  y_min  0];
arc=[270  360    90    90     180  270;
     180  270   -90     0      90  90];
 
table=[];c=[]; n=50;
for i=1:length(cx)
    a=linspace(arc(1,i),arc(2,i),abs(round((arc(1,i)-arc(2,i))/6)))*pi/180;
    b=[cx(i)+RL*cos(a); cy(i)+RL*sin(a); z_0*ones(size(a)); ones(size(a))];
    if ~isempty(table)
        c=[linspace(table(1,end),b(1,1),n); linspace(table(2,end),b(2,1),n); linspace(table(3,end),b(3,1),n); ones(1,n)];
    end
    table=[table c b];
end
 table=[table [linspace(table(1,end),table(1,1),n); linspace(table(2,end),table(2,1),n); linspace(table(3,end),table(3,1),n); ones(1,n)]];

 
for i=1:numfoto
    cla
    T=kuka_forward(Q(i,:),TCP);    
    table_cam=inv(T)*table;
    rectangle('position',[0.5 0.5 hx hy],'FaceColor',[0.8 0.8 0.8],'EdgeColor','none')
    
    px=f*table_cam(1,:)./table_cam(3,:)+hx/2;
    py=f*table_cam(2,:)./table_cam(3,:)+hy/2;
    
    n=find(table_cam(3,:)>0);
    
    patch('Faces',n,'Vertices',[px' py'],'FaceColor',[2 157 41]/255,'EdgeColor','none')
    
    ball_cam=inv(T)*[ball_x; ball_y; z_0*ones(size(ball_x)); ones(size(ball_x))];
    px=f*ball_cam(1,:)./ball_cam(3,:)+hx/2;
    py=f*ball_cam(2,:)./ball_cam(3,:)+hy/2;
    rz=f*r./ball_cam(3,:);
    [~,n]=sort(rz);
    for k=1:length(px)
        j=n(k);
        if rz(j)>0
            rectangle('position',[px(j)-rz(j) py(j)-rz(j) 2*rz(j) 2*rz(j)],'curvature',1,'FaceColor',ball_col(j,:),'EdgeColor','none')
        end
    end

    frame = getframe;

    im = frame2im(frame);
    imwrite(im,['image' num2str(i) '.bmp'])
end
delete(hf)
save('cam_pos.mat','Q','TCP')