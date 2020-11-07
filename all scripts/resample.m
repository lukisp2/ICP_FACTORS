function particles = resample(particles)
numParticles = length(particles);
w = [particles.weight];

%useNeff = true;
useNeff = false;

if useNeff
    neff = 1./sum (w.^2)
    neff
    if  neff > 0.5 *numParticles;
        newParticles = particles;
        disp('liczba neff:' + length(newParticles));
        for i= 1:numParticles
            newParticles(i).weight = w(i);
        end 
        return;
    end
end
newParticles = struct;

for i=1:numParticles
    newParticles(i).pose=zeros(3,1);
    newParticles(i).weight=1/length(particles);
    newParticles(i).history(3,100)=0;
end

% low variance resampling
cs = cumsum(w);
weightSum= cs(length(cs));

% ruletka inicjalizacja 
step = weightSum/numParticles;
position = unifrnd(0, weightSum);
idx =1;
% podró¿ po ruletce aby wybraæ cz¹stke
cykl=1;
for i =1 :numParticles
    position =position + step;
    if(position >weightSum)
        position = position -weightSum;
        idx=i;
    end
    while (position >cs(idx))
        idx=idx+1;
    end
  %newParticles(i)=particles(idx);
  %newParticles(i).weight = 1/numParticles; 
    %a=particles(idx)
   
    particles(i)=particles(idx);
    particles(i).weight= 1/numParticles;

end
end



