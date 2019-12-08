function[] = checkBox(type)
% É¸³ý·Ç¾ØÐÎÇøÓò
global ifcheckBox;
global H W;
global layer;
ifcheckBox = zeros(H, W);

if(strcmp(type, 'left'))
    for y = 1:H
        for x = 1:W
            if (layer(y, x)==1 && ifcheckBox(y, x)==0)
                checkPoint(x, y, type);
            end
        end
    end
elseif(strcmp(type, 'right')) 
    for y = 1:H
        for x = 1:W
            xx = W+1-x;
            if (layer(y, xx)==1 && ifcheckBox(y, xx)==0)
                checkPoint(xx, y, type);
            end
        end
    end
else
    disp('checkBox_wrong');
end