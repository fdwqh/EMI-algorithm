function rigidSet=OptimizeREP(N,rigidLabel,rigidSet,MP1,cutoff)
global R;
%% get mp(i)
mp=cell(N,1);
for i=1:N
    mp{i}=[];
    for j=1:N
        if MP1(i,j)<cutoff && i~=j 
            mp{i}=[mp{i} j];
        end
    end
end
%% 建图
keys=1:N;
values=zeros(1,N);
use=containers.Map(keys,values);
newPoints=[]; %新点集
n=0; %新顶点数
for i=1:N
    if length(rigidLabel{i})<2 %只在一个集群里的点
        continue;
    else
        use(i)=1;
        n=n+1;
        newPoints=[newPoints i];
    end
end
%disp(newPoints);
newMatrix=zeros(N,N); %新邻接矩阵
Ng=cell(1,N); %新邻接表
for i=1:R
    for j=rigidSet{i}
        for k=rigidSet{i}
            if ~use(j) || ~use(k) || j==k
                continue;
            end
            if newMatrix(j,k)==0
                Ng{j}=[Ng{j} k]; %构造邻接表
            end
            newMatrix(j,k)=1;
        end
    end
end
%disp(newMatrix);
%for i=1:N
%    disp(Ng{i});
%end
%% 计算可能遗漏的三点集群
for A=newPoints
    boolRgA=containers.Map(1:R,zeros(1,R)); % A所在的集群
    for I=rigidLabel{A}
        boolRgA(I)=1;
    end
    intRNgA=cell(1,R); % A的邻居【不同于A的集群的】【顶点编号】
    for B=Ng{A}
        for I=rigidLabel{B}
            if boolRgA(I) % 不能要A在的集群
                continue;
            end
            %disp([B I]);
            for J=intRNgA{I}
                %disp([A B J]);
                if(~check(rigidLabel{A},rigidLabel{B},rigidLabel{J}))
                    R=R+1;
                    rigidLabel{A}=[rigidLabel{A} R];
                    rigidLabel{B}=[rigidLabel{B} R];
                    rigidLabel{J}=[rigidLabel{J} R];
                    mAB=intersect(mp{A},mp{B});
                    mABJ=intersect(mAB,mp{J});
                    rigidSet{R}=union([A B J],mABJ);
                    nABJ=length(mABJ);
                    for k=1:nABJ
                        rigidLabel{mABJ(k)}=[rigidLabel{mABJ(k)} R];
                    end
                end
            end
            intRNgA{I}=[intRNgA{I} B];
            %disp(intRNgA{I});
        end
    end
end
end

function ok=check(a,b,c)
ok=0;
for x=a
    for y=b
        if x==y
            for z=c
                if z==x
                    ok=1;
                    return;
                end
            end
        end
    end
end
end