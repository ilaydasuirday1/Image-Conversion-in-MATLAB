A=imread('apple.jpg');

subplot(4,2,1)
% Display the original image
imshow(A);
title('Original Image');

B = counterclock(A);
% Display the counter clock image
subplot(4,2,2)
imshow(B);
title('Counter Clock');

C = counterclockwise(A);
% Display the counter clock wise image
subplot(4,2,3)
imshow(C);
title('Counter Clock Wise');


D = horizantally(A);
% Display the flipped image
subplot(4,2,4)
imshow(D); 
title('Horizantally flipped image');


E = vertically(A);
% Display the vertically flipped image
subplot(4,2,5)
imshow(E); 
title('Vertically flipped image');

G = resize(A);
% Display the resized image
subplot(4,2,7);
imshow(G);
title("Resized Image");

F = negative(A);
% Display the negative image
subplot(4,2,6)
imshow(F);
title("Negative Image");

G = resize(A);
% Display the resized image
subplot(4,2,7);
imshow(G);
title("Resized Image");

function C = counterclockwise(A)

x1=zeros([size(A,1)*size(A,2) 1]);
x2=zeros([size(A,2)*size(A,1) 1]);

%Specify the degree
deg=90;
%Change the image size
C=uint8(zeros([size(A,1) size(A,2) 3 ]));

m=1;
midx=ceil((size(C,1)+1)/2);
midy=ceil((size(C,2)+1)/2);

for i=1:size(A,1)
    i1=i-midx;
    for j=1:size(A,2)
        [t,r]=cart2pol(i1,j-midy);
        t1=rad2deg(t)+deg;
        t=deg2rad(t1);
        [x,y]=pol2cart(t,r);
        x1(m)=round(x+midx);
        x2(m)=round(y+midy);
       
        m=m+1;  
    end
   
end

n=1;
for i=1:size(A,1)
    for j=1:size(A,2)
        C(x1(n),x2(n),:)=A(i,j,:);
       
        n=n+1;
    end  
end

end


function B = counterclock(A)
x1=zeros([size(A,1)*size(A,2) 1]);
x2=zeros([size(A,2)*size(A,1) 1]);

%Specify the degree
deg=-90;
%Change the image size
B=uint8(zeros([size(A,1) size(A,2) 3 ]));

m=1;
midx=ceil((size(B,1)+1)/2);
midy=ceil((size(B,2)+1)/2);

for i=1:size(A,1)
    i1=i-midx;
    for j=1:size(A,2)
        [t,r]=cart2pol(i1,j-midy);
        t1=rad2deg(t)+deg;
        t=deg2rad(t1);
        [x,y]=pol2cart(t,r);
        x1(m)=round(x+midx);
        x2(m)=round(y+midy);
       
         
        m=m+1;  
    end
   
end

n=1;
for i=1:size(A,1)
    for j=1:size(A,2)
        B(x1(n),x2(n),:)=A(i,j,:);
       
        n=n+1;
    end   
end

end

function D = horizantally(A)
 D = A;
 [x, y, z] =size(D);
  
  
% Reverse elements of each row in every image plane
for plane = 1: z
    for i = 1 : x
        len = y; 
        for j = 1 : y
      
            if j < y/2 
                temp = D(i, j, plane);
                D(i, j, plane) = D(i, len, plane);
                D(i, len, plane) = temp;
                len = len - 1;
            end
        end
    end
end
  
end

function E = vertically(A)
E = A;
[x, y, z] = size(E);
   
% Reverse elements of each column in each image plane (dimension)
for plane = 1 : z
    len = x;
    for i = 1 : x 
        for j = 1 : y
   
            if i < x/2 
                temp = E(i, j, plane);
                E(i, j, plane) = E(len, j, plane);
                E(len, j, plane) = temp;
                 
            end
        end
        len = len - 1;
    end
end
   
end

function F = negative(A)
L = 2 ^ 8;
F = (L - 1) - A;
end

function G = resize(A)
scale = [0.5, 0.5];  %# The resolution scale factors: [rows columns]
oldSize = size(A);   %# Get the size of your image
newSize = max(floor(scale.*oldSize(1:2)),1);  %# Compute the new image size
%# Compute an upsampled set of indices:
rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));
%# Index old image to get new image:
G = A(rowIndex,colIndex,:);
end




