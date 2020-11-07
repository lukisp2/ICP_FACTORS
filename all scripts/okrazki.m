A=imread('C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat.jpg');
B=A(:,:,1);
[w l] = size(B);

for ww=1:w
    for ll=1:l
        if B(ww,ll)<80
           B(ww,ll)=0; 
        end
        
          if B(ww,ll)>230
           B(ww,ll)=255; 
          end        
    end  
end

imwrite(B,'C:\Users\Admin\Dysk Google\AKADEMIA\programy\MATLAB\skrypty\Mobile Robotics Simulation Toolbox\code\examples\matlab\kwadrat4.pgm')
