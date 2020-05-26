%% readXS.m
% Reads cross section data from inputFile

rawInput = fscanf(inputFile,'%f');
readIndex = 1;

% Read number of groups and compositions
data.ng = rawInput(readIndex);
readIndex = readIndex + 1;
data.ncomp = rawInput(readIndex);
readIndex = readIndex + 1;

% For each composition
for comp = 1:data.ncomp
    currComp = rawInput(readIndex);
    readIndex = readIndex + 1;

    % For each group, read XS
    for g = 1:data.ng            
        currGrp = rawInput(readIndex);
        readIndex = readIndex + 1;
        data.D(currComp,currGrp) = rawInput(readIndex);
        data.XSD(currComp,currGrp) = data.D(currComp,currGrp)/h^2;
        readIndex = readIndex + 1;
        data.XSr(currComp,currGrp) = rawInput(readIndex);
        readIndex = readIndex + 1;
        data.XSf(currComp,currGrp) = rawInput(readIndex);
        readIndex = readIndex + 1;
        data.Chi(currComp,currGrp) = rawInput(readIndex);
        readIndex = readIndex + 1;            
    end

    % For each group, read in-scattering XS
    for g = 1:data.ng
        currGrp = rawInput(readIndex);
        readIndex = readIndex + 1;
        for G = 1:data.ng
            % In-scattering XS from g1 to currGrp
            data.XSin(currComp,currGrp,G) = rawInput(readIndex);
            readIndex = readIndex + 1;
        end
    end

end

