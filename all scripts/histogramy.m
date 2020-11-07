nbins=20;
edges = [-0.25 -0.25:0.01:0.25 0.25];
figure(1)
ax1 = subplot(6,1,1); % upper subplot
nbins=20;
h1 = histogram(ax1,KK0K,edges,'Normalization','pdf','FaceColor','black');
%h1.Normalization = 'probability';
pd = fitdist(KK0K','Normal');
x_pdf = [-0.25:0.01:0.25];
y0k = pdf(pd,x_pdf);
line(x_pdf,y0k,'LineWidth',2)


ax2 = subplot(6,1,2); % middle subplot
h2 = histogram(ax2,KK2K,edges,'Normalization','pdf','FaceColor','blue');
%h2.Normalization = 'probability';
hold on
pd = fitdist(KK1K','Normal');
y1k = pdf(pd,x_pdf);
line(x_pdf,y1k,'LineWidth',2)
hold off

ax3=subplot(6,1,3); % lower subplot
h3 = histogram(ax3,KK2K,edges,'Normalization','pdf','FaceColor','red');
%h3.Normalization = 'probability';
hold on
pd = fitdist(KK2K','Normal');
y2k = pdf(pd,x_pdf);
line(x_pdf,y2k,'LineWidth',2)
hold off


ax4=subplot(6,1,4); % lower subplot
h3 = histogram(ax4,KK3K,edges,'Normalization','pdf','FaceColor','red');
%h3.Normalization = 'probability';
hold on
pd = fitdist(KK3K','Normal');
y3k = pdf(pd,x_pdf);
line(x_pdf,y3k,'LineWidth',2)
hold off

ax5=subplot(6,1,5); % lower subplot
h3 = histogram(ax5,KK4K,edges,'Normalization','pdf','FaceColor','red');
%h3.Normalization = 'probability';
hold on
pd = fitdist(KK4K','Normal');
y4k = pdf(pd,x_pdf);
line(x_pdf,y4k,'LineWidth',2)
hold off


ax6=subplot(6,1,3); % lower subplot
line(x_pdf,y0k,'LineWidth',2,'Color','black')
hold on
line(x_pdf,y1k,'LineWidth',2,'Color','red')
line(x_pdf,y2k,'LineWidth',2, 'Color','blue') 
line(x_pdf,y3k,'LineWidth',2, 'Color','yellow') 
line(x_pdf,y4k,'LineWidth',2, 'Color','green')
pause(5)
close all



