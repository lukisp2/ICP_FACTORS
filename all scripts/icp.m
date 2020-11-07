function [TR,TT,data] = icp(model,data,maxIter,minIter,critFun,thres,data_M,model_M,cykl)

% ICP (iterative closest point) algorithm
%        # point-to-point distance minimization
%        # robust criterion function using IRLS (optional)
%   Simple usage (least-squares minimization):
%   [R,T,data2] = icp(model,data)
%   ICP fits points in data to the points in model.
%   (default) Fit with respect to minimize the sum of square
%   errors with the closest model points and data points.
%   (optional) Using a robust criterion function
%
%   INPUT:
%
%   model - matrix with model points, [ X_1 X_2 ... X_M ]
%   data - matrix with data points,   [ P_1 P_2 ... P_N ]
%
%   OUTPUT:
%
%   R - rotation matrix
%   T - translation vector
%   data2 - matrix with transformed data points,   [ P_1 P_2 ... P_N ]
%
%           data2 = R*data + T
%
%
%   Usage:
%
%   [R,T,data2] = icp(model,data,maxIter,minIter,critFun,thres)
%
%   INPUT:
%
% 	maxIter - maximum number of iterations. Default = 100
%
% 	minIter - minimum number of iterations. Default = 5
%
%   critFun  -  0 Fit with respect to minimize the sum of square errors. (default)
%               1 Huber criterion function (robust)
%               2 Tukey's bi-weight criterion function (robust)
%               3 Cauchy criterion function (robust)
%               4 Welsch criterion function (robust)
%
% 	thres - error differens threshold to stop iterations. Default = 1e-5
%
%   m-file can be downloaded for free at
%   http://www.mathworks.com/matlabcentral/fileexchange/12627-iterative-closest-point-method
%
%   icp version 1.6
%
%   written by Per Bergström 2016-12-11
%
% Reference:
%
% Bergström, P. and Edlund, O. 2014, 'Robust registration of point sets using iteratively reweighted least squares'
% Computational Optimization and Applications, vol 58, no. 3, pp. 543-561, 10.1007/s10589-014-9643-2
%


% Check input arguments
cykl=cykl*1;
if nargin<2
    
    error('To few input arguments');
    
elseif nargin<6
    
    thres=1e-8;                     % threshold to stop icp iterations
    if nargin<5
        critFun=0;                  % critFun method, LS
        if nargin<4
            minIter=3;              % min number of icp iterations
            if nargin<3
                maxIter=100;        % max number of icp iterations
            end
        end
    end
    
end

if or(isempty(model),isempty(data))
    error('Something is wrong with the model points and data points');
end

% Use default values

if isempty(maxIter)
    maxIter=100;
end

if isempty(minIter)
    minIter=5;
end

if isempty(critFun)
    critFun=0;
end

if isempty(thres)
    thres=1e-8;
end

% Size of model points and data points

if (size(model,2)<size(model,1))
    mTranspose=true;
    m=size(model,2);
    M=size(model,1);
else
    mTranspose=false;
    m=size(model,1);
    M=size(model,2);
end

if (size(data,2)<size(data,1))
    data=data';
end

if m~=size(data,1)
    error('The dimension of the model points and data points must be equal');
end

N=size(data,2);

% Create closest point search structure
if m<4
    if mTranspose
   DT=delaunayTriangulation(model);
   IC = incenter(DT);
   figure(2)
   triplot(DT)
   hold on
   plot(IC(:,1),IC(:,2),'*r')
