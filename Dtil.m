
albedo = [0,Inf,0,Inf];
for G=1:data.ng

for i=1:totalNodes
    currComp = node2comp(i);
    betax(i,G)=data.D(currComp,G)/h;
    betay(i,G)=data.D(currComp,G)/h;
end
    
%% x    
Bx=zeros(nodeDim,nodeDim+2,G);
Bx(:,1,G)=0.5*albedo(1);
Bx(:,nodeDim+2,G)=0.5*albedo(2);
for m=1:nodeDim; for n=1:nodeDim
        Bx(m,n+1,G)=betax((m-1)*nodeDim+n,G);
end; end
for m=1:nodeDim; for n=1:nodeDim+1
        Dtilx(m,n,G)=2*Bx(m,n,G)*Bx(m,n+1,G)/(Bx(m,n,G)+Bx(m,n+1,G));
end; end


%% y
By=zeros(nodeDim+2,nodeDim,G);
By(1,:,G)=0.5*albedo(3);
By(nodeDim+2,:,G)=0.5*albedo(4);
for m=1:nodeDim; for n=1:nodeDim
        By(m+1,n,G)=betay((m-1)*nodeDim+n,G);
    end
end
for n=1:nodeDim; for m=1:nodeDim+1
        Dtily(m,n,G)=2*By(m,n,G)*By(m+1,n,G)/(By(m,n,G)+By(m+1,n,G));
end; end
end