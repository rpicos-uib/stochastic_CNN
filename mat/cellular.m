
function [vxo, phi] = cellular(A, Niter, vxo, phi, Mm0, Cc, deltatt, ii, oi, d_S_limit, dibuixa)
%close all;
%imatge="figs/lena";
%imatge="figs/peppers";
%imatge="figs/airplane";
%imatge="figs/baboon";
%imatge="figs/boat";
%imatge="figs/fruits";
%imatge="figs/monarch";
%imatge="figs/zelda";
%imatge="figs/tulips";

ls=size(A);

lx=ls(1);
ly=ls(2);

scal=0.10;

%A=imread([imatge + '.png']);

%image(A)

try
    imgray = rgb2gray(A);
catch
    imgray=A;
end

immin=double(min(min(imgray)));
immax=double(max(max(imgray)));
imgrayd=(double(imgray)-immin)/(immax-immin);
%imshow(uint8(imgrayd*256));

% mm=min(min(imgrayd))
% Mm=max(max(imgrayd))

vx=double(vxo)/scal;
vxo=vx*scal;
%vx = zeros(lx,ly);
%phi=vx;
%vxo=vx;
vxi=double(imgrayd);
vxi=double(imgray);


Cx=50;
deltat=.1;
M0=0.1;

M0=Mm0;
Cx=Cc;

%Cx=0.01;


deltat=deltatt;
deltatC=deltat/Cx;

% % Edge detection=
%  ii0=1;
%  ii1=-ii0*1/8; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
%
% oi0=0;
% oi1=-oi0*1/8; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;

ii0 = ii(1); ii1=ii(2); ii2=ii(3);
ii3=ii(4); ii4=ii(5); ii6=ii(6);
ii7=ii(7); ii8= ii(8); ii9=ii(9);

oi0 = oi(1); oi1=oi(2); oi2=oi(3);
oi3=oi(4); oi4=oi(5); oi6=oi(6);
oi7=oi(7); oi8= oi(8); oi9=oi(9);


S_imagen=zeros(Niter,1);
d_S_imagen=S_imagen;
S_imagen_previa=0;

ll_N = Niter/5;
ind_iter=0;

for lll=1:5
    for ll=1:ll_N
        ind_iter=ind_iter+1;
        
        for i=2:lx-2
            
            for j=2:ly-2
                
                M = M0*(1+0.1*(phi(i,j)^2));
                
                inp = vxi(i-1,j-1)*ii1 + vxi(i,j-1)*ii2 + vxi(i+1,j-1)*ii3 + vxi(i,j-1)*ii4;
                inp = inp + vxi(i,j+1)*ii6 +vxi(i+1,j-1)*ii7 +vxi(i+1,j)*ii8 + vxi(i+1,j+1)*ii9;
                inp = inp + vxi(i,j)*ii0;
                inp = inp - vx(i,j)*(ii0+ii1+ii2+ii3+ii4+ii6+ii7+ii8+ii9);
                
                outp = vxo(i-1,j-1)*oi1 + vxo(i,j-1)*oi2 + vxo(i+1,j-1)*oi3 + vxo(i,j-1)*oi4;
                outp = outp + vxo(i,j+1)*oi6 +vxo(i+1,j-1)*oi7 +vxo(i+1,j)*oi8 + vxo(i+1,j+1)*oi9;
                outp = outp + vxo(i,j)*oi0;
                outp = outp - vx(i,j)*(oi0+oi1+oi2+oi3+oi4+oi6+oi7+oi8+oi9);
                
                
                phi(i,j) = phi(i,j) + deltat*vx(i,j);
                vx(i,j)= vx(i,j) + deltatC*( -vx(i,j) + inp + outp )/M;
                vxo(i,j)=vx(i,j)*scal;
                
                
            end
            
        end
        
        %        ll;
        Ss=entropy(uint8(vxo*256));
        S_imagen(ind_iter)=Ss;
        d_S_imagen(ind_iter)=Ss-S_imagen_previa;
        S_imagen_previa=Ss*0.4+S_imagen_previa*0.6;
        if(d_S_imagen(ind_iter)<d_S_limit)
            break;
        end
        
        if(dibuixa>0)
            figure(334);
            plot(1:Niter,S_imagen);
            figure(335);
            plot(1:Niter,d_S_imagen);
            figure(333);
            imshow(uint8(vxo*256));
            title(num2str(ll+ (lll-1)*ll_N));
        end
        
    end
    
    %
    %
    % mm=min(min(vxo(2:510,2:510)))
    % vx2=vxo-mm;
    % Mm=max(max(vx2(2:510,2:510)))
    %
    % vx2=vx2./Mm*256;
    %
    % vx2=vxo;
    % %figure(); imshow(uint8(vx2))
    %
    % Mm = 1+M0*phi.^2;
    % mm=min(min(Mm(2:510,2:510)));
    % vx2=Mm-mm;
    % Mm=max(max(vx2(2:510,2:510)));
    % vx2=vx2./Mm*256;
    % %figure(); imshow(uint8(vx2));
    
    
end


end