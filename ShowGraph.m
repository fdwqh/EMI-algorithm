function ShowGraph(N,Edge,RigidClusters,RigidSet,Points)
global R;
line_color=cell(1,R);
for i=1:R
    line_color{i}=[rand() rand() rand()];
end
%disp(line_color);
%% 画点
% for i=1:N
%     plot3(Points(i,1),Points(i,2),Points(i,3),'o','Color',[0,0,0],'MarkerSize',8,'MarkerFaceColor',[0,0,0]);
% end
% for i=1:R
%     for j=RigidSet{i}
%         plot3(Points(j,1),Points(j,2),Points(j,3),'o','Color',line_color{i},'MarkerSize',8,'MarkerFaceColor',line_color{i});
%         hold on;
%     end
% end

%% 画边
M=size(Edge,1);
IsHinge=zeros(M,1);
for i=1:M
    u=Edge(i,1)+1;
    v=Edge(i,2)+1;
    % length(RigidClusters{u})
    ok=0;
    for j=1:size(RigidClusters{u},2)
        for k=1:size(RigidClusters{v},2)
            rigid_j=RigidClusters{u}(j);
            rigid_k=RigidClusters{v}(k);
            if rigid_j==rigid_k
                ok=1;
                plot3([Points(u,1),Points(v,1)],[Points(u,2),Points(v,2)],[Points(u,3),Points(v,3)],'color',line_color{rigid_j},'LineWidth',1.5);
                hold on;
                IsHinge(i)=IsHinge(i)+1;
            end
        end
    end
    if ok==0
        plot3([Points(u,1),Points(v,1)],[Points(u,2),Points(v,2)],[Points(u,3),Points(v,3)],'color',[0.8 0.8 0.8],'LineWidth',3);
    end
end
for i=1:M
    if IsHinge(i)>1
        u=Edge(i,1)+1;
        v=Edge(i,2)+1;
        plot3([Points(u,1),Points(v,1)],[Points(u,2),Points(v,2)],[Points(u,3),Points(v,3)],'color','k','LineStyle','--','LineWidth',2);
    end
end
end