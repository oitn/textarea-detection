% ����̬�зָ������
% ��С��λ������ɸ������������
% unit���ָ�Ԫ�ص�λ��  start_posi���ָ�ƫ����
function[] = divLine(unit, skew)
global H W;
global edges;
global layer;

for col = 1:100
    if( (col+skew)*unit < W )
        last_isnull = 1;
        for row = 1:H
            num = 0;
            x1 = round((col+skew)*unit);
            x2 = min([x1+unit W]);
            for x = x1:x2
                if(edges(row, x) == 1)
                    num = num+1;
                end
            end
            if(num < 1)
                if(last_isnull==1)
                    for x = x1:x2    
                        layer(row, x) = 0;
                    end
                end
%                 last_isnull = 1;
%             else
%                 last_isnull = 0;
            end
        end
    else
        break
    end
end

        