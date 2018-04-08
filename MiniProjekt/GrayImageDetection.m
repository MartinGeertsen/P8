
% Import image, and grayscale the image
RGB = imread('Lenna1.jpg'); % Insert your own image here
I = rgb2gray(RGB);

% Step 1, Determine the reference sequence and comparative sequence
I = double(I); %Convert the image into double (decimal data type)
K0 = I(1,:);

K1 = I;
[m,n]=size(I); % Size of image

K00=K0/K0(1);

% Step 2, Data initialization
for ii = 1:m
    for jj = 1:n
        K11(ii,jj)=K1(ii,jj)/K1(ii,1);
    end
end

% Step 3, Calculate the absolute correlation coefficient between K0 and K1 using the following equation
for ii = 1:m-1
    for jj = 1:n-1
        r(ii,jj)=1/(1+abs((K00(jj+1)-K00(jj))-(K11(ii,jj+1)-K11(ii,jj))));
    end
end

% Step 4, Calculating the degree of absolute correlation coefficient using the following equation:
R = (1/(n-1))*sum(r);

% B, Grey Correlation Degree Image. (Neighborhood mean calculation)
for ii = 2:m-1
    for jj = 2:n-1
        K1b(ii,jj)= (I(ii,jj)+I(ii,jj+1)+I(ii+1,jj+1)+I(ii+1,jj-1)+I(ii+1,jj)+I(ii-1,jj)+I(ii-1,jj+1)+I(ii,jj-1)+I(ii-1,jj-1))/9;
    end
end
TempK1BR = R.*K1b-floor(R.*K1b); % To make matrix R, the mean of the starting image was scaled with R.

% C, Adaptive Threshold Calculation Based on Human Visual Characteristics
syms y(x)
cond = y(80) == 0;
ode = diff(y,x)-(3*y/x)+30 == 0;
ySol(x) = dsolve(ode,cond);
ode2 = diff(y,x)-(3*y/x)+0.081397*x-3.325108 == 0;
ySol2(x) = dsolve(ode2,cond);
ode3 = diff(y,x)-(2*y/x)+0.003193*x^2-595.896710 == 0;
ySol3(x) = dsolve(ode3,cond);
for ii = 1:m-1
    for jj = 1:n-1
        if K1b(ii,jj) < 48
            %%1 x?[0,48]
            TempT = ySol(K1b(ii,jj));
            T(ii,jj) = TempT;
        elseif K1b(ii,jj) > 48 && K1b(ii,jj) < 206
            %%2 x?[48,206]
            TempT = ySol2(K1b(ii,jj));
            T(ii,jj) = TempT;
        else
            %%3 x?[206,255]
            TempT = ySol3(K1b(ii,jj));
            T(ii,jj) = TempT;
        end
    end
end
T = double(T); % Tranfrom into a variable that is workable for the rest of the code


% Final threshold matrix
for ii = 1:m-1
    for jj = 1:n-1
        if T(ii,jj) == 1
            T1(ii,jj) = T(ii,jj);
        else
            T1(ii,jj) = T(ii,jj)-floor(T(ii,jj));
        end
    end
end

% D, Edge Extraction
% I1 = edge pixel
I1 = TempK1BR < T1;

% E, Eliminating Isolated Pixel
% Step 1 Erosion
for ii = 2:m-2
    for jj = 2:n-2
        TempI= I1(ii,jj)+I1(ii,jj+1)+I1(ii+1,jj+1)+I1(ii+1,jj-1)+I1(ii+1,jj)+I1(ii-1,jj)+I1(ii-1,jj+1)+I1(ii,jj-1)+I1(ii-1,jj-1);
        if TempI >= 1
            Z(ii,jj) = 1;
        else
            Z(ii,jj) = 0;
        end
    end
end

% Step 2 Dilation
for ii = 2:m-3
    for jj = 2:n-3
        if Z(ii,jj) == 0
            TempZ= Z(ii,jj)+Z(ii,jj+1)+Z(ii+1,jj+1)+Z(ii+1,jj-1)+Z(ii+1,jj)+Z(ii-1,jj)+Z(ii-1,jj+1)+Z(ii,jj-1)+Z(ii-1,jj-1);
            if TempZ <= 3
                Z1(ii,jj) = 0;
                Z1(ii,jj+1) = 0;
                Z1(ii+1,jj+1)= 0;
                Z1(ii+1,jj-1)=0;
                Z1(ii+1,jj)=0;
                Z1(ii-1,jj)=0;
                Z1(ii-1,jj+1)=0;
                Z1(ii,jj-1)=0;
                Z1(ii-1,jj-1)=0;
            end
        else
            Z1(ii,jj) = 1;
        end
    end
end






