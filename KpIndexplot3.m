function outPP_h =KpIndexplot3(I_kpstuff,varargin)

% http://www.mathworks.com/matlabcentral/answers/58971-bar-plot-with-bars-i
% n-different-colors

%http://stackoverflow.com/questions/13266352/matlab-bar-graph-fill-bars-wit
%h-different-colours-depending-on-sign-and-magnit

% correct version as of 30/Jul 2014

%% 
% if nargin< 1,
%     Kpvec=[];
% elseif nargin==1
% end
Kpvec=I_kpstuff.Kpvec;
stTime=I_kpstuff.stTime;

inputString=varargin{1,1}{1,2};  % used in Sunsc>importAIA
plotfig=varargin{1,1}{1,1};
varargin=varargin{1,1};

%% Import the Kp data
load('..\Insitu\Omni\Kp03_13.mat');

ind22=find(Kp(:,1)>stTime);


KPmatrix22= Kp(ind22(1)-2:ind22(1)+2,:);  % 5 days of data starting 1/2 days prior
KPmatrix= KPmatrix22(:,2:end);
% 1,1,2,1,1,1,1,0;...
%            0,1,1,0,1,1,2,2;...
% KPmatrix= [1,2,0,1,1,3,3,3;...
%            3,3,1,1,1,1,1,2;...
%            3,3,2,2,1,1,3,2;...
%            2,2,1,1,1,2,1,1;...
%            0,0,0,0,1,1,3,2];


% KPmatrix= [1,1,2,1,4;...
%            0,1,6,0,7];       

NN=size(KPmatrix,1);
PP=size(KPmatrix,2);
for ii=1:1:NN
    data((PP*ii-(PP-1)):(PP*ii),1)=KPmatrix(ii,:);
end
N=numel(data);


%% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %%
figure
set(gcf,'Units','centimeters')
set(gcf,'Position',[11.8,6.7,16.3,10.0])
%%%%%%%%%%%%%%%%%%%%% horizontal lines for kp= 2, 4, 6, 8 
ha1=plot([0 N],[2 2],'Color',[0,0.8,0],'LineStyle','-','Linewidth',1);hold on
ha2=plot([0 N],[3 3],'Color',[0,0.8,0],'LineStyle',':','Linewidth',1);
ha3=plot([0 N],[4 4],'Color',[0.8,0.8,0],'LineStyle','-','Linewidth',1);
ha4=plot([0 N],[5 5],'Color',[0.8,0,0],'LineStyle',':','Linewidth',1);
ha5=plot([0 N],[6 6],'Color',[0.8,0,0],'LineStyle','-','Linewidth',1);
ha6=plot([0 N],[8 8],'Color',[0.8,0,0],'LineStyle','-','Linewidth',1);
%%%%%%%%%%%%%%%%%%%%%
hb=bar(data); 
set(get(hb,'children'),'cdata', sign(data-4) );
colormap([0 1 0;1 1 0; 1 0 0]);
caxis([3 5])

hbar=gca;
set(hbar,'Units','centimeters') 
set(hbar,'Position',[1.9,1.7,12.5,7.0])
%% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %%



xlim([0.5,(N+0.5)]);
ylim([0 9]);
ylabel('Kp Index','FontSize',15)
xlabel('','FontSize',15)
set(hbar, 'XTickLabel', '')
set(hbar,'XTick',[])
set(hbar,'fontsize',15)
set(hbar, 'ytick',[1,2,3,4,5,6,7,8,9])
set(hbar,'YMinorTick','off')
set(hbar, 'yticklabel',{'','2','','4','','6','','8',''})



% vertical lines for start of ea day
% for jj=1:1:NN
%     ha3=plot([PP*jj-(PP-1), PP*jj-(PP-1)],[0 9],':k','Linewidth',1);
% end
% hb=bar(data);
%hb=bar(data,'style','hist');

kptxt={'Kp<4','Kp=4','Kp>4'};
text(N+(N/30),2,kptxt{1,1}, 'color',DarkGreen, ...
     'horizontalalignment','center','Rotation',90,'FontSize',15)
text(N+(N/30),4.2,kptxt{1,2}, 'color','yellow' , ...
     'horizontalalignment','center','Rotation',90,'FontSize',15)
text(N+(N/30),6.6,kptxt{1,3}, 'color',DarkRed , ...
     'horizontalalignment','center','Rotation',90,'FontSize',15)

