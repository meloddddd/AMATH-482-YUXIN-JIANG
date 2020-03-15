clear all; close all; clc;

%% band classification
train=[];
for str=["chopin","acdc","jb"]
    for i=1:2
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=20:10:200 % 19 piece from every music for better results
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            train=[train; fivespec];
        end
    end
end
train=train';
sz = size(train,2)/3; 
    
[U,S,V] = svd(train,'econ');
feature=20;
music = S*V'; % projection onto principal components
U = U(:,1:feature);
chopin = music(1:feature,1:sz);
acdc = music(1:feature,sz+1:2*sz);
jb=music(1:feature, 2*sz+1:3*sz);

ma = mean(chopin,2);
md = mean(acdc,2);
mc = mean(jb,2);
m = (ma+md+mc)/3;
    
    Sw = 0; % within class variances
    for k=1:sz
        Sw = Sw + (chopin(:,k)-ma)*(chopin(:,k)-ma)';
    end
    for k=1:sz
        Sw = Sw + (acdc(:,k)-md)*(acdc(:,k)-md)';
    end
    for k=1:sz
        Sw = Sw + (jb(:,k)-mc)*(jb(:,k)-mc)';
    end
    
    Sb = ((ma-m)*(ma-m)'+(md-m)*(md-m)'+(mc-m)*(mc-m)')/3; % between class 
    
    [V2,D] = eig(Sb,Sw); % linear discriminant analysis
    [~,ind] = max(abs(diag(D)));
    w = V2(:,ind); w = w/norm(w,2);
    
    vchopin = w'*chopin; 
    vacdc = w'*acdc;
    vjb= w'*jb;


% acdc < threshold < chopin < threshold < jb
 
    sortchopin = sort(vchopin);
    sortacdc = sort(vacdc);
    sortjb=sort(vjb);
    
    t1 = length(sortacdc);
    t2 = 1;
    while sortacdc(t1)>sortchopin(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    thresholdacdcchopin = (sortacdc(t1)+sortchopin(t2))/2;
    
    t3=length(sortchopin);
    t4=1;
    while sortchopin(t3)>sortjb(t4)
        t3=t3-1;
        t4=t4+1;
    end
    thresholdchopinjb = (sortchopin(t3)+sortjb(t4))/2;


%test1
test=[];
for i=3
    for str=["chopin","acdc","jb"]
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=20:10:120 % 11 piece from every music 
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            test=[test; fivespec];
        end
    end
end


test=test.';
TestNum=size(test,2);
TestMat = U'*test;  % PCA projection
pval = w'*TestMat;  % LDA projection
figure(1)
bar(pval)
xlabel('Test Data')
ylabel('Projection')
title('LDA of Test 1 Data')
hold on;
yline(thresholdacdcchopin,'-','threshold of acdc and chopin');
hold on;
yline(thresholdchopinjb,'-','threshold of chopin and jb');
hold off;

p=pval;
for i=1:33
    if p(i)<thresholdacdcchopin
        p(i)=-1;%acdc
    elseif  p(i)>thresholdchopinjb
        p(i)=1;%jb
    else thresholdacdcchopin<p(i)<thresholdchopinjb
        p(i)=0;%chopin
    end
end

truep=zeros(1,33);
truep(12:22)=-1;
truep(23:33)=1;

res=p-truep;
k=0;
for i=1:33
    if res(i)==0
        k=k+1;
    end
end

suc1=k/33;

%% the case of seattle
train=[];
for str=["soundgarden","alice","pearl"]
    for i=1:2
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=10:10:140 % 14 piece from every music for better results
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            train=[train; fivespec];
        end
    end
end
train=train';
sz = size(train,2)/3; 
    
[U,S,V] = svd(train,'econ');
feature=20;
music = S*V'; % projection onto principal components
U = U(:,1:feature);
soundgarden = music(1:feature,1:sz);
alice = music(1:feature,sz+1:2*sz);
pearl=music(1:feature, 2*sz+1:3*sz);
    
ma = mean(soundgarden,2);
md = mean(alice,2);
mc = mean(pearl,2);
m = (ma+md+mc)/3;
    
    Sw = 0; % within class variances
    for k=1:sz
        Sw = Sw + (soundgarden(:,k)-ma)*(soundgarden(:,k)-ma)';
    end
    for k=1:sz
        Sw = Sw + (alice(:,k)-md)*(alice(:,k)-md)';
    end
    for k=1:sz
        Sw = Sw + (pearl(:,k)-mc)*(pearl(:,k)-mc)';
    end
    
    Sb = ((ma-m)*(ma-m)'+(md-m)*(md-m)'+(mc-m)*(mc-m)')/3; % between class 
    
    [V2,D] = eig(Sb,Sw); % linear discriminant analysis
    [~,ind] = max(abs(diag(D)));
    w = V2(:,ind); w = w/norm(w,2);
    
    vsoundgarden = w'*soundgarden; 
    valice = w'*alice;
    vpearl= w'*pearl;

% pearl < threshold < soundgarden < threshold < alice
 
    sortsoundgarden = sort(vsoundgarden);
    sortalice = sort(valice);
    sortpearl=sort(vpearl);
    
    t1 = length(sortpearl);
    t2 = 1;
    while sortpearl(t1)>sortsoundgarden(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    thresholdpearlsoundgarden = (sortpearl(t1)+sortsoundgarden(t2))/2;
    
    t3=length(sortsoundgarden);
    t4=1;
    while sortsoundgarden(t3)>sortalice(t4);
        t3=t3-1;
        t4=t4+1;
    end
    thresholdsoundgardenalice = (sortsoundgarden(t3)+sortalice(t4))/2;


%test1
test=[];
for i=3
    for str=["soundgarden","alice","pearl"]
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=20:10:120 % 11 piece from every music 
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            test=[test; fivespec];
        end
    end
end

test=test.';
TestNum=size(test,2);
TestMat = U'*test;  % PCA projection
pval = w'*TestMat;  % LDA projection
figure(2)
bar(pval)
xlabel('Test Data')
ylabel('Projection')
title('LDA of Test 2 Data')
hold on;
yline(thresholdpearlsoundgarden,'-','threshold of soundgarden and pearl');
hold on;
yline(thresholdsoundgardenalice,'-','threshold of soundgarden and alice');
hold off;
p=pval;
for i=1:33
    if p(i)<thresholdpearlsoundgarden
        p(i)=-1;%pearl
    elseif  p(i)>thresholdsoundgardenalice
        p(i)=1;%alice
    else thresholdpearlsoundgarden<p(i)<thresholdsoundgardenalice
        p(i)=0;%soundgarden
    end
end

truep=zeros(1,33);
truep(12:22)=1;
truep(23:33)=-1;

res=p-truep;
k=0;
for i=1:33
    if res(i)==0
        k=k+1;
    end
end

suc2=k/33;


%% genre classification
train=[];
for str=["classical","rock","pop"]
    for i=1:2
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=10:10:150 % 15 piece from every music for better results
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            train=[train; fivespec];
        end
    end
end
train=train';
sz = size(train,2)/3; 
    
[U,S,V] = svd(train,'econ');
feature=20;
music = S*V'; % projection onto principal components
U = U(:,1:feature);
classical = music(1:feature,1:sz);
rock = music(1:feature,sz+1:2*sz);
pop=music(1:feature, 2*sz+1:3*sz);
    
ma = mean(classical,2);
md = mean(rock,2);
mc = mean(pop,2);
m = (ma+md+mc)/3;
    
    Sw = 0; % within class variances
    for k=1:sz
        Sw = Sw + (classical(:,k)-ma)*(classical(:,k)-ma)';
    end
    for k=1:sz
        Sw = Sw + (rock(:,k)-md)*(rock(:,k)-md)';
    end
    for k=1:sz
        Sw = Sw + (pop(:,k)-mc)*(pop(:,k)-mc)';
    end
    
    Sb = ((ma-m)*(ma-m)'+(md-m)*(md-m)'+(mc-m)*(mc-m)')/3; % between class 
    
    [V2,D] = eig(Sb,Sw); % linear discriminant analysis
    [~,ind] = max(abs(diag(D)));
    w = V2(:,ind); w = w/norm(w,2);
    
    vclassical = w'*classical; 
    vrock = w'*rock;
    vpop= w'*pop;

% pop < threshold < rock < threshold < classical
 
    sortclassical = sort(vclassical);
    sortrock = sort(vrock);
    sortpop=sort(vpop);
    
    t1 = length(sortpop);
    t2 = 1;
    while sortpop(t1)>sortrock(t2)
        t1 = t1-1;
        t2 = t2+1;
    end
    thresholdpoprock = (sortpop(t1)+sortrock(t2))/2;
    
    t3=length(sortrock);
    t4=1;
    while sortrock(t3)>sortclassical(t4);
        t3=t3-1;
        t4=t4+1;
    end
    thresholdrockclassical = (sortrock(t3)+sortclassical(t4))/2;


%test1
test=[];
for i=3
    for str=["classical","rock","pop"]
        [song, Fs]=audioread(strcat(str{1},num2str(i),".mp3"));
        song=song'/2;
        song=song(1,:)+song(2,:);
        for j=20:10:120 % 11 piece from every music 
            five=song(Fs*j:Fs*(j+5));
            fivespec=abs(spectrogram(five));
            fivespec=reshape(fivespec, [1,32769*8]);
            test=[test; fivespec];
        end
    end
end

test=test.';
TestNum=size(test,2);
TestMat = U'*test;  % PCA projection
pval = w'*TestMat;  % LDA projection
figure(3)
bar(pval)
xlabel('Test Data')
ylabel('Projection')
title('LDA of Test 3 Data')
hold on;
yline(thresholdpoprock,'-','threshold of pop and rock');
hold on;
yline(thresholdrockclassical,'-','threshold of rock and classical');
hold off;
p=pval;
for i=1:33
    if p(i)<thresholdpoprock
        p(i)=-1;%pop
    elseif  p(i)>thresholdrockclassical
        p(i)=1;%classical
    else thresholdpoprock<p(i)<thresholdrockclassical
        p(i)=0;%rock
    end
end

truep=zeros(1,33);
truep(1:11)=1;
truep(23:33)=-1;

res=p-truep;
k=0;
for i=1:33
    if res(i)==0
        k=k+1;
    end
end

suc3=k/33;

