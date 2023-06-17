function [npoints,enum,edges,points,distMatrix]=generate_network_3d
clc;
%% initialization
npoints=1000;
degree=10;

%% 生成邻接矩阵
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
            if trueDistMatrix(i,j)>radius % 大于测距半径
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

%% 生成数据文件
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
%% 画图
% disp(enum/2);
% for i=1:npoints
%     plot3(points(i,1),points(i,2),points(i,3));
%     hold on;
%     for j=1:npoints
%         if distMatrix(i,j)==1
%             plot3([points(i,1),points(j,1)],[points(i,2),points(j,2)],[points(i,3),points(j,3)],'Color',[0,0,0]);
%             hold on;
%         end
%     end
% end
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

% points=zeros(npoints,3);
% for times=1:npoints
%     OK=0;
%     while(~OK)
%         points(times,:)=-500+1000*[rand() rand() rand()];
%         OK=1;
%         for i=1:times-1
%             for j=i+1:times-1
%                 if pd_commonline(points(i,:),points(j,:),points(times,:))
%                     OK=0;
%                     break;
%                 end
%             end
%             if ~OK
%                 break;
%             end
%         end
%     end
% end