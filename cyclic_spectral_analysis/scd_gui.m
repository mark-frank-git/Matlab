function varargout = scd_gui(varargin)
%SCD_GUI MField-file for scd_gui.fig
%      SCD_GUI, by itself, creates a new SCD_GUI or raises the existing
%      singleton*.
%
%      H = SCD_GUI returns the handle to a new SCD_GUI or the handle to
%      the existing singleton*.
%
%      SCD_GUI('Property','Value',...) creates a new SCD_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to scd_gui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SCD_GUI('CALLBACK') and SCD_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SCD_GUI.MField with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scd_gui

% Last Modified by GUIDE v2.5 20-Jul-2005 14:21:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scd_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @scd_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% -------------------------------------------------------------------------
% --- Executes just before scd_gui is made visible.
function scd_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for scd_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%
% Load default values for the structures from file
%
pass	= Check_And_Load([],handles);
handles;

% UIWAIT makes scd_gui wait for user response (see UIRESUME)
% uiwait(handles.SCD_GUI);

% -------------------------------------------------------------------------
function pass = Check_And_Load(file,handles)
%
% Set up the waveform and scd structures default values
%
waveform_struct = struct('fs', 10000, ...
                   'signalType',  1, ...
                   'codeType',  1, ...
                   'snr',  20., ...
                   'codeLength', 16, ...
                   'samplesPerChip', 1, ...
				   'frequency1', 2000, ...
				   'frequency2', 4000, ...
				   'pri', 100, ...
				   'numberSamples', 1024);

scd_struct = struct('scdType', 1, ...
				   'overlapSize', 4, ...
					'Np', 128, ...
					'M', 8);

% Initialize the variable "pass" to determine if this is a valid file.
pass = 0;

% If called without any file then set file to the default file name.
% Otherwise if the file exists then load it.
if isempty(file)
    file = 'scd_gui.mat';
    handles.LastFile = file;
	guidata(handles.SCD_GUI, handles);		% Save modified handles
end

exist(file)
if exist(file) == 2
	data	= load(file);
    pass	= 1;
end
% Validate the MAT-file
% The file is valid if it has variables called 'waveform_struct' and 'scd_struct'.
if pass
  flds = fieldnames(data);
  if (length(flds) == 2) & (strcmp(flds{1},'waveform_struct'))
    waveform_struct = getfield(data, 'waveform_struct');
    scd_struct		= getfield(data, 'scd_struct');
	pass			= 1;
  else
	pass			= 0;
  end
end
%
% Save the structs in the handles
%
handles.waveform_struct	= waveform_struct;
handles.scd_struct		= scd_struct;
guidata(handles.SCD_GUI, handles);			% save modified handles
handles;
% If the file is valid, display it
if pass
    % Do nothing
else
    errordlg('Not a valid SCD file','SCD File Error')
end
loadFields(handles);						% load the fields with the default
											% values

% -------------------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = scd_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% -------------------------------------------------------------------------
% ---
function loadFields(handles)
% handles    structure with handles and user data (see GUIDATA)
% This function loads the values of the structures to the GUI fields
%
set(handles.LField,			'String',num2str(handles.scd_struct.overlapSize));
set(handles.SCDTypeMenu,	'Value', handles.scd_struct.scdType);
set(handles.NField,			'String',num2str(handles.waveform_struct.numberSamples));
set(handles.PRIField,		'String',num2str(handles.waveform_struct.pri));
set(handles.f2Field,		'String',num2str(handles.waveform_struct.frequency2));
set(handles.f1Field,		'String',num2str(handles.waveform_struct.frequency1));
set(handles.samplesPerChipField, ...
							'String',num2str(handles.waveform_struct.samplesPerChip));
set(handles.lengthField,	'String',num2str(handles.waveform_struct.codeLength));
set(handles.SNRField,		'String',num2str(handles.waveform_struct.snr));
set(handles.CodeTypeMenu,	'Value', handles.waveform_struct.codeType);
set(handles.SignalTypeMenu,	'Value', handles.waveform_struct.signalType);
set(handles.fsField,		'String',handles.waveform_struct.fs);
set(handles.MField,			'String',handles.scd_struct.M);
set(handles.NpField,		'String',handles.scd_struct.Np);




