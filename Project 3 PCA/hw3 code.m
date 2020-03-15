%% Case 1
clear all; close all; clc;
load('cam1_1.mat')
load('cam2_1.mat')
load('cam3_1.mat')

f1=size(vidFrames1_1,4);
f2=size(vidFrames2_1,4);
f3=size(vidFrames3_1,4);

%track the motion
x1=[];
y1=[];
for i=1:f1
    x=double(rgb2gray(vidFrames1_1(:,:,:,i)));
    x(400:end,:)=0;
    x(1:210,:)=0; 
    x(:,400:end)=0; 
    x(:,1:300)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y1(i)=mean(b);
    x1(i)=mean(a);
end

x2=[];
y2=[];
for i=1:f2
    x=double(rgb2gray(vidFrames2_1(:,:,:,i)));
    x(1:110,:)=0; 
    x(370:end,:)=0;
    x(:,350:end)=0; 
    x(:,1:200)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y2(i)=mean(b);
    x2(i)=mean(a);
end

x3=[];
y3=[];
for i=1:f3
    x=double(rgb2gray(vidFrames3_1(:,:,:,i)));
    x(1:250,:)=0; 
    x(350:end,:)=0; 
    x(:,500:end)=0; 
    x(:,1:200)=0;
    M=max(x(:));
    [a,b]=find(x>=M*0.92);
    y3(i)=mean(b);
    x3(i)=mean(a);
end
x2=x2(10:end);
y2=y2(10:end);%aligh the second one
%plot(x1);hold on
%plot(x2);
%plot(y3)

%PCA

l=min([length(x1),length(x2),length(y3)]);
A=[x1(1:l);y1(1:l);x2(1:l);y2(1:l);x3(1:l);y3(1:l)];

[m,n]=size(A);
mn=mean(A,2);
A=A-repmat(mn,1,n);

[u,s,v]=svd(A,'econ');
figure(1)
plot(diag(s)/sum(diag(s)),'ro')
xlabel('Principal Component');
ylabel('Energy Level Percentage');
title('Ideal');

figure(2)
subplot(2,1,1)
plot(1:l,x1(1:l), 1:l, y1(1:l))
legend('z','xy')
xlabel('Time')
ylabel('Location')
title('Original Movement Cam1')
subplot(2,1,2)
plot(v*s)
legend('comp1','comp2','comp3','comp4','comp5','comp6')
xlabel('Time')
ylabel('Location')
title('Dynamic Captured with PCA');
%% Case 2

clear all; close all; clc;
load('cam1_2.mat')
load('cam2_2.mat')
load('cam3_2.mat')

f1=size(vidFrames1_2,4);
f2=size(vidFrames2_2,4);
f3=size(vidFrames3_2,4);

%track the motion
x1=[];
y1=[];
for i=1:f1
    x=double(rgb2gray(vidFrames1_2(:,:,:,i)));
    x(400:end,:)=0;
    x(1:210,:)=0; 
    x(:,400:end)=0; 
    x(:,1:300)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y1(i)=mean(b);
    x1(i)=mean(a);
end

x2=[];
y2=[];
for i=1:f2
    x=double(rgb2gray(vidFrames2_2(:,:,:,i)));
    x(1:100,:)=0; 
    x(370:end,:)=0;
    x(:,450:end)=0; 
    x(:,1:200)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y2(i)=mean(b);
    x2(i)=mean(a);
end

x3=[];
y3=[];
for i=1:f3
    x=double(rgb2gray(vidFrames3_2(:,:,:,i)));
    x(1:210,:)=0; 
    x(315:end,:)=0; 
    x(:,500:end)=0; 
    x(:,1:220)=0;
    M=max(x(:));
    [a,b]=find(x>=M*0.92);
    y3(i)=mean(b);
    x3(i)=mean(a);
end
x2=x2(20:end);
y2=y2(20:end);%aligh the second one
%plot(x1);hold on
%plot(x2);
%plot(y3)

%PCA

l=min([length(x1),length(x2),length(y3)]);
A=[x1(1:l);y1(1:l);x2(1:l);y2(1:l);x3(1:l);y3(1:l)];

[m,n]=size(A);
mn=mean(A,2);
A=A-repmat(mn,1,n);

[u,s,v]=svd(A,'econ');
figure(1)
plot(diag(s)/sum(diag(s)),'ro')
xlabel('Principal Component');
ylabel('Energy Level Percentage');
title('Noisy');

figure(2)
subplot(2,1,1)
plot(1:l,x1(1:l), 1:l, y1(1:l))
legend('z','xy')
xlabel('Time')
ylabel('Location')
title('Original Movement Cam1')
subplot(2,1,2)
plot(v*s)
legend('comp1','comp2','comp3','comp4','comp5','comp6')
xlabel('Time')
ylabel('Location')
title('Dynamic Captured with PCA');
%% Horizontal
clear all; close all; clc;
load('cam1_3.mat')
load('cam2_3.mat')
load('cam3_3.mat')

