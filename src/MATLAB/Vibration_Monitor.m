function varargout = Vibration_Monitor(varargin)
% Vibration_Monitor MATLAB code for Vibration_Monitor.fig
%      Vibration_Monitor, by itself, creates a new Vibration_Monitor or raises the existing
%      singleton*.
%
%      H = Vibration_Monitor returns the handle to a new Vibration_Monitor or the handle to
%      the existing singleton*.
%
%      Vibration_Monitor('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Vibration_Monitor.M with the given input arguments.
%
%      Vibration_Monitor('Property','Value',...) creates a new Vibration_Monitor or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibration_Monitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibration_Monitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibration_Monitor

% Last Modified by GUIDE v2.5 31-Oct-2016 15:53:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibration_Monitor_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibration_Monitor_OutputFcn, ...
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


% --- Executes just before Vibration_Monitor is made visible.
function Vibration_Monitor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibration_Monitor (see VARARGIN)

% Choose default command line output for Vibration_Monitor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibration_Monitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);
atualizarlistacom(handles);


% --- Outputs from this function are returned to the command line.
function varargout = Vibration_Monitor_OutputFcn(hObject, eventdata, handles) 
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

priorPorts = instrfind; %Lista todas as portas abertas
delete(priorPorts); %Apaga todas as portas abertas

