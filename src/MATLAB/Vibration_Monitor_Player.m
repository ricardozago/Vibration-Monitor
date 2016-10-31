function varargout = Vibration_Monitor_Player(varargin)
% VIBRATION_MONITOR_PLAYER MATLAB code for Vibration_Monitor_Player.fig
%      VIBRATION_MONITOR_PLAYER, by itself, creates a new VIBRATION_MONITOR_PLAYER or raises the existing
%      singleton*.
%
%      H = VIBRATION_MONITOR_PLAYER returns the handle to a new VIBRATION_MONITOR_PLAYER or the handle to
%      the existing singleton*.
%
%      VIBRATION_MONITOR_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATION_MONITOR_PLAYER.M with the given input arguments.
%
%      VIBRATION_MONITOR_PLAYER('Property','Value',...) creates a new VIBRATION_MONITOR_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibration_Monitor_Player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibration_Monitor_Player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibration_Monitor_Player

% Last Modified by GUIDE v2.5 31-Oct-2016 15:54:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibration_Monitor_Player_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibration_Monitor_Player_OutputFcn, ...
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


% --- Executes just before Vibration_Monitor_Player is made visible.
function Vibration_Monitor_Player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibration_Monitor_Player (see VARARGIN)

% Choose default command line output for Vibration_Monitor_Player
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibration_Monitor_Player wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibration_Monitor_Player_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Flag para controlar a correta ou não abertura dos dados
lido=0;

%Verifica se algum arquivo já foi escolhido
if strcmp(get(handles.text10,'string'),'Selecione um arquivo')==1
    %Caso não abre uma janela de dialogo pedindo um arquivo
    [filename,pathname] = uigetfile('*.vibra','Escolha o arquivo');
    %Verifica o retorno do usuário
    if isequal(filename,0) || isequal(pathname,0)
        %Se não escolheu arquivo
        set(handles.text10,'string', 'Selecione um arquivo');
    else
        %Se escolheu um arquivo, manda para o textbox
        set(handles.text10,'string', fullfile(pathname,filename));
        %Lê o arquivo na matrix dados
        dados = dlmread(get(handles.text10,'string'));
        %Muda a flag
        lido=1;
    end
else
    %Caso já existisse um arquivo lido anteriormente, ele apenas lê, sem
    %pedir ao usuário para escolher novamente
    dados = dlmread(get(handles.text10,'string'));
    %Muda a flag
    lido=1;
end

