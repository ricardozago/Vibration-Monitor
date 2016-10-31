/* ###################################################################
**     Filename    : main.c
**     Project     : Vibration Monitor
**     Processor   : MKL25Z128VLK4
**     Version     : Driver 01.01
**     Compiler    : GNU C Compiler
**     Date/Time   : 2015-03-26, 20:31, # CodeGen: 0
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.01
** @brief
**         Main module.
**         This module contains user's application code.
*/
/*!
**  @addtogroup main_module main module documentation
**  @{
*/
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "LEDRGB_GREEN.h"
#include "BitIoLdd1.h"
#include "LEDRGB_RED.h"
#include "BitIoLdd2.h"
#include "LEDRGB_BLUE.h"
#include "BitIoLdd3.h"
#include "I2C_ACCEL.h"
#include "USB_COMMUNICATION.h"
#include "TU1.h"
/* Including shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"
/* User includes (#include below this line is not maintained by Processor Expert) */
//Biblioteca necessária para uso da função sprintf para converter um número para ASCII
#include <stdio.h>

//Vetor que recebe a aceleração na leitura do acelerômetro
static int8_t xyz[6];

//Variáveis de controle do I2C de comunicação com o acelerômetro
int recebido;
int transmitido;

//Variáveis de controle da comunicação serial UART USB com o computador
int usbrecebido;
int usbtransmitido;

//Variável para controlar a interrupção a cada um segundo para controle de tempo
int umsegundo;

//Função para leitura de um endereço do acelerômetro
void ler(uint8_t addr, uint8_t *data, short dataSize)
{
    //Envia o endereço a ser lido para o acelerômetro
    I2C_ACCEL_MasterSendBlock(I2C_ACCEL_DeviceData, &addr, 1U, LDD_I2C_NO_SEND_STOP);
    //Aguarda confirmação da transmissão
    while(transmitido==0) {}
    //Retorna o valor da variável
    transmitido=0;
    //Recebe dado
    I2C_ACCEL_MasterReceiveBlock(I2C_ACCEL_DeviceData, data, dataSize, LDD_I2C_SEND_STOP);
    //Aguarda confirmação do recebimento
    while(recebido==0) {}
    //Retorna Valor da variável
    recebido=0;
}

void escrever(uint8_t addr, uint8_t val)
{
    //Cria um vetor para utilizar na função de envio
    uint8_t buf[2];
    //Endereço e valor são colocados no vetor
    buf[0] = addr;
    buf[1] = val;
    //Chama a função de Envio
    I2C_ACCEL_MasterSendBlock(I2C_ACCEL_DeviceData, &buf, 2U, LDD_I2C_SEND_STOP);
    while(transmitido==0) {}
    transmitido=0;
}

