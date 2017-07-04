% Fisher's Criterion on Sonar Data Set
% Script : sonar_Fisher.m
% 
% The description of Sonar Data Set :
% 2 Classes : 1 = Rock(97 samples)   2 = Mine(111 samples)
% 1-60 Attributes : range from 0.0 to 1.0, 
% represent the energy within a particular frequency band.
% 61th Attribute : class label
% November 2, 2016, by HanzheTeng

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
    testpredict = zeros(testrow,1);   % label to be predicted

    % one-dimensional projection
    test0 = zeros(testrow,1);
    for i=1:testrow
        test0(i) = W*test(i,:)';
    end

    % generate label for test data
    for i=1:testrow
        if(test0(i)>W0)
            testpredict(i) = 1;
        else
            testpredict(i) = 2;
        end
    end
    Accuracy(time) = alg_Accuracy(testpredict,testlabel);
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>


%% plot data - Fisher's Criterion on Sonar Data Set
% data comes from the Kth validation
train = sonartrain(:,1:60,K);
trainrow = length(train);
train0 = zeros(trainrow,1);
for i=1:trainrow
    train0(i) = W*train(i,:)';
end

figure(1)
mesh(sonardata(:,1:60))
axis([1 60 1 208 0 1])
title('All the Sonar data')
xlabel('Attributes')
ylabel('Samples')

figure(2)
bar(Accuracy)
title('Fisher''s Criterion on Sonar Data Set')
xlabel([num2str(K) '-fold cross-validation'])
ylabel('Accuracy')

figure(3)
subplot(2,1,1)
stem(train0)
title('Project training samples onto W direction')
xlabel('Training samples')
ylabel('Data values')
subplot(2,1,2)
stem(test0)
title('Project test samples onto W direction')
xlabel('Test samples')
ylabel('Data values')
