delta_x=sym('delta_x','real');
delta_y=sym('delta_y','real');
delta_theta=sym('delta_theta','real');
delta_t=sym('delta_t','real');
%%
sog=sqrt(delta_x^2+delta_y^2)/delta_t;

dsog_dx=diff(sog,delta_x)
dsog_dy=diff(sog,delta_y)
dsog_dt=diff(sog,delta_t)

%%
rot=-delta_theta/delta_t;
drot_dtheta=diff(rot,delta_theta)
drot_dt=diff(rot,delta_t)

%%
cog=atan(delta_y/delta_x);
dcog_dx=diff(cog,delta_x)
dcog_dx=diff(cog,delta_y)


