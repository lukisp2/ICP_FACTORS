 function term_2 = wyraz_drugi_obliczenia(data,model,vi,TT,TR)
        
x=TT(1,1);
y=TT(2,1);
cos_theta= TR(1,1);
sin_theta=TR(2,1);
term_2=zeros(3,4*length(vi));

for i= 1:length(vi) 
 pix = data(1,i); % punkty z daty
 piy = data(2,i);
   
 qix = model(1,vi(i,1)); % punkty z modelu
 qiy = model(2,vi(i,1));        

%% Pi
d2J_dpix_dx = 2*cos_theta;  
d2J_dpix_dy =2*sin_theta;  
d2J_dpix_dtheta = sin_theta*(2*pix*cos_theta - 2*piy*sin_theta) +...
    2*cos_theta*(y - qiy + piy*cos_theta + pix*sin_theta) + 2*sin_theta*...
    (qix - x - pix*cos_theta + piy*sin_theta) - cos_theta*(2*piy*cos_theta + 2*pix*sin_theta);   

d2J_dpiy_dx =  -2*sin_theta;
d2J_dpiy_dy = 2*cos_theta;
d2J_dpiy_dtheta =sin_theta*(2*piy*cos_theta + 2*pix*sin_theta)...
    + 2*cos_theta*(qix - x - pix*cos_theta + piy*sin_theta) - 2*sin_theta*...
    (y - qiy + piy*cos_theta + pix*sin_theta) + cos_theta*(2*pix*cos_theta - 2*piy*sin_theta);

%% Qi
d2J_dqix_dx =-2;
d2J_dqix_dy = 0;
d2J_dqix_dtheta = 2*piy*cos_theta + 2*pix*sin_theta;

d2J_dqiy_dx = 0;
d2J_dqiy_dy = -2;
d2J_dqiy_dtheta = 2*piy*sin_theta - 2*pix*cos_theta;
%%
term_2(1,4*i-3)=d2J_dpix_dx;
term_2(2,4*i-3)=d2J_dpix_dy;
term_2(3,4*i-3)=d2J_dpix_dtheta;

term_2(1,4*i-2)=d2J_dpiy_dx;
term_2(2,4*i-2)=d2J_dpiy_dy;
term_2(3,4*i-2)=d2J_dpiy_dtheta;

term_2(1,4*i-1)=d2J_dqix_dx;
term_2(2,4*i-1)=d2J_dqix_dy;
term_2(3,4*i-1)=d2J_dqix_dtheta;

term_2(1,4*i)=d2J_dqiy_dx;
term_2(2,4*i)=d2J_dqiy_dy;
term_2(3,4*i)=d2J_dqiy_dtheta;

end
end