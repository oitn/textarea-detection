function[] = deNoise(type)
global H W;
global layer;
global minu maxu;
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
    dist('È¥ÔëÊ§°Ü')
end