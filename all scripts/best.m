function particles= znajdzbest(particles,sn)
%wybór najcie¿szej
najciezsza = -1;
for n=1:lenght(particles)
    if particles(n).weight > najciezsza
        
          best(n).number=n;
      best(n).x=particles(n).pose(1,1);
        best(n).y=particles(n).pose(1,2);
          best(n).ang=particles(n).pose(1,3);
        
    end
   end