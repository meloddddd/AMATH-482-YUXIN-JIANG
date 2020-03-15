clear all; close all; clc;

load fashion_mnist.mat

X_train = im2double(X_train);
X_test = im2double(X_test);
X_train = reshape(X_train,[60000 28 28 1]);
X_test = reshape(X_test,[10000 28 28 1]);
X_train = permute(X_train,[2 3 4 1]);
X_test = permute(X_test,[2 3 4 1]);
X_valid = X_train(:,:,:,1:5000);
X_train = X_train(:,:,:,5001:end);
y_valid = categorical(y_train(1:5000))';
y_train = categorical(y_train(5001:end))';
y_test = categorical(y_test)';

layers = [imageInputLayer([28 28 1])
        fullyConnectedLayer(784)
        %reluLayer
        leakyReluLayer
        fullyConnectedLayer(100)
        %reluLayer
        leakyReluLayer
        %fullyConnectedLayer(100)
        %reluLayer
        fullyConnectedLayer(10)
        softmaxLayer
        classificationLayer];
    
options = trainingOptions('adam', ...
    'MaxEpochs',7,...
    'InitialLearnRate',1e-3, ...
    'L2Regularization',1e-5, ...
    'ValidationData',{X_valid,y_valid}, ...
    'Shuffle','every-epoch',...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(X_train,y_train,layers,options);

figure(1)
y_pred = classify(net,X_test);
plotconfusion(y_test,y_pred)

figure(2)
y_pred = classify(net,X_train);
plotconfusion(y_train,y_pred)

%% convolution

load fashion_mnist.mat

X_train = im2double(X_train);
X_test = im2double(X_test);
X_train = reshape(X_train,[60000 28 28 1]);
X_test = reshape(X_test,[10000 28 28 1]);
X_train = permute(X_train,[2 3 4 1]);
X_test = permute(X_test,[2 3 4 1]);
X_valid = X_train(:,:,:,1:5000);
X_train = X_train(:,:,:,5001:end);
y_valid = categorical(y_train(1:5000))';
y_train = categorical(y_train(5001:end))';
y_test = categorical(y_test)';

layers2 = [
    imageInputLayer([28 28 1])
    convolution2dLayer([8 8],9,"Padding","same","Stride",1)
    leakyReluLayer
    averagePooling2dLayer([5 5],"Padding","same","Stride",[2 2])
    convolution2dLayer([7 7],16,"Padding","same","Stride",1)
    leakyReluLayer
    fullyConnectedLayer(300)
    leakyReluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer()];

options2 = trainingOptions('adam', ...
    'MaxEpochs',7,...
    'InitialLearnRate',1e-3, ...
    'L2Regularization',1e-5, ...
    'ValidationData',{X_valid,y_valid}, ...
    'Shuffle','every-epoch',...
    'Verbose',false, ...
    'Plots','training-progress');

net2 = trainNetwork(X_train,y_train,layers2,options2);

figure(1)
y_pred = classify(net2,X_test);
plotconfusion(y_test,y_pred)

figure(2)
y_pred = classify(net2,X_train);
plotconfusion(y_train,y_pred)
