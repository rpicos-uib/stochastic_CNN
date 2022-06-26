
ii = [ii0 ii1 ii2 ii3 ii4 ii6 ii7 ii8 ii9];
oi = [oi0 oi1 oi2 oi3 oi4 oi6 oi7 oi8 oi9];


vx = 0*ones(ly+1,lx+1);
phi=vx;
vxo=vx;
phii=vx;
vxoo=vxo;

%for i=1:20:lframes-1
%i
%full_frame = read(v,i);
full_frame=frame;
%frame = full_frame(1:lx/2,ly/2:end,:);
%framec = full_frame(x0:x0+lx/2,y0:y0+ly/2,:)
full_frame=frame;

try
    imgray = rgb2gray(frame);
catch
    imgray=frame;
end

frame = imgray(y0:y0+ly,x0:x0+lx);


%figure(222)
%imshow(frame,'InitialMagnification',20000)
%hold on

M0=2;
Cx=.5;
deltat=0.001;
[vxo, phi] = cellular(frame, Niter, vxo, phi, M0, Cx, deltat, ii, oi, d_S_limit, dibuixa);

%[vxoo, phii] = cellular(frame, 10, vxoo, phii, 1*M0, 100*Cx);

%mm=min(min(vxo(2:510,2:510)));
mm=min(min(vxo));
vx2=vxo-mm;
%Mm=max(max(vx2(2:510,2:510)));
Mm=max(max(vx2));


%figure(); imshow(uint8(vx3*256));
%title('Memristance');
%writeVideo(vout2,uint8(256*vx2));
