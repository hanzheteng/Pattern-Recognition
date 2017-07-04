% Script : iris_Genetic.m 

load irisdata.mat
% 5-fold cross-validation
[train,test] = alg_CrossValidation(irisdata,5);
Accuracy = zeros(1,5);
RunningTime = zeros(1,5);

for time=1:5
    tic;
    % Genetic Algorithm; Function "Fitness" based on TRAIN data
    Gene = alg_GeneticAlg(train(:,1:4,time),train(:,5,time),40,20,0.3,0.03);

    % Evaluation based on TEST data
    testpredict = alg_KNN(train(:,Gene,time),train(:,5,time),test(:,Gene,time),3);
    
    % compute accuracy and running time 
    Accuracy(time) = alg_Accuracy(testpredict,test(:,5,time));
    RunningTime(time) = toc;
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>
RunningTime  %#ok<NOPTS>
TotalTime = sum(RunningTime)  %#ok<NOPTS>

