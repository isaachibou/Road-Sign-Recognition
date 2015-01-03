function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 03-Jan-2015 14:55:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in prevButton.
function prevButton_Callback(hObject, eventdata, handles)
% hObject    handle to prevButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.index == 1)
    handles.index = size(handles.images, 1);
else 
    handles.index = handles.index - 1;
end
imagepath = strcat(handles.filepath,'\',handles.images(handles.index).name);
I = imread(imagepath);
axes(handles.image);
imshow(I);
launchRecognition(imagepath, handles);
guidata(hObject,handles);

% --- Executes on button press in nextButton.
function nextButton_Callback(hObject, eventdata, handles)
% hObject    handle to nextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.index == size(handles.images, 1))
    handles.index = 1;
else 
    handles.index = handles.index + 1;
end
imagepath = strcat(handles.filepath,'\',handles.images(handles.index).name);
I = imread(imagepath);
axes(handles.image);
imshow(I);
launchRecognition(imagepath, handles);
guidata(hObject, handles);

% --- Executes on button press in loadFolderButton.
function loadFolderButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadFolderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filepath = uigetdir(matlabroot,'Please select a directory');
set(handles.textBox,'String',filepath)
guidata(hObject, handles);
handles = updateImages(handles);
handles.index = 1;
handles.filepath = filepath;
guidata(hObject, handles);

% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.filepath = get(handles.textBox,'String');
handles = updateImages(handles);
handles.index = 1;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function launchRecognition(filepath, handles)
roadsigns = roadSignRecognition(filepath);
i = 0;
listSign = {handles.sign1, handles.sign2, handles.sign3, handles.sign4};
listRectangle = {handles.rectangle1, handles.rectangle2, handles.rectangle3, handles.rectangle4};
for i = 1:4
    axes(listSign{i});
    if i < (size(roadsigns, 2))
        signImage = getMatchingSign(roadsigns(i).id);
        imshow(signImage);
    else
        cla
    end
    axes(listRectangle{i})
    if i < (size(roadsigns, 2))
        signImage = roadsigns(i).image;
        imshow(signImage);
    else
        cla
    end
end
numSignsLeft = size(roadsigns, 2) - i;
if numSignsLeft < 0
    numSignLeft = 0;
end
set(handles.signText, 'String', strcat(num2str(numSignsLeft),' signs more'));

function handles = updateImages(handles)
filepath = get(handles.textBox, 'String');
if isequal(exist(filepath,'file'),2) % 2 means it's a file.
    handles.images = dir(fullfile(filepath));
    handles.filepath = filepath; %marche pas
elseif isequal(exist(filepath, 'dir'),7) % 7 = directory.
    handles.images = dir(fullfile(filepath, '/*.png')); 
    handles.filepath = filepath;
else
    display('Seems like path is not correct');
    return;
end

if(size(handles.images) > 0)
    imagepath = strcat(handles.filepath,'\',handles.images(1).name);
    I = imread(imagepath);
    axes(handles.image);
    imshow(I);
    launchRecognition(imagepath, handles);
end



function textBox_Callback(hObject, eventdata, handles)
% hObject    handle to textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textBox as text
%        str2double(get(hObject,'String')) returns contents of textBox as a double
handles.filepath = get(handles.textBox,'String');
handles = updateImages(handles);
handles.index = 1;
guidata(hObject,handles);
