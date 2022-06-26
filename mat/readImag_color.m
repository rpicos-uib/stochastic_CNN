
close all;
dibuixa=0;

imatges=[];
%1
imatges=[imatges, "figs/lena"];
imatges=[imatges, "figs/peppers"];
imatges=[imatges, "figs/airplane"];
imatges=[imatges, "figs/baboon"];
imatges=[imatges, "figs/boat"];
%5
imatges=[imatges, "figs/fruits"];
imatges=[imatges, "figs/monarch"];
imatges=[imatges, "figs/zelda"];
imatges=[imatges, "figs/tulips"];
imatges=[imatges, "figs/fprint3"];
%10
imatges=[imatges, "figs/girl"];
imatges=[imatges, "figs/pool"];
imatges=[imatges, "figs/watch"];
imatges=[imatges, "figs/serrano"];
imatges=[imatges, "figs/frymire"];
%15
imatges=[imatges, "figs/cat"];
imatges=[imatges, "figs/us021"];
imatges=[imatges, "figs/us092"];
imatges=[imatges, "figs/arctichare"];
imatges=[imatges, "figs/goldhill"];
%20
imatges=[imatges, "figs/mountain"];
imatges=[imatges, "figs/sails"];
%imatges=["figs_papers/07378461/degraded_lifeboat"];
%imatges=["figs_papers/lena_pixelized"];
%imatges=["figs_papers/tulips_blurred"];
%imatges=["figs_papers/bugatti_blurred"];
%imatges=["figs_papers/chapitel"];
%https://www.tododisca.com/las-radiografias-de-torax-sirven-para-conocer-la-gravedad-del-covid-19/
%imatges=["figs_papers/radiografia-torax"]; d_S_limit=0.00000005



do_color=1;

llista_imatges=1:length(imatges);
llista_imatges=[3,7]; % airplane, monarch
llista_imatges=[9]; % tulips
llista_imatges=[4, 19, 3, 5, 16, 10, 6, 10, 20, 7, 21, 2, 12, 22, 17, 18, 13, 8, 9 ];
d_s_list=[1e-9 5e-10 1e-10 5e-11 1e-11 5e-12 1e-12 5e-13 1e-13 5e-14 1e-14];
d_s_list=d_s_list*1e7;
llista_imatges=[4, 5, 6, 7, 11, 16];   % baboon
d_s_list=[0.047 0.048 0.0482 0.0485 0.0486 0.0488 0.049 0.0492 0.0495 0.0497 0.05 0.051 0.052];

d_s_list=0.035:0.0002:0.054;

error_listBW=[];
entropy_listBW=error_listBW;
error_listcolor=error_listBW;
entropy_listcolor=error_listBW;

