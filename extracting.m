function varargout = extracting(varargin)
% EXTRACTING MATLAB code for extracting.fig
%      EXTRACTING, by itself, creates a new EXTRACTING or raises the existing
%      singleton*.
%
%      H = EXTRACTING returns the handle to a new EXTRACTING or the handle to
%      the existing singleton*.
%
%      EXTRACTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACTING.M with the given input arguments.
%
%      EXTRACTING('Property','Value',...) creates a new EXTRACTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before extracting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to extracting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extracting

% Last Modified by GUIDE v2.5 09-Apr-2016 10:16:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @extracting_OpeningFcn, ...
                   'gui_OutputFcn',  @extracting_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before extracting is made visible.
function extracting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to extracting (see VARARGIN)

% Choose default command line output for extracting
handles.output = hObject;
handles.LLgoc=0;
handles.LLw=0;
handles.chonPhan=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extracting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = extracting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
    anhchuathuyvan=imread(strcat(anhmau,fname)); 
    axes(handles.axes1)             %Fisso l'axes per il plot
    imshow(anhchuathuyvan) 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhGoc=imread(strcat(anhmau,fname));
axes(handles.axes2)   %Fisso l'axes per il plot
%anhGoc=double(anhGoc1);
imshow(anhGoc)

%Xu Ly Anh Goc
YCBCR=rgb2ycbcr(anhGoc) % chuyen RGB sang YCbCr
Y=YCBCR(:,:,1)
Cb=YCBCR(:,:,2) % lay phan Cb
Cr=YCBCR(:,:,3)

%Chia Anh Thanh 4 Phan
[row, col]=size(Cb);
mr = round(row/2); % median of rows
mc = round(col/2); % median of columns

% Phan 1
top_left  = Cb(1:mr  , 1:mc);
p1=edge(top_left,'canny');
axes(handles.axes12)
imshow(p1)
% dem so bien
[labeledImage, numberOfEdgesp1] = bwlabel(p1);
numberOfEdgesp1

% phan 2
top_right = Cb(1:mr  , (mc+1):col);
p2=edge(top_right,'canny');
axes(handles.axes11)
imshow(p2)
% dem so bien
[labeledImage, numberOfEdgesp2] = bwlabel(p2);
numberOfEdgesp2

% phan 3
bot_left  = Cb((mr+1):row , 1:mc);
p3=edge(bot_left,'canny');
axes(handles.axes10)
imshow(p3)
% dem so bien
[labeledImage, numberOfEdgesp3] = bwlabel(p3);
numberOfEdgesp3

% Pham 4
bot_right = Cb((mr+1):row , (mc+1):col);
p4=edge(bot_right,'canny');
axes(handles.axes9)
imshow(p4)
%Dem So Bien
[labeledImage, numberOfEdgesp4] = bwlabel(p4);
numberOfEdgesp4

% Tim phan tu có so bien lon nhat
h=[numberOfEdgesp1 numberOfEdgesp2 numberOfEdgesp3 numberOfEdgesp4];
y=1;
max=h(1);
for i=1:4
    if h(i)>max
        max =h(i)
        y=i
    else
        max=max
        
    end
end
handles.chonPhan=y;
guidata(hObject, handles);
pchon=p1;
phanTuChon=top_left;
if y==1
    pchon=p1;
    phanTuChon=top_left;
    set(handles.txtNhieuBien1,'String','Phan Nhieu Bien Nhat')
    %figure(2),imshow(p1),title('Phan Tu Nhieu Bien Nhat');
end
if y==2
    pchon=p2;
    phanTuChon=top_right;
    set(handles.txtNhieuBien2,'String','Phan Nhieu Bien Nhat')
    %figure(2),imshow(p2),title('Phan Tu Nhieu Bien Nhat');
end
if y==3
    pchon=p3;
    phanTuChon=bot_left;
    set(handles.txtNhieuBien3,'String','Phan Nhieu Bien Nhat')
    %figure(2),imshow(p3),title('Phan Tu Nhieu Bien Nhat');
end
if y==4
    pchon=p4;
    phanTuChon=bot_right;
    set(handles.txtNhieuBien4,'String','Phan Nhieu Bien Nhat')
    % figure(2),imshow(p4),title('Phan Tu Nhieu Bien Nhat');
end
%figure(2);%,imshow(pchon),title('Phan Tu Nhieu Bien Nhat');
%subplot(2,1,1);imshow(pchon);title('Phan Tu Nhieu Bien Nhat');
%subplot(2,1,2);imshow(phanTuChon);title('Chon Phan Tu');
phanChon=double(phanTuChon);
[LL,HL,LH,HH] = dwt2(phanChon,'haar');

handles.LLgoc=LL;
guidata(hObject, handles);
%figure(3);
%subplot(2,2,1);imshow(LL);title('LL band of image');
%subplot(2,2,2);imshow(LH);title('LH band of image');
%subplot(2,2,3);imshow(HL);title('HL band of image');
%subplot(2,2,4);imshow(HH);title('HH band of image');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhDaThuyVan=imread(strcat(anhmau,fname));
%anhDaThuyVan=double(anhDaThuyVan1);
axes(handles.axes3)             %Fisso l'axes per il plot
imshow(anhDaThuyVan)

