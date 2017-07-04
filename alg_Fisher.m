function [W,W0] = alg_Fisher(class1,class2)
%alg_Fisher   Linear Discriminant Analysis based on Fisher's Criterion
%   
%   [W,W0] = alg_Fisher(CLASS1,CLASS2)
%   returns an eigenvector W along the optimal projective direction
%   and a value W0 as the threshold.
%   
%   CLASS1 and CLASS2 must be matrices with the same number of columns.
%   Rows represent samples.
%   Columns represent the dimensions of samples.
%   November 2, 2016, by HanzheTeng

[row1,col1] = size(class1);
[row2,col2] = size(class2);
if col1~=col2
    error('CLASS1 and CLASS2 must be matrices with the same number of columns.');
end

% compute the mean vectors
m1 = mean(class1);
m2 = mean(class2);

% compute the within-class scatter matrices
S1 = zeros(col1);
S2 = zeros(col1);
for i=1:row1
    S1 = S1+(class1(i,:)-m1)'*(class1(i,:)-m1);
end
for i=1:row2
    S2 = S2+(class2(i,:)-m2)'*(class2(i,:)-m2);
end

% compute the pooled within-class scatter matrix
Sw = S1+S2;

% compute the between-class scatter matrix
% Sb = (m1-m2)'*(m1-m2);
% Acturally Sb is not used in the following steps.

% compute the optimal eigenvector W and the threshold W0
W = (m1-m2)/Sw;
W0 = (row1*W*m1'+row2*W*m2')/(row1+row2);  % different amount of samples

end  % End of function alg_Fisher

% Fisher's Criterion for multi-class problem
% m=mean([m1;m2;m3;...])
% Sw=S1+S2+S3+...
% Sb=(m1-m)'*(m1-m)+(m2-m)'*(m2-m)+(m3-m)'*(m3-m)+...
% [V,D]=eig(Sw\Sb);
% then project onto the hyperplane defined by the first k eigenvectors,
% the parameter k differs from problem to problem.