for ind_imatge_i=1:length(llista_imatges)
    ind_imatge=llista_imatges(ind_imatge_i);
    
    for d_s_limit_i=1:length(d_s_list)
        
        indice=1;
        
        d_S_limit=d_s_list(d_s_limit_i);
        sufix=["d_S_limit_"+num2str(d_S_limit)+"_"];
        folder=[sufix+"figs"]
        if ~exist(folder,"dir")
            mkdir(folder)
        end
        
        fileID_color=fopen(strcat(folder,'/resultats_color_',num2str(d_S_limit),'.csv'),'w');
        fileID_gray=fopen(strcat(folder,'/resultats_gray_',num2str(d_S_limit),'.csv'),'w');
        
        for do_color=0:0
            edge_im=0;
            store_im=01;
            sharpen_im=0;
            %        d_S_limit=1e-11;
            %l_color is 3 colors for do_color=1;
            
            % We read the files in the original folder
            % We copy them to another folder, including the value of d_S
            % and put everything in the new folder
            imatge=imatges(ind_imatge);
            imatge2 = [imatge + '.png'];
            imatge=[sufix+imatge];
            
            if(do_color==0)
                fileID=fileID_gray;
            else
                fileID=fileID_color;
            end
            
            fprintf(fileID,'%s\t',imatge);
            
            frame=imread(imatge2);
            frame_orig=frame;
            
            % If it's a color image, size=3, otherwise, size=2
            % Thus, we map this to 3 or 1
            ls=size(frame);
            lll=size(ls);
            l_color=(lll(2)-2)*2 + 1;
            
            x0=1;
            y0=1;
            lx=ls(2)-1;
            ly=ls(1)-1;
            
            mm=min(min(frame));
            Mm=max(max(frame));
            
            % lx=380;
            % ly=380;
            %
            % x0=265;
            % y0=120;
            
            %x0=900;y0=200;
            %lx=1000; ly=1000;
            
            if(dibuixa>0)
                
                figure()
                imshow(frame)
                hold on
                
                % Let's draw a rectangle to show the portion of the original image
                % we'll use.
                rectangle('Position',[x0,y0,lx, ly],'Edgecolor', 'r');
            end
            frame0=frame;
            
            % If do_color is 0, convert to gray and save.... except if the
            % image is already grey: we catch the exception!
            if(do_color==0)
                l_color=1;
                try
                    frame0 = rgb2gray(frame);
                catch
                    frame0=frame;
                end
                imwrite(frame0, imatge+'_original_grey.jpg')
            else
                imwrite(frame0, imatge+'_original_color.jpg')
            end
            
            % We can plot the channels:
            fig_color=frame0;
            for i=1:l_color
                if(dibuixa>0)
                    figure(2)
                    subplot(2,l_color,i);
                    imshow(fig_color(:,:,i));
                    title(['Channel ' num2str(i)]);
                end
                imwrite(fig_color(:,:,i), imatge+'_'+num2str(l_color)+'color'+'_channel'+num2str(i)+'_original.jpg');
                Ss=entropy(fig_color(:,:,i))
                fprintf(fileID,'%f\t',Ss);
            end
            
            
            if (store_im==1)
                file_extension='_store'
                % Store Image=
                ii0=0.25;
                ii1=0; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
                ii0=0.45;
                
                oi0=0.95;
                oi1=0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
                oi0=0.15;
                %                oi1=0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
                
                
                Niter=1700;
                rmst=0;
                for repeticiones_calcula_CNN=1:1
                    for ccc=1:l_color
                        frame=fig_color(:,:,ccc);
                        calcula_CNN;
                        figura=uint8(256*vxo);
                        fig_color(:,:,ccc)=uint8(figura);
                        if(dibuixa>0)
                            figure(2)
                            subplot(2,l_color,l_color+ccc);
                            imshow(figura);
                            title(['Mod. Channel ' num2str(ccc)]);
                        end
                        %               if(l_color>1)
                        imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.jpg');
                        %               end
                        erms=rms(rms(frame0(:,:,ccc)-fig_color(:,:,ccc)))
                        rmst=rmst+erms^2;
                        fprintf(fileID,'%f\t',erms);
                        Ss=entropy(fig_color(:,:,ccc))
                        fprintf(fileID,'%f\t',Ss);
                        if(dibuixa>0)
                            figure(334);    %entropy vs time
                            savefig(imatge+'_'+'entropy'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                            figure(335);    %entropy vs time
                            savefig(imatge+'_'+'dentropy_dt'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                        end
                    end
                    
                end
                error_dummy=sqrt(rmst)/l_color
                if(l_color<2)
                    error_listBW(d_s_limit_i,ind_imatge_i)=sqrt(rmst)/l_color;
                    entropy_listBW(d_s_limit_i,ind_imatge_i)=Ss;
                else
                    error_listcolor(d_s_limit_i,ind_imatge_i)=sqrt(rmst)/l_color;
                    entropy_listcolor(d_s_limit_i,ind_imatge_i)=Ss;
                end
                
                fprintf(fileID,'%f\t',error_dummy);
                if(dibuixa>0)
                    
                    figure(1000)
                    title('constructed');
                    imshow(fig_color,'InitialMagnification',20000);
                    title(['constructed' file_extension]);
                end
                imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+file_extension+'.jpg');
            end
            
            if (edge_im==1)
                fig_color=frame0;
                file_extension='_edge'
                Niter=200;
                
                % % Edge detection=
                ii0=1;
                ii1=-ii0*1/8; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
                
                oi0=0;
                oi1=-oi0*1/8; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
                
                
                Niter=700;
                
                for repeticiones_calcula_CNN=1:1
                    for ccc=1:l_color
                        frame=fig_color(:,:,ccc);
                        calcula_CNN;
                        figura=uint8(256*vxo);
                        fig_color(:,:,ccc)=uint8(figura);
                        if(dibuixa>0)
                            figure(2)
                            subplot(2,l_color,l_color+ccc);
                            imshow(figura);
                            title(['Mod. Channel ' num2str(ccc)]);
                            %               if(l_color>1)
                        end
                        imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.jpg');
                        %               end
                        rms(rms(frame0(:,:,ccc)-fig_color(:,:,ccc)))
                        Ss=entropy(fig_color(:,:,ccc))
                        fprintf(fileID,'%f\t',Ss);
                        if(dibuixa>0)
                            figure(334);    %entropy vs time
                            savefig(imatge+'_'+'entropy'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                            figure(335);    %entropy vs time
                            savefig(imatge+'_'+'dentropy_dt'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                        end
                    end
                    
                end
                if(dibuixa>0)
                    figure(1001)
                    title('constructed');
                    imshow(fig_color,'InitialMagnification',20000);
                    title(['constructed' file_extension]);
                end
                imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+file_extension+'.jpg');
            end
            
            
            
            if (sharpen_im==1)
                fig_color=frame0;
                file_extension='_sharpening'
                % Sharp Image=
                ii0=0.50;
                ii1=-0.05; ii2=ii1; ii3=ii1; ii4=ii1; ii6=ii1; ii7=ii1; ii8=ii1; ii9=ii1;
                
                oi0=0.30;
                oi1=-0.0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
                Niter=750;
                
                %             % Sharp, 2nd version
                ii0=0.50;
                ii1=-0.005; ii2=-0.1; ii3=ii1; ii4=ii2; ii6=ii2; ii7=ii1; ii8=ii2; ii9=ii1;
                ii1=-0.00; ii2=-0.07; ii3=ii1; ii4=ii2; ii6=ii2; ii7=ii1; ii8=ii2; ii9=ii1;
                
                oi0=0.30;
                oi1=-0.0; oi2=oi1; oi3=oi1; oi4=oi1; oi6=oi1; oi7=oi1; oi8=oi1; oi9=oi1;
                Niter=350;
                rmst=0;
                for repeticiones_calcula_CNN=1:1
                    for ccc=1:l_color
                        frame=fig_color(:,:,ccc);
                        calcula_CNN;
                        figura=uint8(256*vxo);
                        fig_color(:,:,ccc)=uint8(figura);
                        if(dibuixa>0)
                            figure(2)
                            subplot(2,l_color,l_color+ccc);
                            imshow(figura);
                            title(['Mod. Channel ' num2str(ccc)]);
                        end
                        %               if(l_color>1)
                        imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.jpg');
                        %               end
                        erms=rms(rms(frame0(:,:,ccc)-fig_color(:,:,ccc)))
                        rmst=rmst+erms^2;
                        fprintf(fileID,'%f\t',erms);
                        Ss=entropy(fig_color(:,:,ccc))
                        fprintf(fileID,'%f\t',Ss);
                        if(dibuixa>0)
                            figure(334);    %entropy vs time
                            savefig(imatge+'_'+'entropy'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                            figure(335);    %entropy vs time
                            savefig(imatge+'_'+'dentropy_dt'+'_'+num2str(l_color)+'color'+'_channel'+num2str(ccc)+file_extension+'.fig')
                        end
                    end
                    
                end
                
                fprintf(fileID,'%f\t',sqrt(rmst)/l_color);
                
                if(dibuixa>0)
                    figure(1002)
                    title('constructed');
                    imshow(fig_color,'InitialMagnification',20000);
                    title(['constructed' file_extension]);
                end
                imwrite(fig_color, imatge+'_'+num2str(l_color)+'color'+file_extension+'.jpg');
            end
            fprintf(fileID,'\n');
        end
        
    end % d_s_limit
    
    
    figure(150)
    plot(d_s_list, error_listBW(:,ind_imatge_i),'x-','DisplayName',imatges(ind_imatge));
    hold on;
    legend;
    
    figure(151)
    plot(d_s_list, entropy_listBW(:,ind_imatge_i),'x-','DisplayName',imatges(ind_imatge));
    hold on;
    legend;
    
end % ind_imatge




fclose('all');



eixX
eixY

plot(eixX(iexX>0),eixY(eixX>0))




