function accuracy = alg_Accuracy(predict,label)
%alg_Accuracy computes classification accuracy
%
%   ACCURACY = alg_Accuracy(PREDICT,LABEL)
%   returns the value of accuracy.
%
%   PREDICT and LABEL must be a column vector with the same number of rows.
%   November 2, 2016, by HanzheTeng

[predictrow,predictcol] = size(predict);
[labelrow,labelcol] = size(label);
if predictrow~=labelrow
    error('PREDICT and LABEL must have the same number of rows.');
end
if predictcol~=1
    error('PREDICT must be a column vector.');
end
if labelcol~=1
    error('LABEL must be a column vector.');
end
% compute accuracy
count = 0;
for i=1:predictrow
    if predict(i,1)==label(i,1);
        count = count+1;
    end
end
accuracy = count/predictrow;

end  % End of function alg_Accuracy
