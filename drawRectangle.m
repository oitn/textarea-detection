function [drawRectangleImage] = drawRectangle(image,posi)
global H W;
x = round(posi(1));%���ο�λ�����꣬���ʽΪ[x,y]
y = round(posi(2));
width = round(posi(3));%���ο�ߴ磬���ʽΪ[height,width]����[�߶�,����]
height = round(posi(4));
drawRectangleImage = image;
if((x<=W && y<=H)&&(height<H && width<=W))
    LabelLineColor = 0;          % �������ɫ
    topMost = max([y-5 1]);                  % ���ο��ϱ�Ե
    botMost = min([y+height H]);        % ���ο��±�Ե
    lefMost = max([x-5 1]);                 % ���ο����Ե
    rigMost = min([x+width W]);        % ���ο��ұ�Ե
    
    drawRectangleImage(topMost:botMost,lefMost:lefMost+2) = LabelLineColor; % ��߿�
    drawRectangleImage(topMost:botMost,rigMost-2:rigMost) = LabelLineColor; % �ұ߿�
    drawRectangleImage(topMost:topMost+2,lefMost:rigMost) = LabelLineColor; % �ϱ߿�
    drawRectangleImage(botMost-2:botMost,lefMost:rigMost) = LabelLineColor; % �±߿�
end