%Se o usuário escolheu algum arquivo, ele entra em exercução
if lido==1
    %Muda o checkbox para mostrar que está reproduzindo
    set(handles.checkbox6,'value',1);
    %Muda status do botão, é uma flag para controle da execução
    set(handles.pushbutton3,'Userdata',0);
    %Inicializa variáveis
    amostrasps=dados(1,2);
    estado=dados(:,3);
    for i=1:amostrasps
        y(i)=i/amostrasps;
    end
    dados(:,1) = [];
    dados(:,1) = [];
    dados(:,1) = [];
    [ultimo,amostrasps]=size(dados);
    %ultimo é a quantidade de dados, divide por 3 devido ao x, y e z
    ultimo=int32(ultimo/3);
    
    %Começa sempre do 1
    i=1;
    %Inicializa a barra de reprodução
    set(handles.slider1,'value',0);
    %Inicializa a variavel da barra de reprodução
    posicaopassada=0;
    
    %Percorre todas as posições do arquivo
    while i<=ultimo
        %Verifica se o usuário cancelou a reprodução
        if get(handles.pushbutton3,'Userdata')==1
            set(handles.text6,'string', 'Parado');
            set(handles.text9,'string', 'Parado');
            break;
        end
        
        %Verifica se ele alterou a posição da barra de reprodução
        if posicaopassada~=get(handles.slider1,'value')
           i=int32(get(handles.slider1,'value')*30+1);
        end
        
        %calcula o módulo
        dadosmodulo=(dados(1+3*(i-1),:).^2+dados(2+3*(i-1),:).^2+dados(3+3*(i-1),:).^2).^(1/2);
        
        %Atualiza a informação sobre modo de operação
        if estado(1+3*(i-1))==1
            set(handles.text6,'string', 'Modo 2g com filtro passa alta ligado');
        elseif estado(1+3*(i-1))==2
            set(handles.text6,'string', 'Modo 4g com filtro passa alta ligado');
        elseif estado(1+3*(i-1))==3
            set(handles.text6,'string', 'Modo 8g com filtro passa alta ligado');
        elseif estado(1+3*(i-1))==4
            set(handles.text6,'string', 'Modo 2g com filtro passa alta desligado');
        elseif estado(1+3*(i-1))==5
            set(handles.text6,'string', 'Modo 4g com filtro passa alta desligado');
        elseif estado(1+3*(i-1))==6
            set(handles.text6,'string', 'Modo 8g com filtro passa alta desligado');
        end
        
        %Atualiza o contador de tempo
        if get(handles.checkbox6,'value')==0
            set(handles.text9,'string', ['Pausado ' num2str(i) ' de ' num2str(ultimo)  ' segundos.']);
        else
            set(handles.text9,'string', ['Reproduzindo ' num2str(i) ' de ' num2str(ultimo)  ' segundos.']);
        end
        
        
        %Atualiza a barra de rolagem
        set(handles.slider1,'value',double(i-1)/double(ultimo-1));
        
        posicaopassada=get(handles.slider1,'value');
        
        %Verifica se ele quer plotar o módulo ou os eixos
        if(get(handles.popupmenu5,'Value')==1)
            plot(handles.axes_time,y,dados(1+3*(i-1),:),y,dados(2+3*(i-1),:),y,dados(3+3*(i-1),:));
        
            if estado(1+3*(i-1))==1||estado(1+3*(i-1))==4
                axis(handles.axes_time,[0 1 -2.5 2.5])
            elseif estado(1+3*(i-1))==2||estado(1+3*(i-1))==5
                axis(handles.axes_time,[0 1 -4.5 4.5])
            elseif estado(1+3*(i-1))==3||estado(1+3*(i-1))==6
                axis(handles.axes_time,[0 1 -8.5 8.5])
            end

            grid(handles.axes_time);
            title(handles.axes_time,'Aceleração por tempo (Janela de 1 segundo)')
            xlabel(handles.axes_time,'Tempo (s)')
            ylabel(handles.axes_time,'Aceleração (g)')
            legend(handles.axes_time,'X','Y','Z')

        elseif(get(handles.popupmenu5,'Value')==2)

            plot(handles.axes_time,y,dadosmodulo);

            if estado(1+3*(i-1))==1||estado(1+3*(i-1))==4
                axis(handles.axes_time,[0 1 0 3.5])
            elseif estado(1+3*(i-1))==2||estado(1+3*(i-1))==5
                axis(handles.axes_time,[0 1 0 5])
            elseif estado(1+3*(i-1))==3||estado(1+3*(i-1))==6
                axis(handles.axes_time,[0 1 0 8])
            end
            grid(handles.axes_time);
            title(handles.axes_time,'Aceleração por tempo (Janela de 1 segundo)')
            xlabel(handles.axes_time,'Tempo (s)')
            ylabel(handles.axes_time,'Módulo da Aceleração (g)')
        end
        
        %FFT
        Fs = amostrasps;     % Frequência de Amostragem
        L = amostrasps;      % Comprimento do sinal

        NFFT = 2^nextpow2(L); % Próxima potência de 2

        Yx = fft(dados(1+3*(i-1),:),NFFT)/L;
        Yy = fft(dados(2+3*(i-1),:),NFFT)/L;
        Yz = fft(dados(3+3*(i-1),:),NFFT)/L;
        Yxyz=(Yx.^2+Yy.^2+Yz.^2).^(1/2);
        
        f = Fs/2*linspace(0,1,NFFT/2+1);
        
        %verifica de qual eixo ele quer a FFT ou do módulo
        if(get(handles.popupmenu6,'Value')==1)
            plot(handles.axes_freq,f,mag2db(2*abs(Yxyz(1:NFFT/2+1))));
        elseif(get(handles.popupmenu6,'Value')==2)
            plot(handles.axes_freq,f,mag2db(2*abs(Yx(1:NFFT/2+1))));
        elseif(get(handles.popupmenu6,'Value')==3)
            plot(handles.axes_freq,f,mag2db(2*abs(Yy(1:NFFT/2+1))));
        else
            plot(handles.axes_freq,f,mag2db(2*abs(Yz(1:NFFT/2+1))));
        end

        %Coloca as legendas
        axis(handles.axes_freq,[0 ceil(amostrasps/2) -100 0])
        grid(handles.axes_freq);
        title(handles.axes_freq,'FFT do Sinal')
        xlabel(handles.axes_freq,'Frequência (Hz)')
        ylabel(handles.axes_freq,'|Y(f)| (dB)')
        
        %Verifica o ponto de maior amplitude da FFT
        a=mag2db(2*abs(Yxyz(1:NFFT/2+1)));
        valor=20;
        for temp=20:length(a)
            if a(temp)>a(valor)
                valor=temp;
            end 
        end
        set(handles.text5,'string', strcat(num2str(f(valor)),' Hz'));
        
        %Verifica a velocidade de reprodução e usa o delay adequado
        if(get(handles.popupmenu7,'Value')==1)
            pause(0.25);
        elseif(get(handles.popupmenu7,'Value')==2)
            pause(0.5);
        elseif(get(handles.popupmenu7,'Value')==3)
            pause(1);
        else
            pause(2);
        end
        
        %Verifica se está pausado
        if get(handles.checkbox6,'value')==1
        i=i+1;
        end
    end
end
set(handles.checkbox6,'value',0);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton3,'Userdata',1);



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Abre o arquivo
[filename,pathname] = uigetfile('*.vibra','Escolha o arquivo');

%Verifica se o usuário escolheu algo
if isequal(filename,0) || isequal(pathname,0)
    set(handles.text10,'string', 'Selecione um arquivo');
else
    set(handles.text10,'string', fullfile(pathname,filename));
end


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Vibration_Monitor_Player);
Vibration_Monitor
