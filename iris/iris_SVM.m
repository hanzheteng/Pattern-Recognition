% Script : iris_SVM.m

clear variables
load irisdata.mat
N=5; 
[iristrain,iristest]=alg_CrossValidation(irisdata,N);
Accuracy=zeros(1,N);

for time=1:N
    % get training and test data
	train=iristrain(1:80,1:4,time);
	trainlabel=iristrain(1:80,5,time);
	test=iristest(1:20,1:4,time);
	testlabel=iristest(1:20,5,time);
    
    % SVM
    model = svmtrain(train,trainlabel);
    predict = svmclassify(model,test);
    Accuracy(time) = alg_Accuracy(predict,testlabel);
end

Accuracy  %#ok<NOPTS>
