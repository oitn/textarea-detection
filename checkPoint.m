function[] = checkPoint(x, y, type)
% 从checkbox中调用
global ifcheckBox;
global H W;
global layer;

h = 0;
w = 0;

if(strcmp(type, 'left'))
    while( x+w<W && layer(y, x+w)~=0 )
        ifcheckBox(y, x+w) = 1;
        w = w+1;
    end
    while( h+y<H && layer(h+y, x)~=0 )
        h = h+1;
    end
elseif(strcmp(type, 'right'))
    while( x-w>0 && layer(y, x-w)~=0 )
        ifcheckBox(y, x-w) = 1;
        w = w+1;
    end
    while( h-y>0 && layer(h-y, x)~=0 )
        h = h+1;
    end
end

if( h*2 > w )
    if(strcmp(type, 'left'))
        for i = x:x+w
            layer(y, i) = 0;
        end
    else
        for i = x-w:x
            layer(y, i) = 0;
        end
    end
end