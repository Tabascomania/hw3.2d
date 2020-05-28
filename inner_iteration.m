function [phi,nin] = new_in(DL,DU,L,U,phi,b,omega,dim,ninmax)

    nin = 0;
    county = dim(1);
    countx = dim(2);
    
    Lphi = reshape(phi,[county,countx]);
    Lb = reshape(b,[county,countx]);
    
    while nin <= ninmax
        
        Lphi_old = Lphi;
        
        
        for index = 1:county
            RHS = Lb(index,:);
            if index > 1
                RHS = RHS - L(index,:).*Lphi(index-1,:);
            end
            if index < county
                RHS = RHS - U(index,:).*Lphi(index+1,:);
            end
            Lphi(index,:) = solveLU(DL(:,index),DU(:,:,index),RHS');
            Lphi(index,:) = omega * Lphi(index,:) + (1-omega) * Lphi_old(index,:);
        end
        
        nin = nin + 1;               
        
    end
    phi = reshape(Lphi,[county*countx,1]);

end

