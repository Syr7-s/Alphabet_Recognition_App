%A�4
layers = [
    imageInputLayer([127 127 1],"Name","imageinput")
    convolution2dLayer([5 5],64,"Name","conv_1","Padding",[2 2 2 2],"Stride",[2 2])  
    reluLayer("Name","relu_1")
    averagePooling2dLayer([5 5],"Name","avgpool2d_1","Padding",[2 2 2 2],"Stride",[2 2])
    convolution2dLayer([3 3],32,"Name","conv_2","Padding",[1 1 1 1])
    reluLayer("Name","relu_2")
    averagePooling2dLayer([5 5],"Name","avgpool2d_2","Padding",[1 1 1 1])
    convolution2dLayer([3 3],32,"Name","conv","Padding",[1 1 1 1])
    reluLayer("Name","relu_3")
    averagePooling2dLayer([5 5],"Name","avgpool2d_3","Padding",[1 1 1 1])
    fullyConnectedLayer(18,"Name","fc")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
% plot(layerGraph(layers));
% E�itim i�in kullan�lacak parametreler a�a��daki options i�inde
% yazmaktad�r.
options=trainingOptions('adam',...%Kullan�lacak adam optimizasyon algoritmas� kullanaca��z..
    'MiniBatchSize',8,...%Veri setini ka� par�aya b�l�n�p i�lenecek veri ayarlan�r
    'MaxEpochs',6,...
    'InitialLearnRate',1e-4,...
    'Plots','training-progress');
allImages=imageDatastore('HarflerVeriSeti','IncludeSubfolders',true,'LabelSource','foldernames');
[trainingImages,testImages]=splitEachLabel(allImages,0.8,'randomized');
net1=trainNetwork(trainingImages,layers,options);
Pred=classify(net1,testImages);
accuricy=mean(Pred==testImages.Labels)
confusionmat(Pred,testImages.Labels)
