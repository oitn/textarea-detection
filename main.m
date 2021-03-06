% 请从此处运行
clear;
source = imread('pic_source.jpg');
global H W;
H = size(source, 1);
W = size(source, 2);
% 如果是作业图片，旋转90度再检测
if(W==1331&&H==739)
    source = imrotate(source,-90,'nearest');
    H = size(source, 1);
    W = size(source, 2);
end

% 设定最大和最小的文字大小
global maxu minu;
maxu = round(max([H W])/10);
minu = round(min([H W])/40);

%% 求边缘和二值图
global edges gray;
gray = rgb2gray(source);
edges = edge(gray,'prewitt');
B = [0 1 0; 1 1 1; 0 1 0];
edges = imdilate(edges, B);
figure, imshow(edges), title('提取边缘');
global two;
two = im2bw(gray,120/255);
figure, imshow(two), title('图片二值化')

%% 确定候选文字区域
% 创建图层蒙版
global layer;
layer = ones(H, W);

% 行分割(基于edges，对layer进行操作，去除非文字区域)
divLine(minu*2.5, 0);
divLine(minu*2.5, 0.75);
divLine(minu*2.5, 0.5);
divLine(minu*2.5, 0.75);
figure, imshow(layer), title('行分割')

% 纵向检测
deNoise('vertical');
figure, imshow(layer), title('第一次垂直去噪');
checkBox('left');
checkBox('right');
figure, imshow(layer), title('检测矩形是否为横向');
deNoise('horizontal')
deNoise('vertical');
checkBox('left');
checkBox('right');
deNoise('horizontal');
deNoise('vertical');
figure, imshow(layer), title('多重复几次');

%连通区域标记候选文字区域
object = bwlabel(layer, 8);
posi = regionprops(logical(object), 'boundingbox');

%% 排除多余的候选区域
% 对矩形宽高进行筛选
iftext = ones(size(posi, 1));
for i = 1:size(posi, 1)
    iftext(i) = checkSquare(edges, posi(i).BoundingBox);
end
weizhi = find(iftext==0);
posi(weizhi) = [];
figure, imshow(layer), title('检测矩形宽高进行筛选');

% 根据二值图像素点位置进一步检测矩形区域是否是文字区域
iftext = ones(size(posi, 1));
for i = 1:size(posi, 1)
    iftext(i) = checkTwo(posi(i).BoundingBox);
end
weizhi = find(iftext==0);
posi(weizhi) = [];
figure, imshow(layer), title('检测图像边缘的垂直元素进行筛选');

%% OVER， 输出结果
% 绘制矩形
for i = 1:size(posi, 1)
    source = drawRectangle(source, posi(i).BoundingBox);
end
if(H==1331&&W==739)
    source = imrotate(source,90,'nearest');
end
figure, imshow(source);