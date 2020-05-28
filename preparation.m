function [DL,DU,L,U] = preparation(gamma,d,ng,dim)

    county = dim(1);
    countx = dim(2);
    
    D = zeros(countx,3,county,ng);
    L = zeros(county,countx,ng);
    U = zeros(county,countx,ng);
   
    for g = 1:ng
        index = 1;
        for y = 1:county
            for x = 1:1
                D(x,1,y,g) = d(index,g);
                D(x,3,y,g) = gamma(index,3,g);
                index = index + 1;
            end
            for x = 2:countx-1
                D(x,2,y,g) = gamma(index,2,g);
                D(x,1,y,g) = d(index,g);
                D(x,3,y,g) = gamma(index,3,g);
                index = index + 1;
            end
            for x = countx:countx
                D(x,2,y,g) = gamma(index,2,g);
                D(x,1,y,g) = d(index,g);
                index = index + 1;
            end
        end
    end
    
    
    for g = 1:ng
        index = 1;
        for y = 1:1
            for x = 1:countx
                U(y,x,g) = gamma(index,4,g);
                index = index + 1;
            end
        end
        for y = 2:county-1
            for x = 1:countx
                L(y,x,g) = gamma(index,1,g);
                U(y,x,g) = gamma(index,4,g);
                index = index + 1;
            end
        end
        for y = county:county
            for x = 1:countx
                L(y,x,g) = gamma(index,1,g);
                index = index + 1;
            end
        end
    end
    
    DL = zeros(countx,county,ng);
    DU = zeros(countx,2,county,ng);
    for g = 1:ng
        for y = 1:county
            [D_L,D_U] = LU(D(:,:,y,g));
            DL(:,y,g) = D_L;
            DU(:,:,y,g) = D_U;
        end
    end
    
end

