function cov=numeryczne_pochodne(data1,model,vi,TT,TR,sigma_odl,sigma_KK,cov_z,wghs);

%% These are the interval to approximate the derivatives with the increments.
eps_xy = 0.00001;
eps_t = deg2rad(0.001);
%% Zmienne
Gtot = [0;0;0];
G2tot = zeros(3,3);
Etot = 0;
MMtot = zeros(3,3);

k=1;
%% Pêtla
for i=1:length(data1-1)
%% Zmienne 
x=TT(1,1);
y=TT(2,1);
cos_theta= TR(1,1);
sin_theta=TR(2,1);
 if cos_theta >=0 && sin_theta >=0
    theta=rad2deg(acos(cos_theta));
 else
    theta=-1*rad2deg(acos(cos_theta));
 end
theta = deg2rad(theta);  %% Sprawdziæ czy dzia³a 12.05.2019r!!!
xp = data1(1,i); % punkty z daty
yp = data1(2,i);
       
xq = model(1,vi(i,1)); % punkty z modelu
yq = model(2,vi(i,1)); 

R=[cos(theta) -sin(theta); sin(theta) cos(theta)];

%% Funkcja celu 
E=@(xp_,yp_,xq_,yq_,x_,y_,theta_)...
    wghs(i,1)*norm([cos(theta_) -sin(theta_); sin(theta_) cos(theta_)]*[xp_;yp_]+[x_;y_]-[xq_; yq_])^2;
%% Pierwsza pochodna
gradEk = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			 [deriv(@(xx)E(xp_,yp_,xq_,yq_,xx,y_,theta_), x_, eps_xy); ...
			  deriv(@(yy)E(xp_,yp_,xq_,yq_,x_,yy,theta_), y_, eps_xy); ...
			  deriv(@(tt)E(xp_,yp_,xq_,yq_,x_,y_,tt), theta_, eps_t)];
			
%% Druga pochodna 
d2Ek_dx2 = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			 [deriv(@(xx)gradEk(xp_,yp_,xq_,yq_,xx,y_,theta_), x_, eps_xy) ...
			  deriv(@(yy)gradEk(xp_,yp_,xq_,yq_,x_,yy,theta_), y_, eps_xy) ...
			  deriv(@(tt)gradEk(xp_,yp_,xq_,yq_,x_,y_,tt), theta_, eps_t)];
          
%% szum na 4 sk³adowych
d2Ek_dxdxxp = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(xxp)gradEk(xxp,yp_,xq_,yq_,x_,y_,theta_), xp_, eps_xy);
d2Ek_dxdyyp = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(yyp)gradEk(xp_,yyp,xq_,yq_,x_,y_,theta_), yp_, eps_xy);
d2Ek_dxdxxq = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(xxq)gradEk(xp_,yp_,xxq,yq_,x_,y_,theta_), xq_, eps_xy);
d2Ek_dxdyyq = @(xp_,yp_,xq_,yq_,x_,y_,theta_) ...
			deriv(@(yyq)gradEk(xp_,yp_,xq_,yyq,x_,y_,theta_), yp_, eps_xy);    
  
                 
%% Obliczenia pochodnych %608392893
Gtot = Gtot+ gradEk(xp,yp,xq,yq,x,y,theta);	
G2tot = G2tot+ d2Ek_dx2(xp,yp,xq,yq,x,y,theta);
Etot = Etot + E(xp,yp,xq,yq, x,y,theta);

p_i(1,1)=data1(1,i);
p_i(2,1)=data1(2,i);
Mk = [eye(2) (rot(theta+pi/2)*p_i)] ;
MMtot = MMtot + Mk' * Mk;



dxp=d2Ek_dxdxxp(xp,yp,xq,yq,x,y,theta);
dyp=d2Ek_dxdyyp(xp,yp,xq,yq,x,y,theta);
dxq=d2Ek_dxdxxq(xp,yp,xq,yq,x,y,theta);
dyq=d2Ek_dxdyyq(xp,yp,xq,yq,x,y,theta);
 
 
term_2(1,2*i-1)=dxp(1,1);
term_2(2,2*i-1)=dxp(2,1);
term_2(3,2*i-1)=dxp(3,1);

term_2(1,2*i-0)=dyp(1,1);
term_2(2,2*i-0)=dyp(2,1);
term_2(3,2*i-0)=dyp(3,1);

term_2(1,2*i-1+2*length(data1))=dxq(1,1);
term_2(2,2*i-1+2*length(data1))=dxq(2,1);
term_2(3,2*i-1+2*length(data1))=dxq(3,1);

term_2(1,2*i+2*length(data1))=dyq(1,1);
term_2(2,2*i+2*length(data1))=dyq(2,1);
term_2(3,2*i+2*length(data1))=dyq(3,1);
 

%{
term_2(1,4*i-3)=dxp(1,1);
term_2(2,4*i-3)=dxp(2,1);
term_2(3,4*i-3)=dxp(3,1);

term_2(1,4*i-2)=dyp(1,1);
term_2(2,4*i-2)=dyp(2,1);
term_2(3,4*i-2)=dyp(3,1);

term_2(1,4*i-1)=dxq(1,1);
term_2(2,4*i-1)=dxq(2,1);
term_2(3,4*i-1)=dxq(3,1);

term_2(1,4*i)=dyq(1,1);
term_2(2,4*i)=dyq(2,1);
term_2(3,4*i)=dyq(3,1);
%}
k=k+1;
end

s2 = Etot / (k-3);
sm_cov_bengtsson = 2 * s2 * inv(G2tot);
sm_cov_bengtsson =  s2 * inv(0.5*G2tot);

sm_cov_bengtsson =s2 *inv(MMtot);
cov=inv(G2tot)*term_2*cov_z*(term_2')*inv(G2tot);
test=1;
%cov=((term_1)^-1)*term_2*term_kow*(term_2')*((term_1)^-1);
