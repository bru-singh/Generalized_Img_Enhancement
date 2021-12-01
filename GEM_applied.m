function [output,C_ori,C_out,NL]=GEM_applied(img, strength, n, L, d)

output=double(img);

[p_k, x_k]=imhist(uint8(img), 256); % getting the histogram of the
                                    % image matrix 
x_k=x_k(p_k>0);
P=p_k(p_k>0);
P=P./sum(P); %PDF of the histogram

s_ori=[x_k(1);x_k(2:end)-x_k(1:end-1)]; %CDF_ori
C_ori=P'*s_ori;
    
dim=length(x_k);
Nabla=[eye(dim-1),zeros(dim-1,1)]-[zeros(dim-1,1),eye(dim-1)];

% solve min ||S/P^strength||_n
if n==2
    S=L.*( P.^(2*strength) )./sum( P.^(2*strength) );
end
if n==3
        S=L.*( P.^(strength) )./sum( P.^(strength) );
end

C_out=sum(P.*S);
NL=norm(Nabla*((S-s_ori)));

% mapping new histogram to out
for i=1:length(P)
    
        T=sum(S(1:i));
    
    output( img==x_k(i) )=T;
end


