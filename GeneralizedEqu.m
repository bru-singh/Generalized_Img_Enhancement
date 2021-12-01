
function [output, C_ori,C_out, NL, Ratio]=GeneralizedEqu(img, mode, n, strength, WB, d)

%if mode=RGB, we use 3 channels and not the intensity channel
if strcmp(mode, 'RGB')

    Level=size(img,3); % getting the size of the img
                       % in the third dimension
    P=cell(Level,1);   % making array of
                       % length=level
    X=cell(Level,1);

    for i=1:Level
        tmp=img(:,:,i); % tmp defines all the rows and
                        % coloum in the i-th page of
                        % the 3rd dimension

        [P{i},X{i}]=imhist(tmp);
        % getting the histogram of the martix 
        % where P() is the cmap/count
        % and X() is the bin location

        P{i}=P{i}./sum(P{i}); % PDF
        index=find(P{i}~=0);
        tmp=X{i};
        L(i)=tmp(index(end));
        %L(i)~=0
    end
    
    for i=1:Level
        index=find(P{i}~=0);
        tmp=X{i};
        L(i)=tmp(index(end))./( sqrt(3)*( L(i)./norm(L,2) ) );
        % deviding each element of tmp with the corresponding
        % element of the equation 
           
    end
    L=255.*L./max(L);
    % We get the value of L for GEM
    for i=1:Level
        [output(:,:,i),C_ori(i),C_out(i),NL(i)]=GEM_applied(img(:,:,i), strength, n, L(i), d);
    end
    % the ratio of contrast gain with the
    % non-liniarity of the curve
    Ratio=(NL.^25)./abs((C_out/C_ori)-1);
    
end
    
    
    
    
    
