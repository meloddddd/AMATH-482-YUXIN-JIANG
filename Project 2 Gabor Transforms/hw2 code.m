%% Part I
clear all; close all; clc;
load handel
v=y'/2;

%Setting up the signal
L=9;
v=v(1:(length(v)-1));
n=length(v);
t=(1:length(v))/Fs;
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; 
ks=fftshift(k);

%Creating Gaussian window a=1 delta translation=0.1
a = 1;
tslide=0:0.1:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(1)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('a=1 dt=0.1')

%Changing window width to a=50 translation=0.1
a=50;
tslide=0:0.1:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(2)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('a=50 dt=0.1')

%Changing window width to a=0.1 translation=0.1
a=0.1;
tslide=0:0.1:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(3)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('a=0.1 dt=0.1')

%Changing sample rate to a=50 translation=0.05
a=50;
tslide=0:0.05:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(4)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('a=50 dt=0.05')

%Changing sample rate to a=50 translation=5
a=50;
tslide=0:5:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(5)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('a=50 dt=5')

%Creating Mexican Hat Wavelet window
a=1;
tslide=0:0.1:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=(2/(sqrt(3*a)*(pi)^(1/4)))*(1-((t-tslide(j))/a).^2).*exp(-(t-tslide(j)).^2/(2*a^2)); 
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(6)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('Mexican Hat Wavelet')

%Creating Shannon Window
a=1;
tslide=0:0.1:9;
vgt_spec = zeros(length(tslide),n);
vgt_spec = [];
for j=1:length(tslide)
    g=(abs(t-tslide(j))<a);
    vg=g.*v; 
    vgt=fft(vg); 
    vgt_spec(j,:) = fftshift(abs(vgt)); 
end

figure(7)
pcolor(tslide,ks,vgt_spec.'), 
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(¦Ø)')
colormap(hot)
title('Shannon Window')

%% Part 2 audio 1
clear all; close all; clc;

y= audioread('music1.wav');
Fs=length(y)/16; 
y=y'/2;
L=16;
n=length(y);
t=(1:length(y))/Fs;
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; 
ks=fftshift(k);
a=30;
tslide=0:0.2:16;
ygt_spec = zeros(length(tslide),n);
ygt_spec = [];
y_score=[];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    yg=g.*y; 
    ygt=fft(yg); 
    ygt_spec(j,:) = fftshift(abs(ygt)); 
    [M,N]=max(abs(ygt));
    y_score=[y_score; abs(k(N))/(2*pi)];
end

figure(1)
pcolor(tslide,ks/(2*pi),ygt_spec.'), 
set(gca,'Ylim', [200 400],'Fontsize', [12])
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(Hz)')
colormap(hot)

figure(2)
plot(tslide, y_score)
xlabel('Time(sec)')
ylabel('Frequency(Hz)')

%% Part 2 audio 2

clear all; close all; clc;

y= audioread('music2.wav');
Fs=length(y)/14; 
y=y'/2;
L=14;
n=length(y);
t=(1:length(y))/Fs;
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; 
ks=fftshift(k);
a=30;
tslide=0:0.2:14;
ygt_spec = zeros(length(tslide),n);
ygt_spec = [];
y_score=[];
for j=1:length(tslide)
    g=exp(-a*(t-tslide(j)).^2); 
    yg=g.*y; 
    ygt=fft(yg); 
    ygt_spec(j,:) = fftshift(abs(ygt)); 
    [M,N]=max(abs(ygt));
    y_score=[y_score; abs(k(N))/(2*pi)];
end

figure(1)
pcolor(tslide,ks/(2*pi),ygt_spec.'), 
set(gca,'Ylim', [800 1100],'Fontsize', [12])
shading interp 
xlabel('Time(sec)')
ylabel('Frequency(Hz)')
colormap(hot)

figure(2)
plot(tslide, y_score)
xlabel('Time(sec)')
ylabel('Frequency(Hz)')
title('Mary Had a Little Lamb Recording')
