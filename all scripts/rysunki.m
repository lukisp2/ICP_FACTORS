A=imread('C:\Users\Admin\Documents\Latex\figures\Dopasowanie.jpg');

a=0
for i =1: size(A,1)
    
    for j =1:size(A,2)
        
        for k=1:size(A,3)
          
            if A(i,j,k) < 250  && A(i,j,k)> 200
      
               % A(i,j,k)= 255;
            end
        end
    end
end
imwrite(A,'C:\Users\Admin\Documents\Latex\figures\Dopasowanie.jpg');

imshow(A);