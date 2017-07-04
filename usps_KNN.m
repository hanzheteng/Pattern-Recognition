% K-Nearest Neighbors algorithm on USPS Data Set
% Script : usps_KNN.m
% 
% The description of USPS Data Set : 
% 7291 training data and 2007 test data in total.
% 10 Classes : represent 10 digits 
% 257 Attributes : the first column is the class label,
% and the other 256-columns data is a 16*16 handwritten digit image.
% November 10, 2016, by HanzheTeng

clear variables
load uspsdata.mat
Accuracy = zeros(1,10);
RunningTime = zeros(1,10);  % each time needs several minutes

% assign different number to K and see the correct rate
for K=1:10  % the number of neighbors
    tic; 
    % get training and test data
    rand = randperm(7291);
    train = uspstrain(rand,2:257);
    trainlabel = uspstrain(rand,1);
    test = uspstest(:,2:257);
    testlabel = uspstest(:,1);

    % KNN algorithm
    testpredict = alg_KNN(train,trainlabel,test,K);
    
    % compute accuracy
    Accuracy(K) = alg_Accuracy(testpredict,testlabel);
    RunningTime(K) = toc;
end

Accuracy  %#ok<NOPTS>
RunningTime  %#ok<NOPTS> 
if all(Accuracy)==1
    MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>
    TotalTime = sum(RunningTime)  %#ok<NOPTS>
end

%% plot data - K-Nearest Neighbors algorithm on USPS Data Set
figure(1)
usps_imshow(-uspstest(:,2:257),30,80);

figure(2)
bar(Accuracy)
axis([1 10 0.9 1])
title('K-Nearest Neighbor algorithm on USPS Data Set')
xlabel('Parameter K in KNN algorithm')
ylabel('Accuracy')

figure(3)
bar(RunningTime)
title('Running Time(second)')
xlabel('10 Runs')
