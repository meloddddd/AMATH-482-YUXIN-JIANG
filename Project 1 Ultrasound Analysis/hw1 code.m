% 482 project 1
close all; clear all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); 
x=x2(1:n); 
y=x; 
z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; 
ks=fftshift(k);
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
figure(1)
Un(:,:,:)=reshape(Undata(20,:),n,n,n);
isosurface(X,Y,Z,abs(Un), 0.75);
axis([-20 20 -20 20 -20 20]), grid on, drawnow;
xlabel('X'), ylabel('Y'), zlabel('Z');
title('Ultrasound with Noise');

% averaging the spectrum
Utave=zeros(n,n,n);
for j=1:20
Un(:,:,:)=reshape(Undata(j,:),n,n,n);
Utn(:,:,:)=fftn(Un);
Utave=Utave+Utn;
end
Utave=abs(fftshift(Utave)/20);
Utave=Utave/max(Utave(:));%normalize

figure(2)
isosurface(Kx,Ky,Kz,Utave, 0.7);
axis([-10 10 -10 10 -10 10]), grid on, drawnow;
xlabel("Kx"), ylabel("Ky"), zlabel("Kz");
title("Fourier Transformed and Averaged Ultrasound");

%find central frequency
[M,N]=max(Utave(:));
[Kxx,Kyy,Kzz]=ind2sub([n,n,n],N);
xfreq=Kx(Kxx,Kyy,Kzz);
yfreq=Ky(Kxx,Kyy,Kzz);
zfreq=Kz(Kxx,Kyy,Kzz);

%filtering and find path
tau=0.4;
filter=exp(-tau*((Kx-xfreq).^2+(Ky-yfreq).^2+(Kz-zfreq).^2));
path=zeros(20,3);
for j=1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    Utn=fftshift(fftn(Un));
    Unft=fftshift(filter.*Utn);
    Unf=ifftn(Unft);
    [Q,W]=max(Unf(:));
    [px,py,pz]=ind2sub([n,n,n],W);
    xpath=X(px,py,pz);
    ypath=Y(px,py,pz);
    zpath=Z(px,py,pz);
    path(j,1)=xpath;
    path(j,2)=ypath;
    path(j,3)=zpath;
end

figure(3)
plot3(path(:,1),path(:,2),path(:,3),'LineWidth', 2)
axis([-15 15 -15 15 -15 15]), grid on, drawnow
xlabel('Path X'), ylabel('Path Y'), zlabel('Path Z')
title('Marble Path');
hold on

%find the final place
plot3(path(20,1),path(20,2),path(20,3),'*','MarkerSize',20);
location=[path(20,1) path(20,2) path(20,3)];
