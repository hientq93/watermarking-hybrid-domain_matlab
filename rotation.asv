function varargout = rotation(varargin)
% ROTATION MATLAB code for rotation.fig
%      ROTATION, by itself, creates a new ROTATION or raises the existing
%      singleton*.
%
%      H = ROTATION returns the handle to a new ROTATION or the handle to
%      the existing singleton*.
%
%      ROTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATION.M with the given input arguments.
%
%      ROTATION('Property','Value',...) creates a new ROTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotation

% Last Modified by GUIDE v2.5 13-Apr-2016 19:22:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotation_OpeningFcn, ...
                   'gui_OutputFcn',  @rotation_OutputFcn, ...
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


% --- Executes just before rotation is made visible.
function rotation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotation (see VARARGIN)

% Choose default command line output for rotation
handles.output = hObject;
handles.anhGoc=0;
handles.anhThuyVan=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rotation_OutputFcn(hObject, eventdata, handles) 
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
% ratio =1
anhGoc=handles.anhGoc;
%aG=rgb2gray(anhGoc);

anhThuyVan=handles.anhThuyVan;
xoay1=imrotate(anhThuyVan,1,'bilinear');
axes(handles.axes2);         %Fisso l'axes per il plot
imshow(xoay1);


cr = max(max(normxcorr2(anhGoc(:,:,1), xoay1(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), xoay1(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), xoay1(:,:,3))));
c=(cr+cg+cb)/3;

%size(c)
%figure, surf(c), shading flat
set(handles.txtncc1,'String',c);
% PSNR
p = PSNR_RGB(anhGoc,xoay1);
%p=PSNR(aG,anhXoay);
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

anhGoc=handles.anhGoc;
aG=rgb2gray(anhGoc);

anhThuyVan=handles.anhThuyVan;
xoay1=imrotate(anhThuyVan,3,'bilinear');
axes(handles.axes2);         %Fisso l'axes per il plot
imshow(xoay1);
anhXoay=rgb2gray(xoay1);

cr = max(max(normxcorr2(anhGoc(:,:,1), xoay1(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), xoay1(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), xoay1(:,:,3))));
c=(cr+cg+cb)/3;

%figure, surf(c), shading flat
set(handles.txtncc3,'String',c);

% PSNR
 %e=MSE(aG,anhXoay);
 %MSE = sum(sum((aG-anhXoay).^2))/(M*N);
p =PSNR_RGB(anhGoc,xoay1);
set(handles.txtpsnr3,'String',p);
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
aG=rgb2gray(anhGoc);

anhThuyVan=handles.anhThuyVan;
xoay1=imrotate(anhThuyVan,2,'bilinear');
axes(handles.axes2);         %Fisso l'axes per il plot
imshow(xoay1);
anhXoay=rgb2gray(xoay1);

cr = max(max(normxcorr2(anhGoc(:,:,1), xoay1(:,:,1))));
cg = max(max(normxcorr2(anhGoc(:,:,2), xoay1(:,:,2))));
cb = max(max(normxcorr2(anhGoc(:,:,3), xoay1(:,:,3))));
c=(cr+cg+cb)/3;

%figure, surf(c), shading flat
set(handles.txtncc2,'String',c);

% PSNR
 %e=MSE(aG,anhXoay);
 %MSE = sum(sum((aG-anhXoay).^2))/(M*N);
p = PSNR_RGB(anhGoc,xoay1);
set(handles.txtpsnr2,'String',p);