%Xu Ly Anh Da Thuy Van
YCBCR=rgb2ycbcr(anhDaThuyVan) % chuyen RGB sang YCbCr
Y=YCBCR(:,:,1)
Cb=YCBCR(:,:,2) % lay phan Cb
Cr=YCBCR(:,:,3)

%Chia Anh Thanh 4 Phan
[row, col]=size(Cb);
mr = round(row/2); % median of rows
mc = round(col/2); % median of columns

% Phan 1
P1  = Cb(1:mr  , 1:mc);
pc1=edge(P1,'canny');
[labeledImage, numberOfEdgesp1] = bwlabel(pc1);
numberOfEdgesp1
% phan 2
P2 = Cb(1:mr  , (mc+1):col);
pc2=edge(P2,'canny');
[labeledImage, numberOfEdgesp2] = bwlabel(pc2);
numberOfEdgesp2
% phan 3
P3  = Cb((mr+1):row , 1:mc);
pc3=edge(P3,'canny');
[labeledImage, numberOfEdgesp3] = bwlabel(pc3);
numberOfEdgesp3
% Pham 4
P4 = Cb((mr+1):row , (mc+1):col);
pc4=edge(P4,'canny');
[labeledImage, numberOfEdgesp4] = bwlabel(pc4);
numberOfEdgesp4

% Tim phan tu có so bien lon nhat
h=[numberOfEdgesp1 numberOfEdgesp2 numberOfEdgesp3 numberOfEdgesp4];
y=1;
max=h(1);
for i=1:4
    if h(i)>max
        max =h(i)
        y=i
    else
        max=max
        
    end
end

phanTuChon=P1;
if y==1
   
    phanTuChon=P1;
    
end
if y==2
   
    phanTuChon=P2;
    
end
if y==3
   
    phanTuChon=P3;
    
end
if y==4
   
    phanTuChon=P4;
    
end
phanTuChon1=double(phanTuChon);
[LL,HL,LH,HH] = dwt2(phanTuChon1,'haar');

handles.LLw=LL;
guidata(hObject, handles);
figure(1),imshow(uint8(LL)),title('LL');
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

LLgoc=handles.LLgoc;
[rowLLH,colLLH]=size(LLgoc);
rowLLH
colLLH
LLw=handles.LLw;
[rowLLW,colLLW]=size(LLw);
rowLLW
colLLW
i1=LLgoc(1,1)
i2=LLw(1,1)
load data.mat
mrW
mcW
z=mrW*mcW;
tempW1=1:z;
tempW2=1:z;
tempW3=1:z;
tempW4=1:z;
dongNhung1=0;
dongNhung2=0;
dongNhung3=0;
dongNhung4=0;
chay=1;
% lay phan W1
for r1=1:rowLLH
     if chay>z
            dongNhung1=r1-1;
            break;
     end
    for c1=1:colLLH
       
       
        tempW1(chay)=( LLw(r1,c1)-LLgoc(r1,c1))/0.1;
        chay=chay+1;
    end
end
% Lay W2
chay=1;
for r2=(dongNhung1+1):rowLLH
    if chay>z
            dongNhung2=r2-1;
            break;
    end
    for c2=1:colLLH
        
       tempW2(chay)=( LLw(r2,c2)-LLgoc(r2,c2))/0.1;
        chay=chay+1;
    end
end
% Lay W3
chay=1;
for r3=(dongNhung2+1):rowLLH
     if chay>z
            dongNhung3=r3-1;
            break;
     end
    for c3=1:colLLH
       
       tempW3(chay)=( LLw(r3,c3)-LLgoc(r3,c3))/0.1;
        chay=chay+1;
    end
end
% Lay W4
chay=1;
for r4=(dongNhung3+1):rowLLH
     if chay>z
            dongNhung4=r4-1;
            break;
     end
    for c4=1:colLLH
       tempW4(chay)=( LLw(r4,c4)-LLgoc(r4,c4))/0.1;
        chay=chay+1;
    end
end
%tai tao cac goc phan tu tu cac tempW
W1=zeros(mrW,mcW);
W2=zeros(mrW,mcW);
W3=zeros(mrW,mcW);
W4=zeros(mrW,mcW);
chay2=1;
%W1
for t1=1:mrW
    if chay2>z
            break;
    end
    for t2=1:mcW
         
        W1(t1,t2)=tempW1(chay2);
        chay2=chay2+1;
    end
end
%W2
chay2=1;
for t1=1:mrW
    if chay2>z
            break;
    end
    for t2=1:mcW
         
        W2(t1,t2)=tempW2(chay2);
        chay2=chay2+1;
    end
end
%W3
chay2=1;
for t1=1:mrW
     if chay2>z
            break;
     end
    for t2=1:mcW
        
        W3(t1,t2)=tempW3(chay2);
        chay2=chay2+1;
    end
end
%W4
chay2=1;
for t1=1:mrW
     if chay2>z
            break;
     end
    for t2=1:mcW
        
        W4(t1,t2)=tempW4(chay2);
        chay2=chay2+1;
    end
end
tempW1
tempW2
tempW3
tempW4
w=[W1,W2;W3,W4];
axes(handles.axes4)           
imshow(uint8(w))
% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes4
