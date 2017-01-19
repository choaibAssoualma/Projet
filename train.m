

rng('default');

load('input.mat');
load('target.mat');

inputs = input';
targets = target';

hiddenLayerSize =39;
net=patternnet(hiddenLayerSize);

net.initFCN='initlay';

net=init(net);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


%20% des donner pour tester la performance et 80% pour lentrainement A
%revoire
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 80/100;
net.divideParam.testRatio = 20/100;

% For help on training function 'trainscg' type: help trainscg
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainscg';  % Scaled conjugate gradient

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

net.efficiency.memoryReduction = 100;
net.trainParam.max_fail =1000;
net.trainParam.min_grad=1e-6;
net.trainParam.show=10;
net.trainParam.lr=0.01;
net.trainParam.mc=0.9;

net.trainParam.epochs=1000;
net.trainParam.goal=0.00;

% entrainer le reseaux
[net,tr] = train(net,inputs,targets);


% tester le reseaus
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs);
valPerformance = perform(net,valTargets,outputs);
testPerformance = perform(net,testTargets,outputs);




%disp('apres entrainement simulation');
y1 = sim(net,inputs);
y1=abs(y1);
y1=round(y1);

save   C:\Users\choaib\Desktop\Projet\net net;

