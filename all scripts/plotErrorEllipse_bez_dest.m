
function plotErrorEllipse_bez_dest(mu, Sigma, p, kolor,skala)

    s = -2 * log(1 - p);
    [V, D] = eig(Sigma * s);

    t = linspace(0, 2 * pi);
    a =skala* (V * sqrt(D)) * [cos(t(:))'; sin(t(:))'];    
    plot(a(1, :) +  mu(1), a(2, :) + mu(2), kolor,'LineWidth',1);
    hold on
 %%  scatter(mu(1),mu(2), 'x');
   pause(0.0001);
   daspect([1 1 1])
   hold on
end