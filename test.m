tic
for x = 1:100
    for dir = 1:2
        for i = 1:2
            q(currNode,currGrp,i,dir) = squeeze(f(currNode,currGrp,i,dir))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,dir))' - squeeze(l(currNode,currGrp,i,dir))';
        end
        for i = 3:4
            q(currNode,currGrp,i,dir) = squeeze(f(currNode,currGrp,i,dir))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,dir))';
        end
    end
end
toc
tic
for x = 1:100
    for dir = 1:2
        for i = 1:4    
                q1(currNode,currGrp,i,dir) = f(currNode,currGrp,i,dir);
            for G = 1:data.ng
                q1(currNode,currGrp,i,dir) = q1(currNode,currGrp,i,dir) + data.XSin(currComp,currGrp,G)*a(currNode,G,i,dir);
            end
        end
        for i = 1:2
            for G = 1:data.ng
                q1(currNode,currGrp,i,dir) = q1(currNode,currGrp,i,dir) - l(currNode,currGrp,i,dir);
            end
        end
    end
end
toc