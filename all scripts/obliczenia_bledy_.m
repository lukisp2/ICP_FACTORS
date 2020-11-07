dx=0;
dy=1;
dt=1;

my=0.0127;
mx=0.0112;
mt=0.000001;

dsog_dx=dx/(dt*sqrt(dx^2+dy^2));
dsog_dy=dy/(dt*sqrt(dx^2+dy^2));
dsog_dt=-sqrt(dx^2+dy^2)/dt^2;

msog_2=(dsog_dx^2)*mx^2+(dsog_dy^2)*my^2+(dsog_dt^2)*mt^2
sqrt(msog_2)
