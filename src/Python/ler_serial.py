#sudo apt-get install python3-dev
#sudo apt-get install libffi-dev
#sudo pip3 install cffi
#sudo pip3 install cairocffi

#sudo apt-get install python3-scipy

#sudo apt-get install tk-dev
#sudo pip3 uninstall matplotlib
#sudo pip3 install matplotlib

import serial #conda install pyserial
#No rasp pip install pyserial
import numpy as np
import matplotlib.pyplot as plt
import scipy.fftpack

def byte2int8(byte):
    if byte > 127:
        return (256-byte) * (-1)
    else:
        return byte

def mag2db(mag):
    return 20. * np.log10(mag)

def maxima_amplitude_na_FFT(mag):
    valor=20
    for i in range(20,len(mag)):
        if mag[i]>mag[valor]:
            valor=i
    return valor

ser = serial.Serial('COM7',115200,timeout=10) 
#print(ser)

plt.ion()
leituras_por_segundo=817

dados=np.zeros((leituras_por_segundo,3))

y=np.linspace(0.0, 1.0,num=817)

while 1:
    while 1:
        loopcontrol=ser.read(2)
        if ((loopcontrol[0]==13)and(loopcontrol[1]==10)):
            break
        elif (loopcontrol[1]==13):
            temp=ser.read(1)
            if temp==10:
                break

    tempo = ser.read(leituras_por_segundo*8)

    for i in range(0, leituras_por_segundo):
        dados[i,0]=(byte2int8(tempo[8*(i)])*64+tempo[8*(i)+1])/4096
        dados[i,1]=(byte2int8(tempo[8*(i)+2])*64+tempo[8*(i)+3])/4096
        dados[i,2]=(byte2int8(tempo[8*(i)+4])*64+tempo[8*(i)+5])/4096

    #print(dados)

    # Number of samplepoints
    N = leituras_por_segundo
    # sample spacing
    yf = scipy.fftpack.fft(dados[:,1])
    xf = np.linspace(0.0, N//2, num=N//2)

    plt.clf()
    plt.subplot(211)
    plt.title('No tempo')
    plt.plot(y,dados[:,0])
    plt.plot(y,dados[:,1])
    plt.plot(y,dados[:,2])
    plt.axis([0, 1, -2.5, 2.5])
    plt.subplot(212)
    plt.title('FFT')
    #plt.plot(xf, 2.0/N * np.abs(yf[:N//2]))
    plt.plot(xf, mag2db(2.0/N * np.abs(yf[:N//2])))
    plt.axis([0, leituras_por_segundo//2, -100, 0])
    plt.pause(0.05)

    #Para achar a frequência máxima
    print(maxima_amplitude_na_FFT(mag2db(2.0/N * np.abs(yf[:N//2]))))

ser.close()