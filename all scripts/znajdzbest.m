function best= znajdzbest(particles,best,sn)
%wybór najcie¿szej
najciezsza = -1;
for n=1:length(particles)
    if particles(n).weight > najciezsza
      najciezsza = particles(n).weight;
      best(sn).number=n;
      best(sn).x=particles(n).pose(1,1);
      best(sn).y=particles(n).pose(1,2);
      best(sn).ang=particles(n).pose(1,3);
      best(sn).deg=rad2deg(particles(n).pose(1,3));
      best(sn).waga=particles(n).weight;
      best(sn).V=particles(n).pose(1,5);
      best(sn).COG=particles(n).pose(1,4);
      best(sn).V_WSP=particles(n).pose(1,6);
    end
    end