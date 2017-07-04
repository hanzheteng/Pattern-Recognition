% Script : iris_Kmeans.m

load irisdata.mat
K=3;
data = irisdata(:,1:4);
label = irisdata(:,5);
ClusterLabel = kmeans(data,K);
[row,~] = size(data);
match = zeros(row,1);
maxcount=0;

% alg_ClusterAccuracy
K_perm = perms(1:K);
[permrow,~]=size(K_perm);
class = zeros(row,K);
for n=1:K
    class(:,n) = ClusterLabel==n;
end
for i=1:permrow
    for n=1:K
        ClusterLabel(logical(class(:,n)))=K_perm(i,n);
    end
    count = sum(ClusterLabel==label);
    if maxcount<count
        maxcount = count;
    end
end
Accuracy = maxcount/row   %#ok<NOPTS>
