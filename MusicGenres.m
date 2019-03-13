clear all; close all; clc;

% Peter Schultz 3/6/19
% Part 2_1 - Music Classification

L=5;
Fs=44100/2;
n = L*Fs;

X=zeros(n,366);
test=zeros(n,63);
path='Music\';
cur=dir(path);

count=0;
tests=0;
for i=1:length(cur)-2
    
    eval(strcat('[y, Fs]=audioread(''',path,cur(i+2).name,''');'));
    
    y=mean(y,2);
    y=resample(y,1,2);
    Fs=Fs/2;
    for j = 1:round(length(y)/(n))-1
        if j < round(length(y)/(n))-7
            count=count+1;
            X(:,count)=y(1+((j-1)*n):(j*n));
        else
            tests=tests+1;
            test(:,tests)=y(1+((j-1)*n):(j*n));
        end
    end
    
end                    


%%
% 
Xt=abs(fftshift(fft(X)));

[u,s,v]=svd(Xt,'econ');
k = (1/L)*(-n/2:(n/2)-1);
%%
rap=test(:,1:21);
rapt=abs(fftshift(fft(rap)));

piano=test(:,22:42);
pianot=abs(fftshift(fft(piano)));

rnb=test(:,43:63);
rnbt=abs(fftshift(fft(rnb)));

%%
eigens=diag(s).^2;
figure
semilogy(eigens(1:12),'LineWidth',2);
title 'Eigen Values for Dominant Principal Modes';
xlabel 'Index'
ylabel 'Magnitude'
%%
figure

subplot(4,2,1)
plot(k,u(:,1));
xlim([-1000 1000])
title '1'

subplot(4,2,2)
plot(k,u(:,2));
xlim([-1000 1000])
title '2'

subplot(4,2,3)
plot(k,u(:,3));
xlim([-1000 1000])
title '3'

subplot(4,2,4)
plot(k,u(:,4));
xlim([-1000 1000])
title '4'

subplot(4,2,5)
plot(k,u(:,5));
xlim([-1000 1000])
title '5'

subplot(4,2,6)
plot(k,u(:,6));
xlim([-1000 1000])
title '6'

subplot(4,2,7)
plot(k,u(:,7));
xlim([-1000 1000])
title '7'

subplot(4,2,8)
plot(k,u(:,8));
xlim([-1000 1000])
title '8'

suptitle 'Top 8 Principle Modes for Piano, Rap, R&B Genres';
%%
nMod=3; % 1,3,5 - 
modes(:,1)=u(:,1);
modes(:,2)=u(:,2);
modes(:,3)=u(:,3);

rapTrain=X(:,1:151);
pianoTrain=X(:,152:294);
rnbTrain=X(:,295:366);

rapProj=modes.'*rapTrain;
pianoProj=modes.'*pianoTrain;
rnbProj=modes.'*rnbTrain;

% through 151 is rap
% 152 through 294 is piano
% 295 through 366 is rnb

% 110250x3 * 3x3 * 3x366
mp=max(abs(pianoProj),[],2);
mrn=max(abs(rnbProj),[],2);
mr=max(abs(rapProj),[],2);

for i=1:size(pianoProj,1)
    pianoProj(i,:)=pianoProj(i,:)/mp(i);
end
for i=1:size(rnbProj,1)
    rnbProj(i,:)=rnbProj(i,:)/mrn(i);
end
for i=1:size(rapProj,1)
    rapProj(i,:)=rapProj(i,:)/mr(i);
end

figure
h=scatter3(rapProj(1,:),rapProj(2,:),rapProj(3,:),30); hold on
h.MarkerFaceColor = [1 .2 .2];
% xlim([-1 1]);ylim([-1 1]);zlim([-1 1]);

xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'

h2=scatter3(rnbProj(1,:),rnbProj(2,:),rnbProj(3,:),30);
h2.MarkerFaceColor = [1 1 .2];
% xlim([-1 1]);ylim([-1 1]);zlim([-1 1]);

xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'

h3=scatter3(pianoProj(1,:),pianoProj(2,:),pianoProj(3,:),30);
h3.MarkerFaceColor = [.2 .2 1];
% xlim([-1 1]);ylim([-1 1]);zlim([-1 1]);

xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'
legend('Rap','R&B','Piano');
title('Projections of Training Set onto Top 3 Principal Modes');


%% project other data onto dominant modes


pianoResult=modes.'*pianot;
rnbResult=modes.'*rnbt;
rapResult=modes.'*rapt;

mpiano=max(abs(pianoResult),[],2);
mrnb=max(abs(rnbResult),[],2);
mrap=max(abs(rapResult),[],2);

for i=1:3
    pianoResult(i,:)=pianoResult(i,:)/mpiano(i);
    rnbResult(i,:)=rnbResult(i,:)/mrnb(i);
    rapResult(i,:)=rapResult(i,:)/mrap(i);
end
figure
h=scatter3(rapResult(1,:),rapResult(2,:),rapResult(3,:),30); hold on

h.MarkerFaceColor = [1 .2 .2];
xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'

h2=scatter3(rnbResult(1,:),rnbResult(2,:),rnbResult(3,:),30);
h2.MarkerFaceColor = [1 1 .2];
xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'

h3=scatter3(pianoResult(1,:),pianoResult(2,:),pianoResult(3,:),30);
h3.MarkerFaceColor = [.2 .2 1];
xlabel 'Mode 1'
ylabel 'Mode 2'
zlabel 'Mode 3'
legend('Rap','R&B','Piano');
title('Projections of Test Clips onto Top 3 Principal Modes');


