function test_predict = alg_KNN(train,train_label,test,K)
%alg_KNN   K-Nearest Neighbors Algorithm
%   
%   TEST_PREDICT = alg_KNN(TRAIN,TRAIN_LABEL,TEST,K)
%   returns a column vector containing labels.
%   
%   K is the number of the nearest neighbors.
%   TRAIN and TRAIN_LABEL must have the same number of rows.
%   TRAIN and TEST must be matrices with the same number of columns.
%   TRAIN_LABEL must have only one column.
%   Rows represent samples.
%   Columns represent the dimensions of samples.
%   This algorithm is based on Euclidean distance.
%   November 8, 2016, by HanzheTeng

[trainrow,traincol] = size(train);
[testrow,testcol] = size(test);
[labelrow,labelcol] = size(train_label);
if traincol~=testcol
    error('TRAIN and TEST must be matrices with the same number of columns.');
end
if trainrow~=labelrow
    error('TRAIN and TRAIN_LABEL must have the same number of rows.');
end
if labelcol~=1
    error('TRAIN_LABEL must have only one column.');
end

label = unique(train_label);
[labelnum,~] = size(label);
test_predict = zeros(testrow,1);

for i=1:testrow
    % find K-nearest neighbors
    knn = zeros(K,2);
    for j=1:K
        distance = norm(train(j,:)-test(i,:));
        knn(j,1) = distance;
        knn(j,2) = train_label(j,1);
    end
    knn = sortrows(knn,1);  % in ascending order
    for j=K+1:trainrow
        distance = norm(train(j,:)-test(i,:));
        if distance<knn(K,1)
            knn(K,1) = distance;
            knn(K,2) = train_label(j,1);
            knn = sortrows(knn,1); 
        end
    end
    % classification decision
    labelcount = [label zeros(labelnum,1)];
    for n=1:K
        for m=1:labelnum
            if knn(n,2)==labelcount(m,1)
                labelcount(m,2) = labelcount(m,2)+1;
                break
            end
        end
    end
    labelcount = sortrows(labelcount,2); 
    test_predict(i,1) = labelcount(labelnum,1);
end

end % End of function alg_KNN

% function "norm" is faster than my code   - Dec 3, 2016
% distance = 0;
% for d=1:traincol
%     distance = distance+(train(j,d)-test(i,d))^2;  
% end