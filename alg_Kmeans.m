function KLabel=alg_Kmeans(data,K)
%alg_Kmeans   K-means Clustering Algorithm
%
%   KLABEL = alg_Kmeans(DATA,K)
%   returns a column vector containing labels.
%
%   By default, kmeans uses squared Euclidean distances.
%   December 2, 2016, by HanzheTeng

[row,col] = size(data);
center = data(randperm(row,K),:);  % select K cluster centers randomly
center_last = zeros(K,col);
KLabel = zeros(row,1);
while any(any(center_last~=center))  % if any center does not equal, go on
    center_last = center;
    for i=1:row
        distance = zeros(1,K);
        for n=1:K
            % compute the 2-norm or Euclidean distance
            distance(n) = norm(data(i,:)-data(n,:));
        end
        KLabel(i) = find(distance==min(distance));
    end
    for n=1:K
        center(n,:) = mean(data(KLabel==n,:));
    end
end
