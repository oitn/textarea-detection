function [drawRectangleImage] = drawRectangle(image,posi)
global H W;
x = round(posi(1));%矩形框位置坐标，其格式为[x,y]
y = round(posi(2));
width = round(posi(3));%矩形框尺寸，其格式为[height,width]，即[高度,宽度]
height = round(posi(4));
drawRectangleImage = image;
if((x<=W && y<=H)&&(height<H && width<=W))
    LabelLineColor = 0;          % 标记线颜色
    topMost = max([y-5 1]);                  % 矩形框上边缘
    botMost = min([y+height H]);        % 矩形框下边缘
    lefMost = max([x-5 1]);                 % 矩形框左边缘
    rigMost = min([x+width W]);        % 矩形框右边缘
    
    drawRectangleImage(topMost:botMost,lefMost:lefMost+2) = LabelLineColor; % 左边框
    drawRectangleImage(topMost:botMost,rigMost-2:rigMost) = LabelLineColor; % 右边框
    drawRectangleImage(topMost:topMost+2,lefMost:rigMost) = LabelLineColor; % 上边框
    drawRectangleImage(botMost-2:botMost,lefMost:rigMost) = LabelLineColor; % 下边框
end