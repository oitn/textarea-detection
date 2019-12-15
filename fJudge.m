% ���룺����ͼ�񡢿��ȡ��߶ȡ����������
% ���������Ϊ�����������ʼ��
% ����checkTwo�������Ժ���ֲ��������λ�ý��к���
function [iftext] = fJudge(image, width, height)
iftext = 1;
line = zeros(1, width);

%����ͳ���������
for px = 1:width
    point_num = 0;
    for py = 1:height
        if(image(py, px) == 0)
            point_num = point_num + 1;
        end
    end
    line(px) = point_num;
end

% �ϲ����λ��
zero_posi = [];
for i = 1:width
    if(line(i) < 1)
        j = i;
        while(j<=width && line(j) < 1)
            line(j) = 1;
            j = j+1;
        end
        zero_posi = [zero_posi round((i+j)/2)];
    end
end

% ȷ���������interval�ķ�Χ
max_interval = 3*height;
min_interval = height;

max_length = 0;
max_from = 0;
max_to = 0;

% ���֣����벻��׼����Ҳ����׼���⡭��Ҫ���ǵ�����öడ

% ����ÿ����
for i = 1:length(zero_posi)
    % ����ÿ�����ܵ��������
    for j = i+1:length(zero_posi)
        interval = zero_posi(j) - zero_posi(i);
        if(interval > max_interval)
            break
        end
        if(interval > min_interval)
            temp_to = j;
            % ��������Ҫ��ĵ����Ŀ
            last_posi = zero_posi(j);
            for k = j+1:length(zero_posi)
                if(zero_posi(k)-last_posi<interval*1.6 && zero_posi(k)-last_posi>interval*0.5)
                    last_posi = zero_posi(k);
                    temp_to = k;
                elseif(zero_posi(k) > interval*1.1)
                    break
                end
            end
            if(last_posi-zero_posi(i) > max_length)
                max_length = last_posi - zero_posi(i);
                max_from = i;
                max_to = temp_to;
            end
        end
    end
end


if(max_from~=0 && max_to~=0)
    a = max([ zero_posi(max_from)-max_interval 1 ]);
    b = min([ zero_posi(max_to)+max_interval width ]);
else
    iftext = 0;
end

if(iftext~=0 && b-a<width/2)
    iftext = 0;
end

if(iftext~=0 && max_to-max_from < 2 && (a-1<min_interval || width-b<min_interval))
    iftext = 0;
end