/*lint -save  -e970 Disable MISRA rule (6.3) checking. */
int main(void)
/*lint -restore Enable MISRA rule (6.3) checking. */
{
    /* Write your local variable definition here */
    //Zera as variáveis de controle de transmissão UART (USB) e I2C
    recebido=0;
    transmitido=0;
    usbrecebido=0;
    usbtransmitido=0;
    //Vetor de caracteres a ser transmitido para o computador via UART (USB)
    char caracteres[10];
    //Variável de controle do Fifo
    int8_t statusfifo;
    //Variável que ativa e desativa o programa, por default ativo
    int ativo=0;

    /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
    PE_low_level_init();
    /*** End of Processor Expert internal initialization.                    ***/

    /* Write your code here */
    /* For example: for(;;) { } */

    //Reparar que a ordem de ativação desativação do Acelerômetro, FIFO, Modo 2,4 e 8g importa

    //Desliga tudo
    //Pause Accel
    escrever(0x2A,  0b00000000);
    //Desliga FIFO
    escrever(0x09,  0b00000000);

    //XYZ_DATA_CFG Register
    //000a00bc
    // a = 1 -> ativa filtro passa alta
    // bc = 00 -> 2g
    // bc = 01 -> 4g
    // bc = 10 -> 8g
    escrever(0x0E,  0b00000000);

    //Liga o F_READ
    escrever(0x2A,  0b00000000);

    //Liga o FIFO
    //F_SETUP FIFO Setup Register
    //ab000000
    //00: FIFO desativado
    //01: FIFO circular
    //10: FIFO para de aceitar novos quando cheio
    escrever(0x09,  0b01000000);

    //CTRL_REG1
    //000000ab
    //a = 1 -> modo de leitura rápida
    //b = 1 -> modo ativo
    //Liga o Modo Ativo
    escrever(0x2A,  0b00000011);

    //Define a letra a ser enviada a cada segundo para controle de tempo
    //É utilizado apenas para calcular a taxa de amostragem máxima da placa
    /*
    char palavra800hz[2];
    palavra800hz[0]='s';
    //Caractere \n
    palavra800hz[1]=10;
    umsegundo=0;*/

    //Declara a variável para leitura de caracteres recebidos via porta serial
    char recebimento[1];
    USB_COMMUNICATION_ReceiveBlock(USB_COMMUNICATION_DeviceData, &recebimento, 1);

    for(;;)
    {
    	//Se algum dado foi recebido pela porta serial
        if(usbrecebido==1)
        {
        	//Para ativar a leitura do acelerometro e envio de dados
            if(recebimento[0]=='a')
            {
            	ativo=1;
            }
            //Para desativar a leitura do acelerometro e envio de dados
            if(recebimento[0]=='b')
            {
            	ativo=0;
            	//Desativa os LEDs
            	LEDRGB_GREEN_PutVal(1);
            	LEDRGB_RED_PutVal(1);
            	LEDRGB_BLUE_PutVal(1);
            }
            // 1 ativa o filtro passa baixo a 2g
            if(recebimento[0]=='1')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010000);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 2 ativa o filtro passa baixo a 4g
            if(recebimento[0]=='2')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010001);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 3 ativa o filtro passa baixo a 8g
            if(recebimento[0]=='3')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010010);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 4 desativa o filtro passa baixo a 2g
            if(recebimento[0]=='4')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000000);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 5 desativa o filtro passa baixo a 4g
            if(recebimento[0]=='5')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000001);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 6 desativa o filtro passa baixo a 8g
            if(recebimento[0]=='6')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000010);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            //zera a variável de recebimento
            recebimento[0]=0;
            //Espera receber o próximo dado
            USB_COMMUNICATION_ReceiveBlock(USB_COMMUNICATION_DeviceData, &recebimento, 1);
            usbrecebido=0;
        }

        //Se ativo
        if(ativo==1)
        {
            //Verifica se deve-se enviar caractere de controle de tempo, se sim envia
            /*if (umsegundo==1)
            {
                USB_COMMUNICATION_SendBlock(USB_COMMUNICATION_DeviceData,palavra800hz,2);
                while(usbtransmitido==0) {}
                usbtransmitido=0;
                umsegundo=0;
            }*/

            //Para aguardar até ter uma nova leitura no FIFO do acelerômetro
            ler(0x00,(uint8_t*)&statusfifo,1);
            while(((statusfifo)&&(0b00111111))==0)
            {
                ler(0x00,(uint8_t*)&statusfifo,1);
            }

            //Lê o acelerômetro
            ler(0x01, (uint8_t*)&xyz, 6);

            //Brincadeira com o LED RGB que acende uma cor a cada posição do Acelerômetro
            LEDRGB_GREEN_PutVal(1);
            LEDRGB_RED_PutVal(1);
            LEDRGB_BLUE_PutVal(1);
            if((xyz[0]>50)||(xyz[0]<-50))
            {
                LEDRGB_GREEN_PutVal(0);
            }
            if((xyz[2]>50)||(xyz[2]<-50))
            {
                LEDRGB_RED_PutVal(0);
            }
            if((xyz[4]>50)||(xyz[4]<-50))
            {
                LEDRGB_BLUE_PutVal(0);
            }

            //Formata da maneira esperada para envio
            caracteres[0]=xyz[0];
            caracteres[1]=(xyz[1]>>2)&0b00111111;
            caracteres[2]=xyz[2];
            caracteres[3]=(xyz[3]>>2)&0b00111111;
            caracteres[4]=xyz[4];
            caracteres[5]=(xyz[5]>>2)&0b00111111;
            caracteres[6]='\r';
            caracteres[7]='\n';

            //Envia via UART (USB)
            USB_COMMUNICATION_SendBlock(USB_COMMUNICATION_DeviceData,caracteres,8);
            while(usbtransmitido==0) {}
            usbtransmitido=0;
        }
    }

    /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.4 [05.11]
**     for the Freescale Kinetis series of microcontrollers.
**
** ###################################################################
*/
