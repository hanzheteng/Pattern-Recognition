% Script : sonar_SVM.m

clear variables
load sonardata.mat
N=8; 
[sonartrain,sonartest]=alg_CrossValidation(sonardata,N);
Accuracy=zeros(1,N);

for time=1:N
    % get training and test data
    train=sonartrain(:,1:60,time);
    trainlabel=sonartrain(:,61,time);
    test=sonartest(:,1:60,time);
    testlabel=sonartest(:,61,time);
    
    % SVM
    model = svmtrain(train,trainlabel);
    predict = svmclassify(model,test);
    Accuracy(time) = alg_Accuracy(predict,testlabel);
end

Accuracy  %#ok<NOPTS>
