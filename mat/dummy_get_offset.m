% https://blogs.mathworks.com/steve/2009/02/18/image-overlay-using-transparency/

close all


imatges=[];
imatges=[imatges, "figs/arctichare"];
imatges=[imatges, "figs/fruits"];
imatges=[imatges, "figs/monarch"];
imatges=[imatges, "figs/zelda"];
imatges=[imatges, "figs/tulips"];

ind_imatge=3;
imatge=imatges(ind_imatge);
imatge2 = [imatge + '.png']

frame=imread(imatge2);

ls=size(frame);
lll=size(ls);
l_color=(lll(2)-2)*2 + 1;

x0=1;
y0=1;
lx=ls(2)-1;
ly=ls(1)-1;


mm=min(min(frame))
Mm=max(max(frame))
figure(1)
imshow(frame)
hold on
% Let's draw a rectangle to show the portion of the original image
% we'll use.
rectangle('Position',[x0,y0,lx, ly],'Edgecolor', 'r');
frame0=frame;


frame = frame0(y0:y0+ly,x0:x0+lx);
hold on


mm=(min(min(frame)))
file_extension='_3_sharpening';
imatge2 = [imatge+ file_extension + '.jpg']

frame2=imread(imatge2);

h=imshow(frame2)

figure(2)
subplot(1,2,1)
imshow(frame0);
subplot(1,2,2);
imshow(frame2);


%block_size = 150;
%P = ceil( (ly+1) / block_size);
%Q = ceil((lx+1) / (2*block_size));

P=6;
Q=6;
block_size=ceil(min((ly+1)/P,(lx+1)/Q));
alpha_data = checkerboard(block_size, P, Q) > 0;
alpha_data = alpha_data(1:ly+1, 1:lx+1);
set(h, 'AlphaData', alpha_data);        
