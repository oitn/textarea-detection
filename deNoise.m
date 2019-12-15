% 去除过小或过大的区域，这里取水平方向最小单位为3*minu，竖直方向最小单位minu
function[] = deNoise(type)
global H W;
global layer;
global minu maxu;
% 水平探测
if(strcmp(type, 'vertical'))
    for i = 1:W
        from = 1; to = 1;
        while(to <= H)
            if (layer(to, i) == 1 && to < H-1)
                to = to+1;
            else
                if ((to-from)<minu || (to-from)>maxu)
                    for k = from:to
                        layer(k, i) = 0;
                    end
                end
                from = to+1;
                to = to+1;
            end
        end
    end
% 竖直探测
elseif(strcmp(type, 'horizontal'))
    for i = 1:H
        from = 1; to = 1;
        while(to <= W)
            if (layer(i, to) == 1)
                to = to+1;
            else
                if ((to-from)<minu*2)
                    for k = from:to
                        layer(i, k) = 0;
                    end
                end
                from = to+1;
                to = to+1;
            end
        end
    end
else
    dist('去噪失败')
end