function term_1 = wyraz_pierwszy_obliczenia(data,model,vi,TT,TR)
%   
%TR   cos theta    -sin theta
%        sin theta      cos theta
x=TT(1,1);
y=TT(2,1);


cos_theta= TR(1,1);
sin_theta=TR(2,1);
term_1=zeros(3,3);
for i= 1:length(vi)
        pix = data(1,i); % punkty z daty
        piy = data(2,i);
       
        qix = model(1,vi(i,1)); % punkty z modelu
        qiy = model(2,vi(i,1)); 
%% 1,1  po x
d2J_dx2 = 2;
%2,1
d2J_dxdy = 0;
%3,1
d2J_dxdtheta = - 2*piy*cos_theta- 2*pix*sin_theta;
%% 1,2 po y 
d2J_dydx = 0;
%2,2
d2J_dy2 = 2;
%3,2
d2J_dydtheta = 2*pix*cos_theta - 2*piy*sin_theta;
%% 1,3 po theta
d2J_dthetadx = - 2*piy*cos_theta - 2*pix*sin_theta;
%2,3
d2J_dthetady = 2*pix*cos_theta - 2*piy*sin_theta;
%3,3
d2J_dtheta2 =(2*pix*cos_theta - 2*piy*sin_theta)*(qix - x - pix*cos_theta + piy*sin_theta) -...
    (2*piy*cos_theta + 2*pix*sin_theta)*(y - qiy + piy*cos_theta + pix*sin_theta) + ...
    (piy*cos_theta + pix*sin_theta)*(2*piy*cos_theta + 2*pix*sin_theta) + ...
    (pix*cos_theta - piy*sin_theta)*(2*pix*cos_theta - 2*piy*sin_theta);
  
term_1=term_1+[d2J_dx2 d2J_dydx d2J_dthetadx;
                                 d2J_dxdy d2J_dy2 d2J_dthetady;
                                 d2J_dxdtheta d2J_dydtheta d2J_dtheta2];
end
end