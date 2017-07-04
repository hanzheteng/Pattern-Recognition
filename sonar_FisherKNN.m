% Fisher's Criterion & K-Nearest Neighbors algorithm on Sonar Data Set
% Script : sonar_FisherKNN.m
% 
% The description of Sonar Data Set :
% 2 Classes : 1 = Rock(97 samples)   2 = Mine(111 samples)
% 1-60 Attributes : range from 0.0 to 1.0, 
% represent the energy within a particular frequency band.
% 61th Attribute : class label
% November 18, 2016, by HanzheTeng

clear variables
load sonardata.mat 
K = 13; % 208 cases are divided randomly into 13 disjoint sets
[sonartrain,sonartest] = alg_CrossValidation(sonardata,K);
Accuracy = zeros(1,K); 

for time=1:K
    % get training data
    train1 = sonartrain(sonartrain(:,61,time)==1,1:60,time);
    train2 = sonartrain(sonartrain(:,61,time)==2,1:60,time);
    
    % Fisher's Criterion
    [W,W0] = alg_Fisher(train1,train2);
    
    % get test data
    test = sonartest(:,1:60,time);
    [testrow,~] = size(test);
    testlabel = sonartest(:,61,time); % real label

    % one-dimensional projection
    test0 = zeros(testrow,1);
    for i=1:testrow
        test0(i) = W*test(i,:)';
    end
    [trainrow,~] = size(sonartrain);
    train0 = zeros(trainrow,1);
    for i=1:trainrow
        train0(i) = W*sonartrain(i,1:60,time)';
    end
    
    % KNN algorithm
    testpredict = alg_KNN(train0,sonartrain(:,61,time),test0,K);
    
    % compute accuracy
    Accuracy(time) = alg_Accuracy(testpredict,testlabel);
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>
