% K-Nearest Neighbor algorithm on Iris Data Set
% Script : iris_KNN.m 
% 
% The description of Iris Data Set :
% 3 Classes of 50 instances each : 1=Iris-setosa  2=Iris-versicolor  3=Iris-virginica
% 5 Attributes : SL,SW,PL,PW,Class
% November 8, 2016, by HanzheTeng

clear variables
load irisdata.mat
N = 5; % N-fold cross-validation
K = 5; % K nearest neighbors
[iristrain,iristest] = alg_CrossValidation(irisdata,N);
CorrectRate = zeros(1,N);

for time=1:N
    % get training and test data
    train = iristrain(:,1:4,time);
    trainlabel = iristrain(:,5,time);
    test = iristest(:,1:4,time);
    testlabel = iristest(:,5,time);
    
    % KNN algorithm
    testpredict = alg_KNN(train,trainlabel,test,K);
    
    % compute correct rate
    CorrectRate(time) = alg_CorrectRate(testpredict,testlabel);
end

CorrectRate  %#ok<NOPTS>
MeanCorrect = mean(CorrectRate)  %#ok<NOPTS>

%% plot data - K-Nearest Neighbor algorithm on Iris Data Set
% data comes from the Nth validation
figure(1)
mesh(irisdata)
axis([1 5 1 150 0 8])
title('All the Iris data')
xlabel('Attributes')
ylabel('Samples')

figure(2)
bar(CorrectRate)
title('K-Nearest Neighbor algorithm on Iris Data Set')
xlabel([num2str(N) '-fold cross-validation'])
ylabel('Correct Rates')
