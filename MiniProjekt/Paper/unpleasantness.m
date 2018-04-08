P = M/60;
WST=0;
MST=0;
SST=0;
it=0;

for a=1:10
    for b=1:10
        for c=1:10
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

A = {[1];[2];[3];[4];[5];[6];[7];[8];[9];[10]};

[pModel,chistat,u,lL_eba,lL_sat,fit,cova] = fOptiPt(M,A);


err = 1.96*sqrt(diag(cova))
% plot errorbar
X = [1 2 3 4 5 6 7 8 9 10];
errorbar(X,u,err,'o')
set(gca,'xtick',[1:10],'xticklabel',{'Truck','Brake','Train','Water','Boat','Jackhammer','Mower','Crash','Mixer','Vent'});