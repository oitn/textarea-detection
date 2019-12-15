% 对二值图检测，确定最后的文字区域
function [ch] = checkTwo(posi)
global layer two minu;
ch = 1;
% 判断矩形域
x = round(posi(1));
y = round(posi(2));
width = round(posi(3));
height = round(posi(4));

line = zeros(1, width);

v_line = zeros(1, height);

%% ——————— 分割线 ———————

% 纵向统计横向点数，对不合格的地方进行剪裁
for py = y:y+height
    point_num = 0;
    for px = x:x+width
        if(two(py, px) == 0)
            point_num = point_num + 1;
        end
    end
    v_line(py-y+1) = point_num;
end


% 定位大致范围
k1 = 15;
max_num = width - round(width/k1);
min_num = 0 + round(width/k1);

% 掐头去尾
% 日常发呆……我又写了啥????
v_from = 1;
v_to = size(v_line, 2);
for i = 1:size(v_line, 2)
    if(v_line(i)>max_num || v_line(i)<min_num)
        % 上半部分压缩一下
        y = y + 1;
        height = height - 1;
        v_from = v_from + 1;
    else
        break
    end
end
for i = size(v_line, 2):-1:1
    if(v_line(i)>max_num || v_line(i)<min_num)
        % 下半部分压缩一下
        height = height - 1;
        v_to = v_to - 1;
        % 防止减过头了
        if (height == 0)
            break
        end
    else
        break
    end
end

% 如果最终留下的高度过小，直接判定不合格
if(height < minu*0.6)
    ch = 0;
    %fprintf("posi %d %d end in minu after cutting\n", x, y);
end


if(ch~=0)
% emmmm斜率了。。。。
v_line2 = v_line(v_from:v_to);
A = polyfit(v_from:1:v_to, v_line2, 1);
z = polyval(A, v_from:1:v_to);
xielv = A(1) / (max(v_line)-min(v_line)) * height;
if(abs(xielv) > 0.5)
    ch = 0;
end
end



%% —————— 分割线 ——————
% 横向统计纵向点数（这里其实只想画个图）
for px = x:x+width
    point_num = 0;
    for py = y:y+height
       if(two(py, px) == 0)
           point_num = point_num+1;
       end
    end
    line(px-x+1) = point_num;
end
%调用fJudge函数
cut = [0 0];
if(ch ~= 0)
ic = imcrop(two, [x y width height]);
ch = min([ fJudge(ic, width, height) ch ]);
end


target = imcrop(two, [x, y, width, height]);

%% —————— 分割线 ——————

% 之前好像把基础值玩没了…………重新获取一下。。我说layer咋这么多小条条
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

% % 图像输出由于太影响程序运行效率，同意搬到后面注释掉了
% figure, subplot(221), plot(v_line), title('纵向分布检测')
% subplot(222), plot(v_from:1:v_to, v_line2, 'r*', v_from:1:v_to, z, 'b'), title(['直线拟合纵向图 斜率：' num2str(xielv)]);
% subplot(223), plot(line), title('横向分布检测');
% subplot(224), imshow(target), title([num2str(cut(1)) 'and' num2str(cut(2))]);

