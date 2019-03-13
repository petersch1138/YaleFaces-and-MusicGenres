clear all; close all; clc;

% Peter Schultz 3/6/19
% Part 1_2 - Yale Faces Uncropped
% 320*243

numSubjects=15;
n=11*numSubjects;
uncrop=zeros(243,320,n);
direc='yalefaces_uncropped\yalefaces\';
files = dir(direc);

for k=3:n+2
    eval(strcat('uncrop(:,:,',num2str(k-2),')=flipud(double(imread(''',direc,files(k).name,''')));'));
end

%%

X2=zeros(n,243*320);
for i=1:size(X2,1)
    cur = uncrop(:,:,i)';
    X2(i,:) = cur(:)';
end
X2=X2';

%%
figure
suptitle 'First Eight Uncropped Faces'
subplot(2,4,1)
pcolor(squeeze(uncrop(:,:,1))); colormap gray;shading interp;axis equal;
subplot(2,4,2)
pcolor(squeeze(uncrop(:,:,12))); colormap gray;shading interp;axis equal;
subplot(2,4,3)
pcolor(squeeze(uncrop(:,:,23))); colormap gray;shading interp;axis equal;
subplot(2,4,4)
pcolor(squeeze(uncrop(:,:,34))); colormap gray;shading interp;axis equal;
subplot(2,4,5)
pcolor(squeeze(uncrop(:,:,45))); colormap gray;shading interp;axis equal;
subplot(2,4,6)
pcolor(squeeze(uncrop(:,:,56))); colormap gray;shading interp;axis equal;
subplot(2,4,7)
pcolor(squeeze(uncrop(:,:,67))); colormap gray;shading interp;axis equal;
subplot(2,4,8)
pcolor(squeeze(uncrop(:,:,78))); colormap gray;shading interp;axis equal;

%%
[u,s,v]=svd(X2,'econ');

%%
dom=zeros(8,320,243);

for i=1:8
    dom(i,:,:)=reshape(u(:,i),[320,243]);
end

figure
suptitle 'First Eight Dominant SVD Modes for Uncropped Faces'
subplot(2,4,1)
pcolor(squeeze(dom(1,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,2)
pcolor(squeeze(dom(2,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,3)
pcolor(squeeze(dom(3,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,4)
pcolor(squeeze(dom(4,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,5)
pcolor(squeeze(dom(5,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,6)
pcolor(squeeze(dom(6,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,7)
pcolor(squeeze(dom(7,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,8)
pcolor(squeeze(dom(8,:,:))'); colormap gray;shading interp;axis equal;