f1=size(vidFrames1_3,4);
f2=size(vidFrames2_3,4);
f3=size(vidFrames3_3,4);

%track the motion
x1=[];
y1=[];
for i=1:f1
    x=double(rgb2gray(vidFrames1_3(:,:,:,i)));
    x(400:end,:)=0;
    x(1:210,:)=0; 
    x(:,400:end)=0; 
    x(:,1:300)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y1(i)=mean(b);
    x1(i)=mean(a);
end

x2=[];
y2=[];
for i=1:f2
    x=double(rgb2gray(vidFrames2_3(:,:,:,i)));
    x(1:150,:)=0; 
    x(370:end,:)=0;
    x(:,450:end)=0; 
    x(:,1:200)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y2(i)=mean(b);
    x2(i)=mean(a);
end

x3=[];
y3=[];
for i=1:f3
    x=double(rgb2gray(vidFrames3_3(:,:,:,i)));
    x(1:210,:)=0; 
    x(315:end,:)=0; 
    x(:,500:end)=0; 
    x(:,1:220)=0;
    M=max(x(:));
    [a,b]=find(x>=M*0.92);
    y3(i)=mean(b);
    x3(i)=mean(a);
end

x1=x1(5:end);
y1=y1(5:end)
x2=x2(35:end);
y2=y2(35:end);%aligh the second one
%plot(x1);hold on
%plot(x2);
%plot(y3)

%PCA

l=min([length(x1),length(x2),length(y3)]);
A=[x1(1:l);y1(1:l);x2(1:l);y2(1:l);x3(1:l);y3(1:l)];

[m,n]=size(A);
mn=mean(A,2);
A=A-repmat(mn,1,n);

[u,s,v]=svd(A,'econ');
figure(1)
plot(diag(s)/sum(diag(s)),'ro')
xlabel('Principal Component');
ylabel('Energy Level Percentage');
title('Horizontal');

figure(2)
subplot(2,1,1)
plot(1:l,x1(1:l), 1:l, y1(1:l))
legend('z','xy')
xlabel('Time')
ylabel('Location')
title('Original Movement Cam1')
subplot(2,1,2)
plot(v*s)
legend('comp1','comp2','comp3','comp4','comp5','comp6')
xlabel('Time')
ylabel('Location')
title('Dynamic Captured with PCA');
%% Horizontal and Rotation
clear all; close all; clc;
load('cam1_4.mat')
load('cam2_4.mat')
load('cam3_4.mat')

f1=size(vidFrames1_4,4);
f2=size(vidFrames2_4,4);
f3=size(vidFrames3_4,4);

%track the motion
x1=[];
y1=[];
for i=1:f1
    x=double(rgb2gray(vidFrames1_4(:,:,:,i)));
    x(400:end,:)=0;
    x(1:210,:)=0; 
    x(:,400:end)=0; 
    x(:,1:300)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y1(i)=mean(b);
    x1(i)=mean(a);
end

x2=[];
y2=[];
for i=1:f2
    x=double(rgb2gray(vidFrames2_4(:,:,:,i)));
    x(1:100,:)=0; 
    x(370:end,:)=0;
    x(:,450:end)=0; 
    x(:,1:200)=0;
    M=max(x(:));
    [a,b]=find(x>=(M*0.92));
    y2(i)=mean(b);
    x2(i)=mean(a);
end

x3=[];
y3=[];
for i=1:f3
    x=double(rgb2gray(vidFrames3_4(:,:,:,i)));
    x(1:150,:)=0; 
    x(315:end,:)=0; 
    x(:,500:end)=0; 
    x(:,1:280)=0;
    M=max(x(:));
    [a,b]=find(x>=M*0.92);
    y3(i)=mean(b);
    x3(i)=mean(a);
end

x2=x2(5:end);
y2=y2(5:end);%aligh the second one
%plot(x1);hold on
%plot(x2);
%plot(y3)

%PCA

l=min([length(x1),length(x2),length(y3)]);
A=[x1(1:l);y1(1:l);x2(1:l);y2(1:l);x3(1:l);y3(1:l)];

[m,n]=size(A);
mn=mean(A,2);
A=A-repmat(mn,1,n);

[u,s,v]=svd(A,'econ');
figure(1)
plot(diag(s)/sum(diag(s)),'ro')
xlabel('Principal Component');
ylabel('Energy Level Percentage');
title('Horizontal and Rotation');

figure(2)
subplot(2,1,1)
plot(1:l,x1(1:l), 1:l, y1(1:l))
legend('z','xy')
xlabel('Time')
ylabel('Location')
title('Original Movement Cam1')
subplot(2,1,2)
plot(v*s)
legend('comp1','comp2','comp3','comp4','comp5','comp6')
xlabel('Time')
ylabel('Location')
title('Dynamic Captured with PCA');

