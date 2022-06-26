close all;


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
%imatges=["figs_papers/07378461/degraded_lifeboat"];
%imatges=["figs_papers/lena_pixelized"];
%imatges=["figs_papers/tulips_blurred"];
%imatges=["figs_papers/bugatti_blurred"];
%imatges=["figs_papers/chapitel"];
%https://www.tododisca.com/las-radiografias-de-torax-sirven-para-conocer-la-gravedad-del-covid-19/
%imatges=["figs_papers/radiografia-torax"]; d_S_limit=0.00000005



do_color=1;

llista_imatges=1:length(imatges);
llista_imatges=[3,7,9]; % airplane, monarch
%llista_imatges=[9]; % tulips


for ind_imatge=llista_imatges

    figure()
        imatge=imatges(ind_imatge);
        title(imatge);
        imatge2 = [imatge + '.png']
        
        frame=imread(imatge2);
        try
            frame0 = rgb2gray(frame);
        catch
            frame0 = frame;
        end
        subplot(2,1,1);
        imhist(frame0);
 myHist = findobj(gcf, 'Type', 'Stem');
 % Change the color to red
 myHist.Color = [1 0 0];
 title('Original');

        xlabel('Gray level');
        ylabel('Counts');
        
        imatge2 = [imatge + '_1_store.jpg']
        
        frame=imread(imatge2);
        try
            frame0 = rgb2gray(frame);
        catch
            frame0 = frame;
        end
        
        subplot(2,1,2);
        imhist(frame0*0.94)
        title('Processed');
        xlabel('Gray level');
        ylabel('Counts');



end % end ind_imatge