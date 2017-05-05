function varargout = beforeacttack(varargin)
% BEFOREACTTACK MATLAB code for beforeacttack.fig
%      BEFOREACTTACK, by itself, creates a new BEFOREACTTACK or raises the existing
%      singleton*.
%
%      H = BEFOREACTTACK returns the handle to a new BEFOREACTTACK or the handle to
%      the existing singleton*.
%
%      BEFOREACTTACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEFOREACTTACK.M with the given input arguments.
%
%      BEFOREACTTACK('Property','Value',...) creates a new BEFOREACTTACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beforeacttack_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beforeacttack_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beforeacttack

% Last Modified by GUIDE v2.5 14-Apr-2016 00:55:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beforeacttack_OpeningFcn, ...
                   'gui_OutputFcn',  @beforeacttack_OutputFcn, ...
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


% --- Executes just before beforeacttack is made visible.
function beforeacttack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beforeacttack (see VARARGIN)

% Choose default command line output for beforeacttack
handles.output = hObject;
handles.anhGoc=0;
handles.anhThuyVan=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beforeacttack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beforeacttack_OutputFcn(hObject, eventdata, handles) 
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
anhThuyVan=handles.anhThuyVan;
aTV=rgb2gray(anhThuyVan);
r1=corr2(anhGoc(:,:,1),anhThuyVan(:,:,1));
r2=corr2(anhGoc(:,:,2),anhThuyVan(:,:,2));
r3=corr2(anhGoc(:,:,3),anhThuyVan(:,:,3));
r=(r1+r2+r3)/3;
set(handles.txtBF2,'String',r);

%InputImage=imread(‘Input.jpg’);
%ReconstructedImage=imread(‘recon.jpg’);

p=PSNR_RGB(anhGoc,anhThuyVan);

set(handles.txtBF1,'String',p);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
aG=rgb2gray(anhGoc);
anhThuyVan=handles.anhThuyVan;
aTV=rgb2gray(anhThuyVan);
aTVattack= LocMediana(anhThuyVan);
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(aTVattack)

r1=corr2(anhGoc(:,:,1),aTVattack(:,:,1));
r2=corr2(anhGoc(:,:,2),aTVattack(:,:,2));
r3=corr2(anhGoc(:,:,3),aTVattack(:,:,3));
r=(r1+r2+r3)/3;
set(handles.txtMF2,'String',r);


%n=size(aG);
 %M=n(1);
 %N=n(2);
% MSE = sum(sum((aG-aTVattack).^2))/(M*N);
%p = 10*log10(255*255/MSE);
%p=PSNR(aG,aTVattack);
p=PSNR_RGB(anhGoc,aTVattack);
set(handles.txtMF1,'String',p);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
muoitieu

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anhGoc=handles.anhGoc;
%aG=rgb2gray(anhGoc);
A=handles.anhThuyVan;

%Preallocate the matrices with zeros
I1=A;
I=zeros(size(A));
I2=zeros(size(A));

%Filter Masks
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

%Padarray with zeros
A=padarray(A,[1,1]);
A=double(A);

%Implementation of the equation in Fig.D
for i=1:size(A,1)-2
    for j=1:size(A,2)-2
       
        I(i,j)=sum(sum(F1.*A(i:i+2,j:j+2)));
       
    end
end

I=uint8(I);
B=I1-I;

axes(handles.axes2)             %Fisso l'axes per il plot
imshow(B)

%aTV=rgb2gray(B);

r1=corr2(anhGoc(:,:,1),B(:,:,1));
r2=corr2(anhGoc(:,:,2),B(:,:,2));
r3=corr2(anhGoc(:,:,3),B(:,:,3));
r=(r1+r2+r3)/3;
set(handles.txtSh2,'String',r);


p = PSNR_RGB(anhGoc,B);
set(handles.txtSh1,'String',p);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gaussian
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhGoc=imread(strcat(anhmau,fname));
axes(handles.axes1)             %Fisso l'axes per il plot
imshow(anhGoc)
handles.anhGoc=anhGoc;
guidata(hObject, handles);
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname anhmau]=uigetfile({'*.jpg;*.png;*.tif;*bmp'},'Chon Anh'); %select image
anhThuyVan=imread(strcat(anhmau,fname));
axes(handles.axes2)             %Fisso l'axes per il plot
imshow(anhThuyVan)
handles.anhThuyVan=anhThuyVan;
guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rotation;


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nenjpeg;