% % '05 Jan','','','','','','','',...
% %             '06 Jan','','','','','','','',...
% uniNames = {'07 Jan','','','','','','','',...
%             '08 Jan','','','','','','','',...
%             '09 Jan','','','','','','','',...
%             '10 Jan','','','','','','','',...
%             '11 Jan','','','','','','',''};
%         
% xlabetxt = uniNames';
% ypos = -max(ylim)/25;
% set(gca,'XTick',1:8:57)
% text(1:N,repmat(ypos,N,1), ...
%      xlabetxt','horizontalalignment','center','Rotation',0,'FontSize',15)


%%%%%%%%%%%%%%%   stairs(x,sin(x))
%%%%%%%%%%%%%%%  BarCenters = [x1]  MATLAB 2014a  !!!!!
outPP_h=hb;



%% overplot Timaeaxis with extra stuff
ax2_2 = axes('Units','centimeters','Position',get(hbar,'Position'),...
           'XAxisLocation','bottom',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor',[0.0,0.0,0.0],'YColor',[0.0,0.0,0.0]);
h2_2 = line(Kpvec(:,1),Kpvec(:,2),'Color',[0.6,0.0,0.0],'LineStyle','-','Linewidth',2.5,'Parent',ax2_2);
hold on
h2_3=stairs(Kpvec(:,1),Kpvec(:,2),'Color',[1.0,0.6,0.6],'LineStyle','-','Linewidth',2.5,'Parent',ax2_2);hold on
delete(h2_2)
clear h2_2
t1=KPmatrix22(1,1);t2=KPmatrix22(end,1)+1;
%t1=datenum([2014,01,07,0,0,0]);t2=datenum([2014,01,12,0,0,0]);
set(ax2_2,'XLim',[t1,t2])
set(ax2_2,'ylim',get(hbar,'ylim'))
set(ax2_2, 'ytick',t1:1:t2-1)
set(ax2_2,'fontsize',15)
xlabel('Universal Time','FontSize',15)

%TimeAxisSet ('mat',ax2_2)
disp(['st time=  ', num2str(t1)]); disp(['st time KP=  ', num2str(KPmatrix22(1,1))]);
disp(['en time=  ', num2str(t2)]);disp(['en time KP=  ', num2str(KPmatrix22(end,1))]);

% vertical lines for start of ea day
for jj=1:1:NN+1
    ha3=plot([t1+jj-1,t1+jj-1],[0 9],':k','Linewidth',1,'Parent',ax2_2);
end
%hb=bar(data);

% uniNames = {'15 Jun','16 Jun','17 Jun','18 Jun','19 Jun','20 Jun'};
uniNames = {'07 Jan','08 Jan','09 Jan','10 Jan','11 Jan','12 Jan'};
uniNamestemp = datestr([KPmatrix22(:,1);KPmatrix22(end,1)+1],'dd mmm');
n_rows=1;
n_colm=length(KPmatrix22(:,1))+1;
n_char=size(uniNamestemp,2);
uniNames2 = mat2cell(uniNamestemp,ones(n_colm,1),n_char);
set(ax2_2,'XTickLabel',uniNames2 );

%% DISPLAY:
% the NASA CCMC prediction on 2014 event
% t1ccmc=datenum([2012,06,16,10,20,0]);
t1ccmc=datenum([2014,01,09,00,38,0]);
tCcmcErr= 9./24;
ccmcKpmax=8.0; ccmcKpmin=6.0;ccmcKpave=(ccmcKpmax+ccmcKpmin)/2;
xpoints=[t1ccmc-tCcmcErr,t1ccmc+tCcmcErr,t1ccmc+tCcmcErr,t1ccmc-tCcmcErr];
ypoints=[ccmcKpmax,ccmcKpmax,ccmcKpmin,ccmcKpmin];
haCCMC(1)=fill(xpoints,ypoints,[0.3 0.3 1],'Parent',ax2_2);
set(haCCMC(1),'EdgeColor','g','FaceAlpha',0.2,'EdgeAlpha',0);

haCCMC(2)=line([t1ccmc,t1ccmc],[ccmcKpave-0.15,ccmcKpave+0.15],...
        'Color',[0,0,0.7],'LineStyle','-','Linewidth',1,'Parent',ax2_2);
haCCMC(3)=line([t1ccmc-tCcmcErr,t1ccmc+tCcmcErr],[ccmcKpave,ccmcKpave],...
        'Color',[0.4,0.4,1],'LineStyle','-','Linewidth',3,'Parent',ax2_2);    
% haCCMC(4)=plot([t1ccmc-tCcmcErr],[ccmcKpave],'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(5)=plot([t1ccmc+tCcmcErr],[ccmcKpave],'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(6)=plot([t1ccmc],[ccmcKpmax],'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(7)=plot([t1ccmc],[ccmcKpmin],'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
text(t1ccmc+tCcmcErr+0.1,7.6,'NASA CCMC Prediction', 'color',DarkBlue , ...
     'horizontalalignment','left','Rotation',0,'FontSize',13)


% the NOAA SWPC prediction on 2014 event
% t1swpc=datenum([2012,06,16,19,00,0]);
t1swpc=datenum([2014,01,09,12,00,0]);
tswpcErr= 7./24;
swpcKpmax=7.1; swpcKpmin=5.9;swpcKpave=(swpcKpmax+swpcKpmin)/2;
xpoints=[t1swpc-tswpcErr,t1swpc+tswpcErr,t1swpc+tswpcErr,t1swpc-tswpcErr];
ypoints=[swpcKpmax,swpcKpmax,swpcKpmin,swpcKpmin];
haCCMC(8)=fill(xpoints,ypoints,[0.3 0.3 1],'Parent',ax2_2);
set(haCCMC(8),'EdgeColor','g','FaceAlpha',0.2,'EdgeAlpha',0);

haCCMC(9)=line([t1swpc,t1swpc],[swpcKpave-0.15,swpcKpave+0.15],...
        'Color',[0,0,0.7],'LineStyle','-','Linewidth',1,'Parent',ax2_2);
haCCMC(10)=line([t1swpc-tswpcErr,t1swpc+tswpcErr],[swpcKpave,swpcKpave],...
        'Color',[0.4,0.4,1],'LineStyle','-','Linewidth',3,'Parent',ax2_2);    
% haCCMC(11)=plot(t1swpc-tswpcErr,swpcKpave,'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(12)=plot(t1swpc+tswpcErr,swpcKpave,'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(13)=plot(t1swpc,swpcKpmax,'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
% haCCMC(14)=plot(t1swpc,swpcKpmin,'Color',[0,0,0.7],...
%     'Marker','+','Linewidth',1,'Parent',ax2_2);
text(t1swpc+tswpcErr-0.4,5.4,'NOAA SWPC Prediction', 'color',DarkBlue , ...
     'horizontalalignment','left','Rotation',0,'FontSize',13)





 
% the NEW MODEL prediction on 2014 event
[NewMKp,tempI]=max(Kpvec(:,2));
t1swpc=Kpvec(tempI,1);
tswpcErr= 9./24;
NewMKpmax=8.94; NewMKpmin=6.88; NewMKpave=(NewMKpmax+NewMKpmin)/2;
xpoints=[t1swpc-tswpcErr,t1swpc+tswpcErr,t1swpc+tswpcErr,t1swpc-tswpcErr];
ypoints=[NewMKpmax,NewMKpmax,NewMKpmin,NewMKpmin];
haCCMC(15)=fill(xpoints,ypoints,[1 0.3 0.3],'Parent',ax2_2);
set(haCCMC(15),'EdgeColor','r','FaceAlpha',0.2,'EdgeAlpha',0);

haCCMC(16)=line([t1swpc,t1swpc],[NewMKp-0.2,NewMKp+0.2],...
        'Color',DarkRed,'LineStyle','-','Linewidth',1,'Parent',ax2_2);
haCCMC(17)=plot([t1swpc-tswpcErr,t1swpc+tswpcErr],[NewMKp,NewMKp],...
        'Color',[1,0.4,0.4],'LineStyle','-','Linewidth',5,'Parent',ax2_2);
text(t1swpc+tswpcErr+0.05,NewMKp,'New Model Prediction', 'color',DarkRed , ...
     'horizontalalignment','left','Rotation',0,'FontSize',13)

%% 
h2_3=stairs(Kpvec(:,1),Kpvec(:,2),'Color',DarkRed,'LineStyle','-','Linewidth',2.5,'Parent',ax2_2);hold on
 
temp=1;

end




