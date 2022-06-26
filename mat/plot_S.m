%close all;
dibuixa=0;

d_s_list=[1e-9 5e-10 1e-10 5e-11 1e-11 5e-12 1e-12 5e-13 1e-13 5e-14 1e-14]*1e8
Fig_color=[];
Fig_gray=[];
S_Total=[];
e_Stored=[];
S_Stored=[];
for d_s_limit_i=1:length(d_s_list)
    d_S_limit=d_s_list(d_s_limit_i);
    sufix=["d_S_limit_"+num2str(d_S_limit)+"_"];
    folder=[sufix+"figs"]
    
    fileID_color=fopen(strcat(folder,'/resultats_color_',num2str(d_S_limit),'.csv'),'r');
    fileID_gray=fopen(strcat(folder,'/resultats_gray_',num2str(d_S_limit),'.csv'),'r');
    
    fid=fileID_gray;
    
tline = fgetl(fid);
fig_color=[];
fig_gray=[];

while ischar(tline)
    k = regexp(tline, '\t', 'once');
    fila=str2num(tline(k+1:end));
    if(length(fila)>10)
        fig_color=[fig_color; fila];
    else
        fig_gray=[fig_gray; fila];
    end
    tline = fgetl(fid);
end    
    
S_total=fig_gray(:,1);
e_stored=fig_gray(:,8);
S_stored=fig_gray(:,3);
e_stored(4)

S_Total=[S_Total; S_total'];
e_Stored=[e_Stored; e_stored'];
S_Stored=[S_Stored; S_stored'];


end


figure()
ii=1:10;
plot3(S_Total(:,ii),e_Stored(:,ii),S_Stored(:,ii),'.');
xlabel('S_{total}');
ylabel('e_{stored}');
zlabel('S_{stored}');


