
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2,PD3] = CREATEFIT(THETA0K,THETA1K,THETA2K)
%   Creates a plot, similar to the plot in the main distribution fitter
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  3
%   Number of fits:  3
%
%   See also FITDIST.

% This function was automatically generated on 29-May-2019 08:12:30

% Output fitted probablility distributions: PD1,PD2,PD3

% Data from dataset "theta0k data":
%    Y = theta0k

% Data from dataset "theta1k data":
%    Y = theta1k

% Data from dataset "theta2k data":
%    Y = theta2k

% Force all inputs to be column vectors
theta0k = theta0k(:);
theta1k = theta1k(:);
theta2k = theta2k(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};

% --- Plot data originally in dataset "theta0k data"
% This dataset does not appear on the plot

% --- Plot data originally in dataset "theta1k data"
% This dataset does not appear on the plot

% --- Plot data originally in dataset "theta2k data"
% This dataset does not appear on the plot

% Get data limits to determine plotting range
XLim = [min(theta0k), max(theta0k)];
XLim = [min(theta0k), max(theta0k)];
XLim(1) = min(XLim(1), min(theta1k));
XLim(2) = max(XLim(2), max(theta1k));
XLim(1) = min(XLim(1), min(theta2k));
XLim(2) = max(XLim(2), max(theta2k));

% Create grid where function will be computed
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "ICP klasyczne"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('normal',[ -0.002420131347704, 0.08884423628563])
pd1 = fitdist(theta0k, 'normal');
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6,'Color','black');
LegHandles(end+1) = hLine;
LegText{end+1} = 'ICP klasyczne';

% --- Create fit "ICP odporne - wsp. kierunkowy"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd2 = ProbDistUnivParam('normal',[ -0.00267287962739, 0.07735939055636])
pd2 = fitdist(theta1k, 'normal');
YPlot = pdf(pd2,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6,'Color','blue');
LegHandles(end+1) = hLine;
LegText{end+1} = 'ICP odporne - wsp. kierunkowy';

% --- Create fit "ICP odporne"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd3 = ProbDistUnivParam('normal',[ -0.003024228171266, 0.08092569055176])
pd3 = fitdist(theta2k, 'normal');
YPlot = pdf(pd3,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0.666667 0.333333 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6,'Color','red');
LegHandles(end+1) = hLine;
LegText{end+1} = 'ICP odporne';

% Adjust figure
box on;
grid on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
