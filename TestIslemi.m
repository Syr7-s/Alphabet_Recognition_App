% Ag1 i�in test islemi
% load('derinAg1.mat')
% [TestAdi TestYolu]=uigetfile('*.png','Test Resmi Se�iniz');
% A=imread([TestYolu TestAdi]);
% [Pred scores]=classify(net1,A);
%Ag2 i�in test islemi
% load('derinAg2.mat')
% [TestAdi TestYolu]=uigetfile('*.png','Test Resmi Se�iniz');
% A=imread([TestYolu TestAdi]);
% [Pred scores]=classify(net1,A);
%Ag4 icin test islemi
load('derinAg4.mat')
[TestAdi TestYolu]=uigetfile('*.png','Test Resmi Se�iniz');
A=imread([TestYolu TestAdi]);
[Pred scores]=classify(net1,A);
