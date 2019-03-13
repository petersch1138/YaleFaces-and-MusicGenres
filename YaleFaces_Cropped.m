clear all; close all; clc;

% Peter Schultz 3/6/19
% Part 1_1 - Yale Faces
% 168*192

numImages=39;
n=64*numImages;
images=zeros(192,168,n);

for k=1:numImages
    if k < 10
        direc = strcat('yalefaces_cropped\CroppedYale\yaleB0',num2str(k),'\');
    else
        direc = strcat('yalefaces_cropped\CroppedYale\yaleB',num2str(k),'\');
    end
    files = dir(direc);
    for i=3:length(files)
        eval(strcat('images(:,:,',num2str((i-2)+(k-1)*64),')=flipud(double(imread(''',direc,files(i).name,''')));'));
    end

end

%%

X=zeros(n,192*168);
for i=1:size(X,1)
    cur = images(:,:,i)';
    X(i,:) = cur(:)';
end
X=X';
% %%
% C=X'*X;
%%
[u,s,v]=svd(X,'econ');

%%
dom=zeros(8,168,192);

for i=1:8
    dom(i,:,:)=reshape(u(:,i),[168,192]);
end

figure
suptitle 'First Eight Dominant SVD Modes for Cropped Faces'
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
%%
% figure
% svs=diag(s);
% semilogy(svs(1:8));
% title 'Singular Values'

figure
eigens=diag(s).^2;
semilogy(eigens(1:50),'Linewidth',2);
title 'Eigen Values'
xlabel 'Index'; ylabel 'Value'

%%
% 
% Y=u.'*X;
%
nMod=25;
vstar=v.';
newA=u(:,1:nMod)*s(1:nMod,1:nMod)*vstar(1:nMod,:);
% 32256x25 * 25x25 * 25x2496
%%

recon=zeros(8,168,192);

for i=1:8
    recon(i,:,:)=reshape(newA(:,((i-1)*64)+1),[168,192]);
end

figure
suptitle 'First Eight Reconstructed Cropped Faces (num modes = 25)'
subplot(2,4,1)
pcolor(squeeze(recon(1,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,2)
pcolor(squeeze(recon(2,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,3)
pcolor(squeeze(recon(3,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,4)
pcolor(squeeze(recon(4,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,5)
pcolor(squeeze(recon(5,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,6)
pcolor(squeeze(recon(6,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,7)
pcolor(squeeze(recon(7,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,8)
pcolor(squeeze(recon(8,:,:))'); colormap gray;shading interp;axis equal;
%%

faces=zeros(8,168,192);

for i=1:8
    faces(i,:,:)=reshape(X(:,((i-1)*64)+1),[168,192]);
end

figure
suptitle 'First Eight Cropped Faces'
subplot(2,4,1)
pcolor(squeeze(faces(1,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,2)
pcolor(squeeze(faces(2,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,3)
pcolor(squeeze(faces(3,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,4)
pcolor(squeeze(faces(4,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,5)
pcolor(squeeze(faces(5,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,6)
pcolor(squeeze(faces(6,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,7)
pcolor(squeeze(faces(7,:,:))'); colormap gray;shading interp;axis equal;
subplot(2,4,8)
pcolor(squeeze(faces(8,:,:))'); colormap gray;shading interp;axis equal;

