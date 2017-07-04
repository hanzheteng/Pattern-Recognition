% Fisher's Criterion on Iris Data Set
% Script : iris_Fisher.m 
% 
% The description of Iris Data Set :
% 3 Classes of 50 instances each : 1=Iris-setosa  2=Iris-versicolor  3=Iris-virginica
% 5 Attributes : SL,SW,PL,PW,Class
% 
% Solution for multi-class problem :
% Set decision boundary between every 2 classes.
% November 2, 2016, by HanzheTeng

clear variables
load irisdata.mat
K = 5;   % K-fold cross-validation
[iristrain,iristest] = alg_CrossValidation(irisdata,K);
Accuracy = zeros(1,K);

for time=1:K
    % get training data
    train1 = iristrain(iristrain(:,5,time)==1,1:4,time);
    train2 = iristrain(iristrain(:,5,time)==2,1:4,time);
    train3 = iristrain(iristrain(:,5,time)==3,1:4,time);
    
    % Fisher's Criterion 
    [W12,W012] = alg_Fisher(train1,train2);
    [W13,W013] = alg_Fisher(train1,train3);
    [W23,W023] = alg_Fisher(train2,train3);
    
    % get test data
    test = iristest(:,1:4,time);
    [testrow,~] = size(test);
    testlabel = iristest(:,5,time);  % real label
    testpredict = zeros(testrow,1);  % label to be predicted
    
    % one-dimensional projection
    test12 = zeros(testrow,1);   
    test13 = zeros(testrow,1);   
    test23 = zeros(testrow,1);
    for i=1:testrow
        test12(i) = W12*test(i,:)';
        test13(i) = W13*test(i,:)';
        test23(i) = W23*test(i,:)';
    end
    
    % Solution for multi-class problem : 
    % set decision boundary between every 2 classes
    for i=1:testrow
        if(test12(i)>W012 && test13(i)>W013)
            testpredict(i) = 1;
        end
        if(test12(i)<W012 && test23(i)>W023)
            testpredict(i) = 2;
        end
        if(test13(i)<W013 && test23(i)<W023)
            testpredict(i) = 3;
        end
    end
    Accuracy(time) = alg_Accuracy(testpredict,testlabel);
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy) %#ok<NOPTS>


%% plot data - Fisher's Criterion on Iris Data Set
% data comes from the Kth validation
train = iristrain(:,1:4,K);
trainrow = length(train);
train12 = zeros(trainrow,1);
train13 = zeros(trainrow,1);
train23 = zeros(trainrow,1);
for i=1:trainrow
    train12(i) = W12*train(i,:)';
    train13(i) = W13*train(i,:)';
    train23(i) = W23*train(i,:)';
end

figure(1)
mesh(irisdata)
axis([1 5 1 150 0 8])
title('All the Iris data')
xlabel('Attributes')
ylabel('Samples')

figure(2)
bar(Accuracy)
title('Fisher''s Criterion on Iris Data Set')
xlabel([num2str(K) '-fold cross-validation'])
ylabel('Accuracy')

figure(3)
subplot(3,1,1)
stem(train12);
title('Project training data onto W12 direction')
xlabel('Training Samples')
ylabel('Data values')
subplot(3,1,2)
stem(train13);
title('Project training data onto W13 direction')
xlabel('Training Samples')
ylabel('Data values')
subplot(3,1,3)
stem(train23);
title('Project training data onto W23 direction')
xlabel('Training Samples')
ylabel('Data values')

figure(4)
subplot(3,1,1)
stem(test12);
title('Project test data onto W12 direction')
xlabel('Test Samples')
ylabel('Data values')
subplot(3,1,2)
stem(test13);
title('Project test data onto W13 direction')
xlabel('Test Samples')
ylabel('Data values')
subplot(3,1,3)
stem(test23);
title('Project test data onto W23 direction')
xlabel('Test Samples')
ylabel('Data values')
