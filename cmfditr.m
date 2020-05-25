
for G=1:data.ng

flux=zeros(nodeDim+2,nodeDim+2,G);
for m=1:nodeDim; for n=1:nodeDim
        N=(m-1)*nodeDim+n;
        flux(m+1,n+1)=a0(N,G);
end; end
flux(:,1,G)=flux(:,2,G);
flux(:,nodeDim+2,G)=-flux(:,nodeDim+1,G);
flux(1,:,G)=flux(2,:,G);
flux(nodeDim+2,:,G)=-flux(nodeDim+1,:,G);
    
%% x    
jleft=zeros(nodeDim,nodeDim+1,G);
jright=zeros(nodeDim,nodeDim+1,G);
for j=1:nodeDim
jright(j,1,G)=jout((j-1)*(nodeDim)+1,G,1,1);
end
jleft(:,nodeDim+1,G)=0;

for m=1:nodeDim; for n=1:nodeDim
        N=(m-1)*nodeDim+n;
        jright(m,n)=jout(N,G,2,1);
        jleft(m,n+1)=jout(N,G,1,1);
end; end

for m=1:nodeDim; for n=1:nodeDim+1
    F=flux(m+1,n,G)+flux(m+1,n+1,G);
    Dhatx(m,n,G)=[(jright(m,n,G)-jleft(m,n,G))+Dtilx(m,n,G)*F]/F;
end; end


%% y    
jup=zeros(nodeDim+1,nodeDim,G);
jdown=zeros(nodeDim+1,nodeDim,G);
for i=1:nodeDim
jdown(1,i,G)=jout(i,G,1,1);
end
jup(nodeDim+1,:,G)=0;

for m=1:nodeDim; for n=1:nodeDim
        N=(m-1)*nodeDim+n;
        jdown(m,n)=jout(N,G,2,2);
        jup(m+1,n)=jout(N,G,1,2);
end; end

for m=1:nodeDim+1; for n=1:nodeDim
    F=flux(m,n+1,G)+flux(m+1,n+1,G);
    Dhaty(m,n,G)=[(jdown(m,n,G)-jup(m,n,G))+Dtily(m,n,G)*F]/F;
end; end
end



% matrix