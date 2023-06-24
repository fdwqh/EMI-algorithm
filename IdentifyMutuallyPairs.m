function [SumDelta,cutoff]=IdentifyMutuallyPairs(N,Edges,Points)
M=size(Edges,1);
d=3;
SumDelta=zeros(N,N);

for T=1:3
    Points=(rand(N,3)-0.5)*10000;
    RigidMatrix=zeros(M,d*N);
    for i=1:M
        x=Edges(i,1)+1;
        y=Edges(i,2)+1;
        for j=1:d
            RigidMatrix(i,d*(x-1)+j)=Points(x,j)-Points(y,j);
            RigidMatrix(i,d*(y-1)+j)=Points(y,j)-Points(x,j);
        end
    end
    tic;
    GSolution=null(RigidMatrix);
    toc;
    
    Velocity=zeros(d*N,1);
    for i=1:size(GSolution,2)
        k=-1000+rand()*2000;
        Velocity=Velocity+k*GSolution(:,i);
    end
    for i=1:N
        for j=1:N
            vi=zeros(d,1);
            vj=zeros(d,1);
            for k=1:d
                vi(k)=Velocity(d*(i-1)+k);
                vj(k)=Velocity(d*(j-1)+k);
            end
            deltaij=abs((Points(i,:)-Points(j,:))*(vi-vj));
            SumDelta(i,j)=SumDelta(i,j)+deltaij;
        end
    end
end
SumDelta=log10(SumDelta);

cutoff=-1.5;
for i=1:N
    for j=1:N
        if abs(SumDelta(i,j)-cutoff)<1.5
            disp([i j SumDelta(i,j)]);
        end
    end
end
end
