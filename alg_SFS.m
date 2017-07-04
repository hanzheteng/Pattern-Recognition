function [X,Fits] = alg_SFS(data,label)
%alg_SFS   Sequential Forward Selection
%
%   [X,FITS] = alg_SFS(DATA,LABEL)
%   returns a vector and its fitness.
%
%   SFS for feature selection
%   November 21, 2016, by HanzheTeng

[datarow,datacol]=size(data);
[labelrow,labelcol]=size(label);
if datarow~=labelrow
    error('DATA and DATA_LABEL must have the same number of rows.');
end
if labelcol~=1
    error('DATA_LABEL must have only one column.');
end

testrow = randperm(datarow,ceil(datarow/10));
test = data(testrow,:);
testlabel = label(testrow);
data(testrow,:) = [];
label(testrow,:) = [];

X= false(1,datacol);
Fits=zeros(datacol,2);

for i=1:datacol
    X(i)=1;
    Fits(i,2)=i;
    Fits(i,1)=Fitness(data,label,test,testlabel,X);
    X(i)=0;
end
Fits = sortrows(Fits,1);
X(Fits(datacol,2))=1;
for j=1:19
    for i=1:datacol
        if X(i)~=1;
            X(i)=1;
            Fits(i,1)=Fitness(data,label,test,testlabel,X);
            X(i)=0;
        end
    end
    Fits = sortrows(Fits,1);
    X(Fits(datacol,2))=1;
end
end

% Fitness Function
function accuracy = Fitness(train,trainlabel,test,testlabel,Gene)
    % Fitness based on accuracy
    testpredict = alg_KNN(train(:,Gene),trainlabel,test(:,Gene),3);
    accuracy = alg_Accuracy(testpredict,testlabel);
end
