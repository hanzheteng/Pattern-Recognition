function [train,test] = alg_CrossValidation(data,K)
%alg_CrossValidation generates K-fold cross-validation data
%   
%   [TRAIN,TEST] = alg_CrossValidation(DATA,K)
%   returns matrices with K pages for training and testing in a K-fold
%   cross-validation.
%   
%   The row number of DATA must be divisible by K.
%   This algorithm extracts samples from DATA every K rows.
%   You can use one page of TRAIN/TEST for each validation.
%   Rows represent samples.
%   Columns represent the dimensions of samples.
%   November 2, 2016, by HanzheTeng

[row,col] = size(data);
testrow = row/K;
if testrow~=fix(testrow)
    error('The row number of DATA must be divisible by K.');
end
test = zeros(testrow,col,K);
train = zeros(row-testrow,col,K);

for i=1:K
    flag = ones(row,1); % flag matrix
    trainrow = 1; 
    for j=1:testrow
        test(j,:,i) = data(K*j-K+i,:);
        flag(K*j-K+i,1) = 0;
    end
    for j=1:row
        if(flag(j)==1)
            train(trainrow,:,i) = data(j,:);
            trainrow = trainrow+1;
        end
    end
end

end % End of function alg_CrossValidation