%   pause(1);
   close;
    else
  figure(2)
  DT=delaunayTriangulation(model');
  IC = incenter(DT);
  triplot(DT)
  hold on
  plot(IC(:,1),IC(:,2),'*r')
 % pause(1); 
 close;
    end
else
    DT=[];
    resid=zeros(N,1);
    vi=ones(N,1);
end

% Initiate weights (Only for robust criterion)
if critFun>=0
    wghs=ones(N,1);
%    wghs(42,1)=1000;
%    wghs(44,1)=1000;
    
end

% Initiate transformation
TR=eye(m);
TT=zeros(m,1);

% Start the ICP algorithm

res=9e99;

for iter=1:maxIter
    
    oldres=res;
    
    % Find closest model points to data points
    
    if isempty(DT)
        if mTranspose
            for i=1:N
                mival=9e99;
                for j=1:M
                    val=norm(data(:,i)-model(j,:)'); % to mo¿e byæ odleg³oœæ euklidesowa miêdzy punktami to siê mierzy jako d³ugoœæ  wektora
                    if val<mival
                        mival=val;
                        vi(i)=j;
                        resid(i)=val;
                    end
                end
            end
        else
            for i=1:N
                mival=9e99;
                for j=1:M
                    val=norm(data(:,i)-model(:,j));
                    if val<mival
                        mival=val;
                        vi(i)=j;
                        resid(i)=val;
                    end
                end
            end
        end
    else
        [vi,resid] = nearestNeighbor(DT,data');
    end
    %{
    for i=1:length(vi)
        d=data';
        x=DT.Points(vi(i,1),1);
        y=DT.Points(vi(i,1),2);
        xquery=d(i,1);
        yquery=d(i,2);
        figure(2)
   triplot(DT)
  % hold on
  % plot(IC(:,1),IC(:,2),'*r');
   hold on
   plot(data(1,:),data(2,:),'k.')
   hold on
   scatter(xquery,yquery);
   scatter(x,y);
   pause(4);
   close;
    end
    %}
    % Find transformation
  
    switch critFun
        case 0
            res=mean(resid.^2);
            med=mean(data,2); % œrednia wartoœæ wzd³u¿ wiersza czyli chyba œrednia wszystkich x i y-ków
            if mTranspose
                mem=mean(model(vi,:),1);
                C=data*model(vi,:)-(N*med)*mem;
                [U,~,V]=svd(C);
                Ri=V*U';
                if det(Ri)<0
                    V(:,end)=-V(:,end);
                    Ri=V*U';
                end
                Ti=mem'-Ri*med;
            else
                mem=mean(model(:,vi),2);
                C=data*model(:,vi)'-(N*med)*mem';
                [U,~,V]=svd(C);
                Ri=V*U';
                if det(Ri)<0
                    V(:,end)=-V(:,end);
                    Ri=V*U';
                end
                Ti=mem-Ri*med;
            end
            
        otherwise
            
            % Estimation of bound which 80% of data is less than
            kRob = 1.9*median(resid);
            
            maxResid=max(resid);
            if kRob<1e-6*maxResid
                kRob=0.3*maxResid;
            elseif maxResid==0
                kRob=1;
            end
            
            res=mean(resid(resid<1.5*kRob).^2);
            
            switch critFun
              
                case 1
                    % Huber
                  %{
                       kRob=2.0138*kRob;
                    for i=1:N
                        if resid(i)<kRob
                            wghs(i)=1;
                        else
                            wghs(i)=kRob/resid(i);
                        end
                            wghs=ones(N,1);
                    end
                    %}
                    kRob = 4.9*median(resid);
                      for i=1:cykl
                        e= (data_M(1,i)^2+model_M(1,vi(i,1))^2)^0.5;
                        %e=1/data_M(1,i);
                         wghs(i)=1/e;
                          if resid(i)>kRob
                            wghs(i)=0;
                          end
                      end       
                    
                case 2
                    % Tukey's bi-weight
                    kRob=7.0589*kRob;
                    for i=1:N
                        if resid(i)<kRob
                            wghs(i)=(1-(resid(i)/kRob)^2)^2;
                        else
                            wghs(i)=0.0*wghs(i);
                        end
                    end
                    
                case 3
                    % Cauchy
                    kRob=4.3040*kRob;
                    wghs=1./(1+(resid/kRob).^2);
                case 4
                    % Welsch
                    kRob=4.7536*kRob;
                    wghs=exp(-(resid/kRob).^2);
                otherwise
                    % Huber
                    kRob=2.0138*kRob;
                    for i=1:N
                        if resid(i)<kRob
                            wghs(i)=1;
                        else
                            wghs(i)=kRob/resid(i);
                        end
                    end
            end
            suWghs=sum(wghs); % w z daszkiem
            
            med=(data*wghs)/suWghs;  %% x z kreska
            if mTranspose
                mem=(wghs'*model(vi,:))/suWghs;
                C=data*(model(vi,:).*repmat(wghs,1,m))-(suWghs*med)*mem;
                [U,~,V]=svd(C);
                Ri=V*U';
                if det(Ri)<0
                    V(:,end)=-V(:,end);
                    Ri=V*U';
                end
                Ti=mem'-Ri*med;
            else
                mem=(model(:,vi)*wghs)/suWghs; % y z kreska
                C=(data.*repmat(wghs',m,1))*model(:,vi)'-(suWghs*med)*mem'; %weighted covariance matrix
                A=repmat(wghs',m,1);
                [U,~,V]=svd(C); % A singular value decomposition is performed on C
                Ri=V*U'; %Which then gives the update Ri?to the rotation matrix R
                if det(Ri)<0
                    V(:,end)=-V(:,end);
                    Ri=V*U';
                end
                Ti=mem-Ri*med;
            end
            
    end
    
    data=Ri*data;                       % Apply transformation
    for i=1:m
        data(i,:)=data(i,:)+Ti(i);      %
    end
    
    TR=Ri*TR;                           % Update transformation
    TT=Ri*TT+Ti;                        %
    
    if iter >= minIter
        if abs(oldres-res) < thres
            break
        end
    end
%close;
%figure(3)
%plot(model(1,:),model(2,:),'r.',data(1,:),data(2,:),'b.'), axis equal  
%pause(0.25)
end

