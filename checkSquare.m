function [ch] = checkSquare(image,posi)
global layer;
ch = 1;
% ÅÐ¶Ï¾ØÐÎÓò
x = round(posi(1));
y = round(posi(2));
width = round(posi(3));
height = round(posi(4));
if(height*2.8 > width)
    ch = 0;
end

if(ch == 0)
    for i = y:y-1+height
        for j = x:x-1+width
            layer(i, j) = 0;
        end
    end
end