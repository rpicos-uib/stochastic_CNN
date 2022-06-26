

close all;


imatges=[];
% imatges=[imatges, "figs/lena"];
% imatges=[imatges, "figs/peppers"];
imatges=[imatges, "figs/airplane"];
% imatges=[imatges, "figs/baboon"];
% imatges=[imatges, "figs/boat"];
% imatges=[imatges, "figs/fruits"];
imatges=[imatges, "figs/monarch"];
% imatges=[imatges, "figs/zelda"];
% imatges=[imatges, "figs/tulips"];
% 
% imatges=[imatges, "figs/fprint3"];
% imatges=[imatges, "figs/girl"];
% imatges=[imatges, "figs/pool"];
% imatges=[imatges, "figs/watch"];
% imatges=[imatges, "figs/serrano"];
% imatges=[imatges, "figs/frymire"];
% imatges=[imatges, "figs/cat"];



edge_im=0;
store_im=1;
sharpen_im=1;


for ind_imatge=1:length(imatges)
    
    imatge=imatges(ind_imatge);
    imatge2 = [imatge + '.png']
    
    frame=imread(imatge2);
    
    ls=size(frame);
    
    x0=1;
    y0=1;
    lx=ls(2)-1;
    ly=ls(1)-1;
    
    mm=min(min(frame))
    Mm=max(max(frame))
    
    % lx=380;
    % ly=380;
    %
    % x0=265;
    % y0=120;
    
    %x0=900;y0=200;
    %lx=1000; ly=1000;
    
    frame0=frame;
    
    try
        imgray0 = rgb2gray(frame);
    catch
        imgray0=frame;
    end
    
    figure()
    imshow(imgray0);
    hold on
    rectangle('Position',[x0,y0,lx, ly],'Edgecolor', 'r');
    
    
    figura=imgray0;
    imwrite(figura, imatge+'_original_grey.jpg')
    
    
    
    if (edge_im==1)
        Niter=200;
        
        % % Edge detection=
        ii0=1;
        ii1=-ii0*1/8; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
        
        oi0=0;
        oi1=-oi0*1/8; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
        
        calcula_CNN;
        
        
        
        figure()
        figura=uint8(256*vxo);
        imshow(figura,'InitialMagnification',20000)
        title('Output Voltage');
        imwrite(figura, imatge+'_border_detection.jpg')
        
    end
    
    
    
    if (store_im==1)
        % Store Image=
        ii0=0.10;
        ii1=0; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
        
        oi0=0.95;
        oi1=0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
        
        
        Niter=700;
        calcula_CNN;
        
        figure()
        figura=uint8(256*vxo);
        imshow(figura,'InitialMagnification',20000)
        title('Output Voltage');
        imwrite(figura, imatge+'_stored.jpg')
        
        rms(rms(imgray0-figura))
        
    end
    
    if (sharpen_im==1)
        
        % Sharp Image=
        ii0=0.50;
        ii1=-0.05; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
        
        oi0=0.30;
        oi1=0.0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
        
        Niter=500;
        calcula_CNN;
        
        figure()
        figura=uint8(256*vxo);
        imshow(figura,'InitialMagnification',20000)
        title('Output Voltage');
        imwrite(figura, imatge+'_sharpening.jpg')

        rms(rms(imgray0-figura))
    end
    
    
    
end

