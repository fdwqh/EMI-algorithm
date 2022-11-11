function label=IdentifyRigidClusters(N,cutoff,MP1,FLAG)
global R;
label=cell(N,1); %every point may belongs to several rigid clusters
mp=cell(N,1); %mp(u)={v|v and u is mutually rigid}
%% get mp(i)
for i=1:N
    mp{i}=[];
    label{i}=[];
    for j=1:N
        if MP1(i,j)<cutoff && i~=j 
            mp{i}=[mp{i} j];
        end
    end
end
%% get label{i}
R=0;
order=randperm(N);
for inum=1:N
    A=order(inum);
    mA=mp{A};
    nA=length(mA);
    %disp(nA);
    for i=1:nA
        B=mA(i);
        if FLAG==1 && check(label{A},label{B})
            continue;
        end
        mAB=intersect(mA,mp{B});
        nAB=length(mAB);
        %disp(i);
        for j=1:nAB
            C=mAB(j);
            if C==A || C==B
                continue;
            end
            %disp([A B C]);
            % whether A,B,C has been included in the same rigid cluster:
            Processed=check(label{C},label{A},label{B}); 
            %disp(Processed);
            if Processed==1
                continue;
            end
            R=R+1;
            label{A}=[label{A} R];
            label{B}=[label{B} R];
            label{C}=[label{C} R];
            mABC=intersect(mAB,mp{C});
            %disp(mABC);
            nABC=length(mABC);
            for k=1:nABC
                label{mABC(k)}=[label{mABC(k)} R];
            end
        end
    end
end
end
%% check a,b,c same cluster
function ok=check(c,a,b)
ok=0;
if nargin==3
    for k=1:length(c)
        z=c(k);
        for i=1:length(a)
            x=a(i);
            if z==x
                for j=1:length(b)
                    y=b(j);
                    %disp([x,y,z]);
                    if z==y
                        ok=1;
                        return;
                    end
                end
            end
        end
    end
elseif nargin==2
    for z=c
        for x=a
            if z==x
                ok=1;
                return;
            end
        end
    end
end
end