list=get(handles.popupmenu2,'String'); %Retorna a porta selecionada (listada por outra função

if strcmp(list,'Nenhuma placa')==1
    msgbox('Nenhuma selecionada'); %Caso não seja selecionada nenhuma
else
    amostrasps=817; %Capacidade de amostragem da placa
    salvaremarquivo=0; %inicia a variável flag de gravação

    %Verifica se o usuário quer gravar
    if get(handles.checkbox3,'value')==1
        %Caso sim, abre uma janela para o usuário escolher a localização
        [filename, pathname]=uiputfile('record.vibra','Salvar aquivo');
        %Caso o usuário cancele
        if isequal(filename,0) || isequal(pathname,0)
            set(handles.checkbox3,'value',0);
        else
            %Mostra a localização
            disp(['User selected ',fullfile(pathname,filename)])
            %Inicia a matriz que irá salvar as leituras
            arquivo=zeros(1,amostrasps);
            %Muda a flag
            salvaremarquivo=1;
        end
    end

    %inicia a porta selecionada no popupmenu
    s = serial(char(list(get(handles.popupmenu2,'Value'),:)));
    %Configura o BaudRate, tamanho do buffer e abre a interface de
    %comuniação
    s.BaudRate = 115200;
    s.InputBufferSize = 20000;
    fopen(s);

    %Eixo de tempo dos plots
    y=zeros(amostrasps,1);
    for i=1:amostrasps
    y(i)=i/amostrasps;
    end
    
    %Inicia as variáveis de leitura e controle
    dados=zeros(amostrasps,3);
    dadosmodulo=zeros(amostrasps);
    tempo=zeros(8);
    loopcontrol=zeros(2);
    
    %Muda o texto no programa para Rodando
    set(handles.text5,'string', 'Rodando');
    %Controle de execução
    set(handles.pushbutton3,'Userdata',0);
    
    %configura o estado inicial da placa como zero, para que na primeira
    %execução seja lido o GUI e atualizado
    estado=0;

    %Zera o contador de execuções (ou seja, quantos segundos ele já
    %mostrou)
    contadordeexe=0;
    %Envia um "a" para ativar a placa
    fwrite(s,'a','char');

    %Entra no loop de execução do programa
    while 1
        
        %Se a pessoa desabilitou o salvamento, muda a flag e grava as
        %informações no arquivo
        if get(handles.checkbox3,'value')==0&&salvaremarquivo==1
            salvaremarquivo=0;
            dlmwrite(fullfile(pathname,filename),arquivo);
        end
        
        %Caso a pessoa ligue no meio da execução (o que não é permitido)
        %desmarca a opção
        if get(handles.checkbox3,'value')==1&&salvaremarquivo==0
            set(handles.checkbox3,'value',0);
        end
        
        %Se a pessoa apertou o botão de parar
        if get(handles.pushbutton3,'Userdata')==1
            %desativa a placa
            fwrite(s,'b','char');
            %Fecha a comunicação
            fclose(s);
            %Se estava gravando, desmarca a caixa e salva os dados no
            %arquivo
            if salvaremarquivo==1
                set(handles.checkbox3,'value',0);
                dlmwrite(fullfile(pathname,filename),arquivo);
            end
            break;
        end

        %Verifica o modo que o usuário escolheu, entre filtro passa alta e
        %modo 2,4 e 8g
        %Estado 1: 2g com filtro passa alta ligado
        %Estado 2: 4g com filtro passa alta ligado
        %Estado 3: 8g com filtro passa alta ligado
        %Estado 4: 2g com filtro passa alta desligado
        %Estado 5: 4g com filtro passa alta desligado
        %Estado 6: 8g com filtro passa alta desligado
        if get(handles.checkbox1,'Value')==1
            if get(handles.popupmenu1,'Value')==1 && estado~=1
            estado=1;
            fwrite(s,'1','char');
            elseif get(handles.popupmenu1,'Value')==2 && estado~=2
            estado=2;
            fwrite(s,'2','char');
            elseif get(handles.popupmenu1,'Value')==3 && estado~=3
            estado=3;
            fwrite(s,'3','char');
            end
        elseif get(handles.checkbox1,'Value')==0
            if get(handles.popupmenu1,'Value')==1 && estado~=4
            estado=4;
            fwrite(s,'4','char');
            elseif get(handles.popupmenu1,'Value')==2 && estado~=5
            estado=5;
            fwrite(s,'5','char');
            elseif get(handles.popupmenu1,'Value')==3 && estado~=6
            estado=6;
            fwrite(s,'6','char');
            end
        end

        %Procura os 2 caracteres de sincronismo
        while 1
            loopcontrol=uint8(fread(s,2,'uint8'));
            if loopcontrol(1)==13 && loopcontrol(2)==10
               break
            elseif (loopcontrol(2)==13)
                temp=uint8(fread(s,1,'uint8'));
                if temp==10
                break
                end
            end
        end

        %Somente para descartar 6 itens no buffer
        int8(fread(s,6,'int8'));

        %Realiza a leitura de 1 segundo de dados da placa
        tempo = double(int8(fread(s,8*amostrasps,'int8')));

        %A depender do modo de operaçao trata esses dados, devido a
        %diferença de precisão entre 2, 4 e 8g
        if estado==1||estado==4
            for i=1:amostrasps
            dados(i,1)=(tempo(8*(i-1)+3)*64+tempo(8*(i-1)+4))/4096;
            dados(i,2)=(tempo(8*(i-1)+5)*64+tempo(8*(i-1)+6))/4096;
            dados(i,3)=(tempo(8*(i-1)+7)*64+tempo(8*(i-1)+8))/4096;
            end
        elseif estado==2||estado==5
            for i=1:amostrasps
            dados(i,1)=(tempo(8*(i-1)+3)*64+tempo(8*(i-1)+4))/2048;
            dados(i,2)=(tempo(8*(i-1)+5)*64+tempo(8*(i-1)+6))/2048;
            dados(i,3)=(tempo(8*(i-1)+7)*64+tempo(8*(i-1)+8))/2048;
            end
        elseif estado==3||estado==6
            for i=1:amostrasps
            dados(i,1)=(tempo(8*(i-1)+3)*64+tempo(8*(i-1)+4))/1024;
            dados(i,2)=(tempo(8*(i-1)+5)*64+tempo(8*(i-1)+6))/1024;
            dados(i,3)=(tempo(8*(i-1)+7)*64+tempo(8*(i-1)+8))/1024;
            end
        end

        %Plota x, y e z
        if(get(handles.popupmenu3,'Value')==1)
            %Plota os dados
            plot(handles.axes_time,y,dados);

            %Define os limites dos eixos conforme a precisão
            if estado==1||estado==4
                axis(handles.axes_time,[0 1 -2.5 2.5])
            elseif estado==2||estado==5
                axis(handles.axes_time,[0 1 -4.5 4.5])
            elseif estado==3||estado==6
                axis(handles.axes_time,[0 1 -8.5 8.5])
            end

            %Legendas
            grid(handles.axes_time);
            title(handles.axes_time,'Aceleração por tempo (Janela de 1 segundo)')
            xlabel(handles.axes_time,'Tempo (s)')
            ylabel(handles.axes_time,'Aceleração (g)')
            legend(handles.axes_time,'X','Y','Z')

        elseif(get(handles.popupmenu3,'Value')==2)
            %Faz o módulo
            dadosmodulo=(dados(:,1).^2+dados(:,2).^2+dados(:,3).^2).^(1/2);

            %Plota o módulo
            plot(handles.axes_time,y,dadosmodulo);

            %Define os limites dos eixos conforme a precisão
            if estado==1||estado==4
                axis(handles.axes_time,[0 1 0 3.5])
            elseif estado==2||estado==5
                axis(handles.axes_time,[0 1 0 5])
            elseif estado==3||estado==6
                axis(handles.axes_time,[0 1 0 8])
            end
            
            %Legendas
            grid(handles.axes_time);
            title(handles.axes_time,'Aceleração por tempo (Janela de 1 segundo)')
            xlabel(handles.axes_time,'Tempo (s)')
            ylabel(handles.axes_time,'Módulo da Aceleração (g)')
        end

        %Agora o FFT
        Fs = amostrasps;     % Frequência de Amostragem
        L = amostrasps;      % Tamanho do Sinal

        NFFT = 2^nextpow2(L); % A próxima potência de 2 do tamanho de y

        %Calcula a FFT dos 3 eixos
        Yx = fft(dados(1:amostrasps,1),NFFT)/L;
        Yy = fft(dados(1:amostrasps,2),NFFT)/L;
        Yz = fft(dados(1:amostrasps,3),NFFT)/L;
        
        %Do modulo
        Yxyz=(Yx.^2+Yy.^2+Yz.^2).^(1/2);
        f = Fs/2*linspace(0,1,NFFT/2+1);

        %Plota a FFT e cria um vetor de magnitude o eixo escolhido
        if(get(handles.popupmenu4,'Value')==1)
            plot(handles.axes_freq,f,mag2db(2*abs(Yxyz(1:NFFT/2+1))));
            mag=mag2db(2*abs(Yxyz(1:NFFT/2+1)));
        elseif(get(handles.popupmenu4,'Value')==2)
            plot(handles.axes_freq,f,mag2db(2*abs(Yx(1:NFFT/2+1))));
            mag=mag2db(2*abs(Yx(1:NFFT/2+1)));
        elseif(get(handles.popupmenu4,'Value')==3)
            plot(handles.axes_freq,f,mag2db(2*abs(Yy(1:NFFT/2+1))));
            mag=mag2db(2*abs(Yy(1:NFFT/2+1)));
        else
            plot(handles.axes_freq,f,mag2db(2*abs(Yz(1:NFFT/2+1))));
            mag=mag2db(2*abs(Yz(1:NFFT/2+1)));
        end

        %Legendas
        axis(handles.axes_freq,[0 ceil(amostrasps/2) -100 0])
        grid(handles.axes_freq);
        title(handles.axes_freq,'FFT do Sinal')
        xlabel(handles.axes_freq,'Frequência (Hz)')
        ylabel(handles.axes_freq,'|Y(f)| (dB)')

        %Para calcular a frequência de maior amplitude, cortando a parte
        %constante
        valor=20;
        for i=20:length(mag)
            if mag(i)>mag(valor)
                valor=i;
            end 
        end
        %Exibe a frequência de maior amplitude
        set(handles.text3,'string', strcat(num2str(f(valor)),' Hz'));

        %Se o usuário está salvando os arquivos
        if salvaremarquivo==1
            %trata os dados para gravação na matriz que será transferida
            %para o arquivo de texto
            temp1=[contadordeexe;contadordeexe;contadordeexe];
            temp2=[amostrasps;amostrasps;amostrasps];
            temp3=[estado;estado;estado];
            temp=[temp1,temp2,temp3,dados'];

            %Verifica se é a primeira execução
            if numel(arquivo)==amostrasps
                arquivo=temp;
            else
                arquivo=[arquivo;temp];  
            end

            %Grava a cada 10 segundos (lembrando que o final também é
            %gravado, é apenas uma segurança
            if mod(contadordeexe,10)==0
                %Grava no arquivo, esta é uma função que grava num arquivo
                %de texto uma matriz. É importante resaltar a importância
                %disso, pois a execução do programa é mais rápida usando
                %funções do matlab.
                dlmwrite(fullfile(pathname,filename),arquivo);
            end
        end

        %contador de execuções (quantos segundos)
        contadordeexe=contadordeexe+1;
        %pause para o matlab atualizar a interface
        pause(0.1);

    end
end
    
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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1% --- Executes on selection change in popupmenu2.
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
atualizarlistacom(handles);


function atualizarlistacom(handles)
priorPorts = instrfind; % finds any existing Serial Ports in MATLAB
delete(priorPorts);
info = instrhwinfo('serial');
%precisa testar caso exista mais de uma porta serial
if numel(info.AvailableSerialPorts)==0
   set(handles.popupmenu2,'String', 'Nenhuma placa');
else
    set(handles.popupmenu2,'String', info.AvailableSerialPorts);
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton3,'Userdata',1);
set(handles.text5,'string', 'Parado');


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Vibration_Monitor);
Vibration_Monitor_Player;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Programa Desenvolvido como projeto de final do curso de Engenharia Elétrica da Unicamp, pelo aluno Ricardo Mazza Zago em 2015, é regido pela licença GNU General Public License, version 2: http://www.gnu.org/licenses/gpl-2.0.html');