% ------------------------------------------------------------
% Callback for fsField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function fsField_Callback(hObject, eventdata, handles)
% hObject    handle to fsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fsField as text
%        str2double(get(hObject,'String')) returns contents of fsField as a double
	handles.waveform_struct.fs	= str2double(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles

% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function fsField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fsField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for SignalTypeMenu
% ------------------------------------------------------------
% -------------------------------------------------------------------------
% --- Executes on selection change in SignalTypeMenu.
function SignalTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to SignalTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SignalTypeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SignalTypeMenu
	handles.waveform_struct.signalType	= get(hObject,'Value');
	guidata(handles.SCD_GUI, handles);			% save modified handles

% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function SignalTypeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% ------------------------------------------------------------
% Callback for CodeTypeMenu
% ------------------------------------------------------------
% -------------------------------------------------------------------------
% --- Executes on selection change in CodeTypeMenu.
function CodeTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to CodeTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns CodeTypeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CodeTypeMenu
	handles.waveform_struct.codeType	= get(hObject, 'Value');
	guidata(handles.SCD_GUI, handles);			% save modified handles

% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function CodeTypeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CodeTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for SNRField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function SNRField_Callback(hObject, eventdata, handles)
% hObject    handle to SNRField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNRField as text
%        str2double(get(hObject,'String')) returns contents of SNRField as a double
	handles.waveform_struct.snr	= str2double(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles

% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function SNRField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNRField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for codeLengthField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function lengthField_Callback(hObject, eventdata, handles)
% hObject    handle to lengthField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengthField as text
%        str2double(get(hObject,'String')) returns contents of lengthField as a double
	handles.waveform_struct.codeLength	= str2num(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function lengthField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengthField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for samplesPerChipField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function samplesPerChipField_Callback(hObject, eventdata, handles)
% hObject    handle to samplesPerChipField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplesPerChipField as text
%        str2double(get(hObject,'String')) returns contents of samplesPerChipField as a double
	handles.waveform_struct.samplesPerChip	= str2num(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function samplesPerChipField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplesPerChipField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for f1Field
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function f1Field_Callback(hObject, eventdata, handles)
% hObject    handle to f1Field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f1Field as text
%        str2double(get(hObject,'String')) returns contents of f1Field as a double
	handles.waveform_struct.frequency1	= str2double(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function f1Field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1Field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for f2Field
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function f2Field_Callback(hObject, eventdata, handles)
% hObject    handle to f2Field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f2Field as text
%        str2double(get(hObject,'String')) returns contents of f2Field as a double
	handles.waveform_struct.frequency2	= str2double(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function f2Field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2Field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for PRIField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function PRIField_Callback(hObject, eventdata, handles)
% hObject    handle to PRIField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PRIField as text
%        str2double(get(hObject,'String')) returns contents of PRIField as a double
	handles.waveform_struct.pri		= str2num(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function PRIField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PRIField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for NField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function NField_Callback(hObject, eventdata, handles)
% hObject    handle to NField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NField as text
%        str2double(get(hObject,'String')) returns contents of NField as a double
	handles.waveform_struct.numberSamples	= str2num(get(hObject,'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function NField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ------------------------------------------------------------
% Callback for SCDTypeMenu
% ------------------------------------------------------------
% -------------------------------------------------------------------------
% --- Executes on selection change in SCDTypeMenu.
function SCDTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to SCDTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SCDTypeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SCDTypeMenu
	handles.scd_struct.scdType		= get(hObject, 'Value');
	guidata(handles.SCD_GUI, handles);			% save modified handles


% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function SCDTypeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SCDTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ------------------------------------------------------------
% Callback for LField
% ------------------------------------------------------------
% -------------------------------------------------------------------------
function LField_Callback(hObject, eventdata, handles)
% hObject    handle to LField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LField as text
%        str2double(get(hObject,'String')) returns contents of LField as a double
	handles.scd_struct.overlapSize		= str2num(get(hObject, 'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles
% -------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function LField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% ------------------------------------------------------------
% Callback for NpField
% ------------------------------------------------------------
function NpField_Callback(hObject, eventdata, handles)
% hObject    handle to NpField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NpField as text
%        str2double(get(hObject,'String')) returns contents of NpField as a double
	handles.scd_struct.Np				= str2num(get(hObject, 'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% --- Executes during object creation, after setting all properties.
function NpField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NpField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% ------------------------------------------------------------
% Callback for MField
% ------------------------------------------------------------
function MField_Callback(hObject, eventdata, handles)
% hObject    handle to MField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MField as text
%        str2double(get(hObject,'String')) returns contents of MField as a double
	handles.scd_struct.M				= str2num(get(hObject, 'String'));
	guidata(handles.SCD_GUI, handles);			% save modified handles


% --- Executes during object creation, after setting all properties.
function MField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% ------------------------------------------------------------
% Callback for Plot button
% ------------------------------------------------------------
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%munlock('plotSCDForStructures');
%clear plotSCDForStructures;
%munlock('plotSCD');
clear plotSCD;
plotSCDForStructures(handles.waveform_struct, handles.scd_struct);

% ------------------------------------------------------------
% Callback for Save menu - saves to default file
% ------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Save to the default scd file
waveform_struct	= handles.waveform_struct;
scd_struct		= handles.scd_struct;
File = handles.LastFile;
save(File, 'waveform_struct');
save(File, 'scd_struct', '-append');


% ------------------------------------------------------------
% Callback for Open menu - displays an open dialog
% ------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Use UIGETFILE to allow for the selection of a custom address book.
[filename, pathname] = uigetfile( ...
    {'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, ...
    'Select scd file');
% If "Cancel" is selected then return
if isequal([filename,pathname],[0,0])
    return
    % Otherwise construct the fullfilename and Check and load the file.
else
    File = fullfile(pathname,filename);
    % if the MAT-file is not valid, do not save the name
    if Check_And_Load(File,handles)
        handles.LastFile = File;
        guidata(h,handles)
    end
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% Save the current settings
%
close;


% --- Executes during object deletion, before destroying properties.
function SCD_GUI_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to SCD_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Save_Callback(hObject, eventdata, handles);

