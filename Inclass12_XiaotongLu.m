%Inclass 12. 
%GB comments
1) 100
2) 100
3) 100
4) 100
Overall 100


% Continue with the set of images you used for inclass 11, the same time 
% point (t = 30)

% 1. Use the channel that marks the cell nuclei. Produce an appropriately
% smoothed image with the background subtracted. 
%XiaotongLu
file1='stemcell.tif';
reader=bfGetReader(file1);
chan2=2;
time2=30;
zplane2=1;
iplane2=reader.getIndex(zplane2-1,chan2-1,time2-1)+1;
img2=bfGetPlane(reader,iplane2);
imshow(img2,[500 1000])
img_sm=imfilter(img2,fspecial('gaussian',4,2));
img_bg=imopen(img_sm,strel('disk',100));
aimimg=imsubtract(img_sm,img_bg);
imshow(aimimg,[0 500]);
% 2. threshold this image to get a mask that marks the cell nuclei. 
%XiaotongLu
img_mask=aimimg>100;
imshow(cat(3,img_mask,imdilate(img_mask,strel('disk',5)),zeros(size(img_mask))));


% 3. Use any morphological operations you like to improve this mask (i.e.
% no holes in nuclei, no tiny fragments etc.)
%XiaotongLu
img_open=imopen(img_mask,strel('disk',9));
imshow(img_open);

% 4. Use the mask together with the images to find the mean intensity for
% each cell nucleus in each of the two channels. Make a plot where each data point 
% represents one nucleus and these two values are plotted against each other
%XiaotongLu
cell_property1=regionprops(img_mask, aimimg,'MeanIntensity','Area','Centroid','PixelValues');
intensity1=[cell_property1.MeanIntensity];
area1=[cell_property1.Area];

file1='stemcell.tif';
reader=bfGetReader(file1);
chan1=1;
time1=30;
zplane1=1;
iplane1=reader.getIndex(zplane1-1,chan1-1,time1-1)+1;
img1=bfGetPlane(reader,iplane1);
cell_property2=regionprops(img1,aimimg,'MeanIntensity','Area','Centroid','PixelValues');
intensity2=[cell_property2.MeanIntensity];
area2=[cell_property2.Area];
plot(area1,intensity1,'r.','MarkerSize',18)
hold on;
plot(area2,intensity2,'g.','MarkerSize',18)
