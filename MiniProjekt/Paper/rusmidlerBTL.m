%Preference tree opgave
% Perceived health risk of drug
% N=48
M=[
0 28 35 10 4 7
20 0 18 2 0 3
13 30 0 3 1 0
38 46 45 0 1 17
44 48 47 47 0 44
41 45 48 31 4 0];

%Rusmidler: 
%Alc Tob Can Ecs Her Coc

P = M/48;
WST=0;
MST=0;
SST=0;
it=0;

for a=1:6
    for b=1:6
        for c=1:6
            it = it+1;
            if a~=b && b~=c && a~=c
                if P(a,b)>=0.5 && P(b,c)>=0.5
                    if P(a,c)<0.5
                        WST=WST+1;
                    end
                    if P(a,c)<min(P(a,b),P(b,c))
                        MST=MST+1;
                    end
                    if P(a,c)<max(P(a,b),P(b,c))
                        SST=SST+1;
                    end
                end
            end
        end
    end
end

A = {[1];[2];[3];[4];[5];[6]};

[pModel,chistat,u,lL_eba,lL_sat,fit,cova] = fOptiPt(M,A);
err = 1.96*sqrt(diag(cova));
X = [1 2 3 4 5 6];
errorbar(u,err,'o');
set(gca,'xtick',[1:6],'xticklabel',{'Alc','Tob','Can','Ecs','Her','Coc'});