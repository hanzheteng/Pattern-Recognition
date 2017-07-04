% Script : sonar_Kmeans.m

load sonardata.mat
K=2;
data = sonardata(:,1:60);
label = sonardata(:,61);
ClusterLabel = alg_Kmeans(data,K);
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
