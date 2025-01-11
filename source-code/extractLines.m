clc;
clear;
k = [1 -1 1
1 1 1
-1 -1 1
-1 1 1
-1 -1 -1
-1 1 -1
1 -1 -1
1 1 -1];

count = 1;
for i = 1:size(k,1)/2
    p(i,:) = k(count,:);
    q(i,:) = k(count+1,:);
    count = count+2;
end