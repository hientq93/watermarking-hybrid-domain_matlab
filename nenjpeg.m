function varargout = nenjpeg(varargin)
% NENJPEG MATLAB code for nenjpeg.fig
%      NENJPEG, by itself, creates a new NENJPEG or raises the existing
%      singleton*.
%
%      H = NENJPEG returns the handle to a new NENJPEG or the handle to
%      the existing singleton*.
%
%      NENJPEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NENJPEG.M with the given input arguments.
%
%      NENJPEG('Property','Value',...) creates a new NENJPEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nenjpeg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nenjpeg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nenjpeg

% Last Modified by GUIDE v2.5 14-Apr-2016 00:52:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nenjpeg_OpeningFcn, ...
                   'gui_OutputFcn',  @nenjpeg_OutputFcn, ...
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


% --- Executes just before nenjpeg is made visible.
function nenjpeg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nenjpeg (see VARARGIN)

% Choose default command line output for nenjpeg
handles.output = hObject;
handles.anhGoc=0;
handles.anhThuyVan=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nenjpeg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nenjpeg_OutputFcn(hObject, eventdata, handles) 
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
anhGoc=handles.anhGoc;
aG=rgb2gray(anhGoc);


global flag;                                                                % variabili globali
global livello;
global originale_bn;
global trasformata_bn;
global compressa_bn;
global originale_c;
global trasformata_c;
global compressa_c;

livello=cast(str2num(get(handles.edit2, 'string')), 'int8');                % leggo il livello di compressione e lo converto in int
if (isinteger(livello) && (livello<9) && (livello>0))==false                % se esso non è compreso tra 1 e 8 dò errore
    disp('devi inserire un numero intero compreso tra 1 e 8!!!')
else
img=handles.anhThuyVan;

T=dctmtx(8);                                                                % matrice di trasformazione 8x8
fun=@(x)(T*x*T');                                                           % trasformata coseno
mask=zeros(8);                                                              % la maschera è inizializzata a zero
invdct=@(x)(T'*x*T);                                                        % antitrasformata
if flag==0                                                                  % se flag==0 comprimo in b/n
    imgbn=0.299.*img(:,:,1)+ 0.587.*img(:,:,2)+ 0.114.*img(:,:,3);
    originale_bn=imgbn;                                                     % estraggo la componente b/n
    B_bn=blkproc(im2double(imgbn), [8 8], fun);                             % la trasformo a blocchi 8x8
    mask(1:livello , 1:livello)=1;                                          % preparo la maschera
    B_bn_jpg_trasf=blkproc(B_bn, [8 8], @(x)(mask.*x));
    trasformata_bn=B_bn_jpg_trasf;                                          % la applico alla trasformata
    B_bn_jpg=blkproc(B_bn_jpg_trasf, [8 8], invdct);
    compressa_bn=B_bn_jpg;                                                  % antitrasformo
    axes(handles.axes1)
    imshow (B_bn_jpg, [])                                                   % mostro l'immagine compressa
elseif flag~=0
    imgc=im2double(img);
    originale_c=imgc;
    for i=1:3                                                               % faccio la stessa cosa però per ogni componente di colore
        B_c(:,:,i)=blkproc(imgc(:,:,i), [8 8], fun);
        mask(1:livello , 1:livello)=1;
        app=B_c(:,:,i);
        B_c_jpg_trasf(:,:,i)=blkproc(app, [8 8], @(x)(mask.*x));
        B_c_jpg(:,:,i)=blkproc(B_c_jpg_trasf(:,:,i), [8 8], invdct);
    end
        trasformata_c=B_c_jpg_trasf;
        compressa_c=B_c_jpg;
        axes(handles.axes2)
        imshow(B_c_jpg)                                                     % mostro l'immagine compressa a colori
        anhNen=B_c_jpg;
end
end
aN=rgb2gray(anhNen);
%NCC
c = max(max(normxcorr2(aG,aN)));
size(c)
%figure, surf(c), shading flat
set(handles.txtncc1,'String',c);
%PSNR
 n=size(aG);
 M=n(1);
 N=n(2);
 MSE = sum(sum((aG-aN).^2))/(M*N);
p = 10*log10(256*256/MSE)
set(handles.txtpsnr1,'String',p);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhGoc=imread(strcat(anhmau,fname));
axes(handles.axes1)             %Fisso l'axes per il plot
imshow(anhGoc)
handles.anhGoc=anhGoc;
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhThuyVan=imread(strcat(anhmau,fname));
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)
handles.anhThuyVan=anhThuyVan;
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;

imwrite(anhThuyVan,'nen10.jpg','Mode','lossy','Quality',10); 
anhThuyVan = imread ('nen10.jpg');
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)

cr = max(max(normxcorr2(anhGoc(:,:,1), anhThuyVan(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), anhThuyVan(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), anhThuyVan(:,:,3))));
c=(cr+cg+cb)/3;
%figure, surf(c), shading flat
set(handles.txtncc1,'String',c);

% PSNR

p = PSNR_RGB(anhGoc,anhThuyVan);
set(handles.txtpsnr1,'String',p);

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;

imwrite(anhThuyVan,'nen30.jpg','Mode','lossy','Quality',30); 
anhThuyVan = imread ('nen30.jpg');
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)

cr = max(max(normxcorr2(anhGoc(:,:,1), anhThuyVan(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), anhThuyVan(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), anhThuyVan(:,:,3))));
c=(cr+cg+cb)/3;
%figure, surf(c), shading flat
set(handles.txtncc2,'String',c);

% PSNR

p = PSNR_RGB(anhGoc,anhThuyVan);
set(handles.txtpsnr2,'String',p);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
anhThuyVan=handles.anhThuyVan;

imwrite(anhThuyVan,'nen60.jpg','Mode','lossy','Quality',60); 
anhThuyVan = imread ('nen60.jpg');
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)

cr = max(max(normxcorr2(anhGoc(:,:,1), anhThuyVan(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), anhThuyVan(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), anhThuyVan(:,:,3))));
c=(cr+cg+cb)/3;
%figure, surf(c), shading flat
set(handles.txtncc3,'String',c);

% PSNR

p = PSNR_RGB(anhGoc,anhThuyVan);
set(handles.txtpsnr3,'String',p);
