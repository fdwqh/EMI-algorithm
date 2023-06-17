function Main
clc;
%% data process
BaseData=load("Exp1-VE.txt");
N=BaseData(1,1); %points number
M=BaseData(1,2); %edge number
Edges=BaseData(2:M+1,:);
Points=load("Exp1-P.txt");
Points=Points*1000;
% [N,M,Edges,Points,Matrix]=generate_network_3d;

%% mutually rigid vertex pairs
[MP1,cutoff]=IdentifyMutuallyPairs(N,Edges,Points);

%% rigid cluster
global R;
R=0;
RigidClusters=IdentifyRigidClusters(N,cutoff,MP1,1);

%% output
disp(R);
RigidSet=GetRigidSet(N,RigidClusters);

%% find missing clusters
RigidSet=OptimizeREP(N,RigidClusters,RigidSet,MP1,cutoff);
disp(R);

for i=1:R
    disp(RigidSet{i});
end

%% 做图
ShowGraph(N,Edges,RigidClusters,RigidSet,Points);
end

function RigidSet=GetRigidSet(N,RigidClusters)
global R;
RigidSet=cell(1,2*R); %RigidSet{i} represents points in rigid cluster i
for i=1:N
    for k=RigidClusters{i}
        RigidSet{k}=[RigidSet{k} i];
    end
end
end

scatter(1:N*N,Y,2);
hold on;
disp(cutoff);
plot([1,N*N],[cutoff,cutoff]);
xlabel('Vertices pairs number','FontSize',20);
ylabel('lg(\Delta_i{}_j)','FontSize',20);
end
