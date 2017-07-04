% K-Nearest Neighbors algorithm on Sonar Data Set
% Script : sonar_KNN.m 
% 
% The description of Sonar Data Set :
% 2 Classes : 1 = Rock(97 samples)   2 = Mine(111 samples)
% 1-60 Attributes : range from 0.0 to 1.0, 
% represent the energy within a particular frequency band.
% 61th Attribute : class label
% November 8, 2016, by HanzheTeng

clear variables
load sonardata.mat
N = 13; % N-fold cross-validation
K = 5; % K nearest neighbors
[sonartrain,sonartest] = alg_CrossValidation(sonardata,N);
Accuracy = zeros(1,N);

for time=1:N
    % get training and test data
    train = sonartrain(:,1:60,time);
    trainlabel = sonartrain(:,61,time);
    test = sonartest(:,1:60,time);
    testlabel = sonartest(:,61,time);
    
    % KNN algorithm
    testpredict = alg_KNN(train,trainlabel,test,K);
    
    % compute accuracy
    Accuracy(time) = alg_Accuracy(testpredict,testlabel);
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>

%% plot data - K-Nearest Neighbors algorithm on Sonar Data Set
% data comes from the Nth validation
figure(1)
mesh(sonardata(:,1:60))
axis([1 60 1 208 0 1])
title('All the Sonar data')
xlabel('Attributes')
ylabel('Samples')

figure(2)
bar(Accuracy)
title('K-Nearest Neighbors algorithm on Sonar Data Set')
xlabel([num2str(N) '-fold cross-validation'])
ylabel('Accuracy')
