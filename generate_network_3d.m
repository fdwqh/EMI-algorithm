function [npoints,enum,edges,points,distMatrix]=generate_network_3d
clc;
%% initialization
npoints=1000;
degree=10;

%% Generate adjacency matrix
enum=0;
while abs(enum/2-degree*npoints)>10
    enum=0;
    radius=0.181*1000;
    points=rand(3,npoints)-0.5;
    points=points';
    points=points*1000;
    Y=pdist(points);
    trueDistMatrix=squareform(Y);
    distMatrix=zeros(npoints,npoints);
    for i=1:npoints
        for j=1:npoints
            if trueDistMatrix(i,j)>radius 
                distMatrix(i,j)=NaN;
            elseif i==j
                distMatrix(i,j)=0;
            else
                distMatrix(i,j)=1;
                enum=enum+1;
            end
        end
    end
    disp(enum/2);
end

%% Generate data files
edges=zeros(enum/2,2);
enumindex=0;
fileID=fopen('3000P\ExpL-VE.txt','w');
formatSpec='%d %d\n';
fprintf(fileID,formatSpec,npoints,enum/2);
for i=1:npoints
    for j=i+1:npoints
        if distMatrix(i,j)==1
            fprintf(fileID,formatSpec,i-1,j-1);
            enumindex=enumindex+1;
            edges(enumindex,1)=i-1;
            edges(enumindex,2)=j-1;
        end
    end
end
fclose(fileID);
fileID=fopen('3000P\ExpL-P.txt','w');
formatSpec='%.2f %.2f %.2f\n';
for i=1:npoints
    fprintf(fileID,formatSpec,points(i,:));
end
fclose(fileID);
