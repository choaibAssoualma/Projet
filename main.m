%******fonctions de parametrage de la fenetre generé par le wygiwys a ne pas toucher***********
        function varargout = main(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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

         %fonction execute juste avant louverture
        function main_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

logo=imread('logo.png'); %charger le logo
axes(handles.axes15);
imshow(logo);
axes(handles.axes20);
im=imread('fenetre.png');
imshow(im); %afficher limage charge


        function varargout = main_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;






%******fonction des boutons   ***********







% bouton entrainer
function pushbutton13_Callback(hObject, eventdata, handles)
contents = get(handles.popupmenu8,'String'); 
  choix = contents{get(handles.popupmenu8,'Value')};
  switch choix
      case 'Reseaux de neurones'
        train
        helpdlg('réseaux de neurones entrainé avec succes',...
        'RN entrainement');
      case 'SVM'
       trainSVM
        helpdlg('machine à vecteur de support entrainé avec succes',...
        'SVM entrainement');
  end
         

     set(handles.pushbutton12,'Enable','on') %mettre le bouton charger a on


     

% ---(charger limage)
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[filename, pathname] = ...
uigetfile({'*.jpg';'*.jpeg';'*.png';'*.*'},'Select Image File');%recuperer le chemin
 I=strcat(pathname,filename); %concatener le chemin avec le nom du fichier

axes(handles.axes20); %limage va safficher dans le axes20 de linterface
imshow(I); %afficher limage charge

set(handles.pushbutton11,'Enable','on') %mettre le bouton de reconnaisance a on
set(handles.popupmenu8,'Enable','off')
helpdlg('Image chargé avec succes  ',...
        'chargement de limage');



% reconnaisance
function pushbutton11_Callback(hObject, eventdata, handles)


imagen=getimage;
contents = get(handles.popupmenu8,'String'); 
  choix = contents{get(handles.popupmenu8,'Value')};
  switch choix
      case 'Reseaux de neurones'
       RN(imagen);
       
      case 'SVM'
      SVM(imagen);
      
  end
set(handles.popupmenu8,'Enable','on')
%clear all
winopen('C:\Users\choaib\Desktop\Projet\test.txt'); %ouvrir le fichie a la fin
set(handles.pushbutton11,'Enable','off') %mettre le bouton de reconnaisance a off

%close (gcbf) %fermer la fenetre
%main %relancer le programme













%**************************************






















% --------------------------------------------------------------------
function Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



 




% --- Executes during object creation, after setting all properties.
function axes20_CreateFcn(hObject, eventdata, handles)
 
axis on





function axes15_CreateFcn(hObject, eventdata, handles)

axis off









% fonction pour quitter le programme
function Quitter_Callback(hObject, eventdata, handles)
% hObject    handle to Quitter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
conf=questdlg('voulez vous vraiment quitter lapplication','Quitter','Oui','Non','Non');
switch conf
    case 'Oui'
        close(gcf)
    case 'Non'
        return
end





% fonction pour ouvir apropos
function Apropos_Callback(hObject, eventdata, handles)
% hObject    handle to Apropos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open apropos.fig









% --- fonction execute si on resize le panel
function uipanel6_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
set(handles.pushbutton11,'Enable','off') %mettre le bouton de reconnaisance a off
set(handles.pushbutton12,'Enable','off') %mettre le bouton de chargement a off




% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
