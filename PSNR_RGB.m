function y=PSNR_RGB(anhGoc,anhThuyVan)
 
n=size(anhGoc);
M=n(1);
N=n(2);
z=n(3);
MSE1=0;
MSE2=0;
MSE3=0;
for i=1:M
    for j=1:N
        
            MSE1=MSE1+double((anhGoc(i,j,1)-anhThuyVan(i,j,1))^2);
            MSE2=MSE2+double((anhGoc(i,j,2)-anhThuyVan(i,j,2))^2);
            MSE3=MSE3+double((anhGoc(i,j,3)-anhThuyVan(i,j,3))^2);
       
    end
end
MSE=(MSE1+MSE2+MSE3)/(M*N*3)
%MSE = sum(sum((aG-aTV).^2))/(M*N);
y = 10*log10(255*255/MSE);