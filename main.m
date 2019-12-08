clear;
source = imread('pic_source5.jpg');
global H W;
H = size(source, 1);
W = size(source, 2);
% �����Ҫ���ͼƬ����ת90���ټ��
if(W==1331&&H==739)
    source = imrotate(source,-90,'nearest');
    H = size(source, 1);
    W = size(source, 2);
end

% �趨������С�����ִ�С
global maxu minu;
maxu = round(max([H W])/6);
minu = round(min([H W])/40);

%% ���Ե
global edges gray;
gray = rgb2gray(source);
edges = edge(gray,'prewitt');
B = [0 1 0; 1 1 1; 0 1 0];
edges = imdilate(edges, B);
figure, imshow(edges), title('��ȡ��Ե');
global two;
two = im2bw(gray,120/255);
figure, imshow(two), title('ͼƬ��ֵ��')

%% ȷ����ѡ��������
% ����ͼ���ɰ�
global layer;
layer = ones(H, W);

% �зָ�(����edges����layer���в�����ȥ������������)
divLine(minu*2.5, 0);
divLine(minu*2.5, 0.75);
divLine(minu*2.5, 0.5);
divLine(minu*2.5, 0.75);
figure, imshow(layer), title('�зָ�')

% ������
deNoise('vertical');
figure, imshow(layer), title('��һ�δ�ֱȥ��');
checkBox('left');
checkBox('right');
figure, imshow(layer), title('�������Ƿ�Ϊ����');
deNoise('horizontal')
deNoise('vertical');
checkBox('left');
checkBox('right');
deNoise('horizontal');
deNoise('vertical');
figure, imshow(layer), title('���ظ�����');

%��ͨ�����Ǻ�ѡ��������
object = bwlabel(layer, 8);
posi = regionprops(logical(object), 'boundingbox');

%% �ų�����ĺ�ѡ����
% �Ծ��ο��߽���ɸѡ
iftext = ones(size(posi, 1));
for i = 1:size(posi, 1)
    iftext(i) = checkSquare(edges, posi(i).BoundingBox);
end
weizhi = find(iftext==0);
posi(weizhi) = [];
figure, imshow(layer), title('�����ο��߽���ɸѡ');

% ���ݶ�ֵͼ��һ�������������Ƿ��Ƿ���������
iftext = ones(size(posi, 1));
for i = 1:size(posi, 1)
    iftext(i) = checkVertical(edges, posi(i).BoundingBox);
end
weizhi = find(iftext==0);
posi(weizhi) = [];
figure, imshow(layer), title('���ͼ���Ե�Ĵ�ֱԪ�ؽ���ɸѡ');

%% OVER�� ������
% ���ƾ���
for i = 1:size(posi, 1)
    source = drawRectangle(source, posi(i).BoundingBox);
end
if(H==1331&&W==739)
    source = imrotate(source,90,'nearest');
end
figure, imshow(source);