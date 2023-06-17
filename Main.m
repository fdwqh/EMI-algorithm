function Main
clc;
%% data process
BaseData=load("200P\ExpNew2-VE.txt");
N=BaseData(1,1); %points number
M=BaseData(1,2); %edge number
Edges=BaseData(2:M+1,:);
Points=load("200P\ExpNew2-P.txt");
Points=Points*1000;
% [N,M,Edges,Points,Matrix]=generate_network_3d;

%% mutually rigid vertex pairs
[MP1,cutoff]=IdentifyMutuallyPairs(N,Edges,Points);
% [MP2,cutoff]=IdentifyMutuallyPairs(N,Edges,Points);
% plot_mp(N,MP1,cutoff);
% Match(MP1,MP2,cutoff);

%% rigid cluster
global R;
R=0;
%IsHinge=IdentifyHinges(N,Edges,MutuallyPairs,-4);
tic;
RigidClusters=IdentifyRigidClusters(N,cutoff,MP1,1);
% toc;

%% output
disp(R);
RigidSet=GetRigidSet(N,RigidClusters);

%% find missing clusters
RigidSet=OptimizeREP(N,RigidClusters,RigidSet,MP1,cutoff);
toc;
disp(R);
% ClustersNumber=zeros(1,5);
% Base=N/5;
% for i=1:R
%     num=length(RigidSet{i});
%     if mod(num,Base)==0
%         ClustersNumber(num/Base)=ClustersNumber(num/Base)+1;
%     else
%         ClustersNumber(fix(num/Base)+1)=ClustersNumber(fix(num/Base)+1)+1;
%     end
% end
% disp(ClustersNumber);

% for i=1:R
%     disp(RigidSet{i});
% end

% fileID=fopen('exp1.txt','w');
% for i=1:R
%     for j=1:length(RigidSet{i})
%         fprintf(fileID,"%d ",RigidSet{i}(j));
%     end
%     fprintf(fileID,"\n");
% end
% fclose(fileID);
% 
% AdjacentMatrix=zeros(N,N);
% fileID=fopen('AdjacentMatrix1.txt','w');
% for i=1:M
%     AdjacentMatrix(Edges(i,1)+1,Edges(i,2)+1)=1;
%     AdjacentMatrix(Edges(i,2)+1,Edges(i,1)+1)=1;
% end
% for i=1:N
%     for j=1:N
%         fprintf(fileID,"%d ",AdjacentMatrix(i,j));
%     end
%     fprintf(fileID,"\n");
% end
% fclose(fileID);
% 
% fileID=fopen('DistanceMatrix1.txt','w');
% for i=1:N
%     for j=1:N
%         dis=norm((Points(i)-Points(j))/1000);
%         fprintf(fileID,"%.2f ",dis);
%     end
%     fprintf(fileID,"\n");
% end
% fclose(fileID);
% checkres=Check(N,-4,MutuallyPairs,RigidSet);
% disp(checkres);

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

function plot_mp(N,MP1,cutoff)
Y=zeros(1,N*N);
for i=1:N
    for j=1:N
        Y((i-1)*N+j)=MP1(i,j);
    end
end
scatter(1:N*N,Y,2);
hold on;
disp(cutoff);
plot([1,N*N],[cutoff,cutoff]);
xlabel('Vertices pairs number','FontSize',20);
ylabel('lg(\Delta_i{}_j)','FontSize',20);
end

%% 判断三点共线
function OK=pd_commonline(x,y,z)
a=norm(x-y);
b=norm(x-z);
c=norm(y-z);
p=(a+b+c)/2;
S=(p*(p-a)*(p-b)*(p-c))^1/2;
OK=(S<1e-5);
end