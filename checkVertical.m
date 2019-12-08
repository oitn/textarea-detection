function [ch] = checkVertical(image,posi)
global layer two minu;
ch = 1;
% �жϾ�����
x = round(posi(1));
y = round(posi(2));
width = round(posi(3));
height = round(posi(4));

line = zeros(1, width);

v_line = zeros(1, height);

%�������������� �ָ��� ��������������

% ����ͳ�ƺ���������Բ��ϸ�ĵط����м���
for py = y:y+height
    point_num = 0;
    for px = x:x+width
        if(two(py, px) == 0)
            point_num = point_num + 1;
        end
    end
    v_line(py-y+1) = point_num;
end
figure, subplot(221), plot(v_line), title('����ֲ����')

% ��λ���·�Χ
k1 = 15;
max_num = width - round(width/k1);
min_num = 0 + round(width/k1);

% ��ͷȥβ
% �ճ�������������д��ɶ????
v_from = 1;
v_to = size(v_line, 2);
for i = 1:size(v_line, 2)
    if(v_line(i)>max_num || v_line(i)<min_num)
        % �ϰ벿��ѹ��һ��
        y = y + 1;
        height = height - 1;
        v_from = v_from + 1;
    else
        break
    end
end
for i = size(v_line, 2):-1:1
    if(v_line(i)>max_num || v_line(i)<min_num)
        % �°벿��ѹ��һ��
        height = height - 1;
        v_to = v_to - 1;
        % ��ֹ����ͷ��
        if (height == 0)
            break
        end
    else
        break
    end
end

% ����������µĸ߶ȹ�С��ֱ���ж����ϸ�
if(height < minu*0.6)
    ch = 0;
    %fprintf("posi %d %d end in minu after cutting\n", x, y);
end


if(ch~=0)
% emmmmб���ˡ�������
v_line2 = v_line(v_from:v_to);
A = polyfit(v_from:1:v_to, v_line2, 1);
z = polyval(A, v_from:1:v_to);
xielv = A(1) / (max(v_line)-min(v_line)) * height;
subplot(222), plot(v_from:1:v_to, v_line2, 'r*', v_from:1:v_to, z, 'b'), title(['ֱ���������ͼ б�ʣ�' num2str(xielv)]);
if(abs(xielv) > 0.4)
    ch = 0;
end
end



%������������ �ָ��� ������������

% ����ͳ���������
for px = x:x+width
    point_num = 0;
    for py = y:y+height
       if(two(py, px) == 0)
           point_num = point_num+1;
       end
    end
    line(px-x+1) = point_num;
end
subplot(223), plot(line), title('����ֲ����')
target = imcrop(two, [x, y, width, height]);
subplot(224), imshow(target);


if(ch~=0)
%
% ���͹ȵ�λ��
valley_posi = [];
for i = 1:width
    if(line(i)<1)
        valley_posi = [valley_posi i];
        j = i;
        while(j<=width && line(j)<1)
            line(j) = 1;
            j = j+1;
        end
    end
end
if(~isempty(valley_posi) && valley_posi(1) == 1)
    valley_posi(1) = [];
end
% �ж�λ���Ƿ����Ҫ��

if(width>minu && width/height > 10)
    if(length(valley_posi) < (width/(height*3)))
        ch = 0;
    end
else
    if(length(valley_posi) < (width/(height*1.8)))
        ch = 0;
    end
end
%
end

% �������д���١����������治�����ˡ���

% ������������ �ָ��� ������������

% ֮ǰ����ѻ���ֵ��û�ˡ����������»�ȡһ�¡�����˵layerզ��ô��С����
x = round(posi(1));
y = round(posi(2));
width = round(posi(3));
height = round(posi(4));

if(ch == 0)
    for i = y:y-1+height
        for j = x:x-1+width
            layer(i, j) = 0;
        end
    end
end

%subplot(222), title(['ind: ' num2str(ind) ]);