function ey=blad_kierunkowy(PP,i,vi,wskaznik,data,model)
xd=data(1,i);
yd=data(2,i);
xm=model(1,vi(i,1));
ym=model(2,vi(i,1));
ey=-100000000000;
if wskaznik ==1 %data
%{
[cw, poprawka]=cwiartka(xd,yd,xm,ym);
gamma= -atan2((ym-yd),(xm-xd))+deg2rad(poprawka);
gamma=gamma+deg2rad(180);
if gamma<0
gamma=gamma+deg2rad(360);     
end
    if gamma >=2*pi
gamma=gamma -deg2rad(360);
    end
    %}
  gamma=atan2(ym-yd,xm-xd);
 if (ym-yd)<0
     gamma=2*pi+gamma;
 end
 S_gamma= [cos((gamma)) sin((gamma))];
 ey=sqrt(S_gamma*PP(i).kow_d*S_gamma');

 %{
 %% TEST
  for zz=1:10:360
     zzz=deg2rad(zz)
S_gamma= [cos((zzz)) sin((zzz))];
ey=sqrt(S_gamma*PP(i).kow_d*S_gamma');
 xt=ey*cos((zzz))
 yt=ey*sin((zzz))
 scatter(xd+xt,yd+yt,'*','b');
 hold on
 end
plotErrorEllipse_bez_dest([xd yd], PP(i).kow_d, 0.391, 'black' ,1);
scatter(xm,ym,'*');
scatter(xd,yd);
xe=(ey)*cos(gamma);
ye=(ey)*sin(gamma);
d=sqrt((xm-xd)^2+(ym-yd)^2);
plot_arrow( xd,yd,xd+xe,yd+ye,'linewidth',2,'color',[0.5 0.5 0.5],'facecolor',[0.5 0.5 0.5] ); 
xdd=d*cos(gamma); ydd=d*sin(gamma);
plot_arrow( xd,yd,xd+xdd,yd+ydd,'linewidth',2,'color',[0.5 0.5 0.5],'facecolor',[0.5 0.5 0.5] ); 
c = num2str(rad2deg(gamma));
dx = 0.001; dy = 0.0; % displacement so the text does not overlay the data points
text(xt+xd+dx, yt+yd+dy, c) 
daspect([1 1 1]);
 %}
%%
%ey=sqrt(PP(i).kow_d(1,1)^2+PP(i).kow_d(2,2)^2);
end

if wskaznik ==0 %model
    %{
[cw, poprawka]=cwiartka(xm,ym,xd,yd);
gamma= -atan2((ym-yd),(xm-xd))+deg2rad(poprawka);
if gamma<0
gamma=gamma+deg2rad(360);     
end
    if gamma >=2*pi
gamma=gamma -deg2rad(360);
    end
 %}
     gamma=atan2(yd-ym,xd-xm);
 if (yd-ym)<0
     gamma=2*pi+gamma;
 end   
  S_gamma= [cos((gamma)) sin((gamma))];
ey=S_gamma*PP(vi(i,1)).kow_m*S_gamma'; %%%%%% zmieni³em na vi chyba ze to samo tak sie liczy
%%
%ey=sqrt(PP(i).kow_m(1,1)^2+PP(i).kow_m(2,2)^2);
%%
end

end