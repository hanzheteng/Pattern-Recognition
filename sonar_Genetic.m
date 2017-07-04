% Script : sonar_Genetic.m 

load sonardata.mat
% 13-fold cross-validation
[train,test] = alg_CrossValidation(sonardata,13);
Accuracy = zeros(1,13);
RunningTime = zeros(1,13);

for time=1:13
    tic;
    % Genetic Algorithm; Function "Fitness" based on TRAIN data
    Gene = alg_GeneticAlg(train(:,1:60,time),train(:,61,time),40,20,0.3,0.03);

    % Evaluation based on TEST data
    testpredict = alg_KNN(train(:,Gene,time),train(:,61,time),test(:,Gene,time),3);
    
    % compute accuracy and running time 
    Accuracy(time) = alg_Accuracy(testpredict,test(:,61,time));
    RunningTime(time) = toc;
end

Accuracy  %#ok<NOPTS>
MeanAccuracy = mean(Accuracy)  %#ok<NOPTS>
RunningTime  %#ok<NOPTS>
TotalTime = sum(RunningTime)  %#ok<NOPTS>

