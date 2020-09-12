function varargout = ProjeArayuz(varargin)


%load('derinAg4.mat'); %Buradan içeri aktarým yap***************//*/*/*/


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjeArayuz_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjeArayuz_OutputFcn, ...
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


% --- Executes just before ProjeArayuz is made visible.
function ProjeArayuz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProjeArayuz (see VARARGIN)

% Choose default command line output for ProjeArayuz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
   iconum1 = imread ( 'hosgeldiniz.png' );
   iconum = imresize (iconum1,[64,64]);
   uiwait(msgbox("Alfabe Tanima  uygulamasýna Hoþgeldiniz...","Alfabe Tanima","custom",iconum));
  
% UIWAIT makes ProjeArayuz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProjeArayuz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resimSecBtn.
function resimSecBtn_Callback(hObject, eventdata, handles)
% hObject    handle to resimSecBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resim
[dosyaAdi,dosyaYolu] = uigetfile({'*.png';'*.jpg';'*.bmp'});
if dosyaAdi==0
    msgbox(sprintf('Lütfen Bir Resim Seçiniz.'),'HATA','Error')
end
axes(handles.axes1)
resim=imread(fullfile(dosyaYolu,dosyaAdi));
imshow(resim);
set(handles.edit3,'String','Bir resim seçildi.')

% --- Executes on button press in agYukle.
function agYukle_Callback(hObject, eventdata, handles)
% hObject    handle to agYukle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit3,'String','Ag Yukleniyor.')
try 
    evalin('base',"load('derinAg4.mat')");
    set(handles.edit3,'String','Ag Yuklendi.')
catch
    f1=msgbox(MException.message+"Ag yuklenemedi-Lutfen uygulamayý sonlandýrýnýz."," Hata Olustu...","error");
end

% --- Executes on button press in bilgilenBtn.
function bilgilenBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bilgilenBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mesaj;
mesaj='Uygulama açýldýktan sonra, ilk olarak aðý yükle butonuna týklayýnýz. Að yüklendikten  sonra resim seç butonuna týklayarak açýlan pencereden bir test resmi seçiniz. Test resmi seçildikten sonra doðrula butonuna týklayarak seçilen resimdeki harfi doðru tanýyýp tanýmadýðýný görebilirsiniz.';
f=msgbox(mesaj,'Bilgilendirme','help');
% --- Executes on button press in dogrulaBtn.
function dogrulaBtn_Callback(hObject, eventdata, handles)
% hObject    handle to dogrulaBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resim
%global indis
try
    net = evalin('base', 'net1');
    [Pred scores]=classify(net,resim);
    [sonuc,indis]=max(scores);
    if (Pred=='A') 
        set(handles.edit2,'String','a');
    elseif (Pred=='B')
        set(handles.edit2,'String','b');
    elseif (Pred=='D')
        set(handles.edit2,'String','d');
    elseif (Pred=='E')
        set(handles.edit2,'String','e')
    elseif (Pred=='F')
        set(handles.edit2,'String','f')
    elseif (Pred=='G')
        set(handles.edit2,'String','g')    
    elseif (Pred=='H')
        set(handles.edit2,'String','h')
    elseif (indis==8)
        set(handles.edit2,'String','i')
    elseif (Pred=='K')
        set(handles.edit2,'String','k')
    elseif (Pred=='M')
        set(handles.edit2,'String','m')
    elseif (Pred=='Ö')
        set(handles.edit2,'String','ö')
    elseif (Pred=='P')
        set(handles.edit2,'String','p')
    elseif (Pred=='R')
        set(handles.edit2,'String','r')
    elseif (indis+1==14)
        set(handles.edit2,'String','þ')
    elseif (Pred=='T')
        set(handles.edit2,'String','t')
    elseif (Pred=='V')
        set(handles.edit2,'String','v')
    elseif (Pred=='Y')
        set(handles.edit2,'String','y')
    elseif (Pred=='Z')
        set(handles.edit2,'String','z')
    end
catch MException
    f1=msgbox(MException.message+"Uygulamayý Sonlandýr"," Hata Olustu...","error");   
end

    

% --- Executes on button press in cikisBtn.
function cikisBtn_Callback(hObject, eventdata, handles)
% hObject    handle to cikisBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();

