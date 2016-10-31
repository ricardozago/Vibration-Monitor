#include "mbed.h"

#define MMA8451_I2C_ADDRESS (0x1d<<1)

//Inicia a comunicação USB e I2C
Serial pc(USBTX, USBRX);
I2C i2c(PTE25, PTE24);

//Para tratar os dados recebidos assincronamente do USB
int usb_rec;
char usb_valor;

//Para quando receber dado da USB
void callback() {
    usb_rec=1;
    usb_valor=pc.getc();
}

//LEDs
DigitalOut led_r(LED_RED);
DigitalOut led_g(LED_GREEN);
DigitalOut led_b(LED_BLUE);

//Para ler dados do acelerometro
void ler(char addr, char *data, int dataSize)
{
    //Envia o endereço a ser lido para o acelerômetro
    i2c.write(MMA8451_I2C_ADDRESS,&addr,1,true);
    
    //Recebe dado
    i2c.read(MMA8451_I2C_ADDRESS, (char *)data, dataSize);
}

//Para escreve no acelerometro
void escrever(char addr, char val)
{
    //Cria um vetor para utilizar na função de envio
    char buf[2];
    //Endereço e valor são colocados no vetor
    buf[0] = addr;
    buf[1] = val;
    //Chama a função de Envio
    i2c.write(MMA8451_I2C_ADDRESS,buf,2);
}

int main(void)
{
    char statusfifo;
    char xyz[6];
    char caracteres[8];
    int i;
    usb_rec=0;
    
    pc.baud(115200);
    i2c.frequency(400000);
    
    pc.attach(&callback);

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

    while (true) {
        //Quando recebe dados do USB
        if(usb_rec==1)
        {
            // 1 ativa o filtro passa baixo a 2g
            if(usb_valor=='1')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010000);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 2 ativa o filtro passa baixo a 4g
            if(usb_valor=='2')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010001);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 3 ativa o filtro passa baixo a 8g
            if(usb_valor=='3')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00010010);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 4 desativa o filtro passa baixo a 2g
            if(usb_valor=='4')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000000);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 5 desativa o filtro passa baixo a 4g
            if(usb_valor=='5')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000001);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            // 6 desativa o filtro passa baixo a 8g
            if(usb_valor=='6')
            {
                //Pause Accel
                escrever(0x2A,  0b00000000);
                //liga filtro a 2g
                escrever(0x0E,  0b00000010);
                //Liga o Modo Ativo
                escrever(0x2A,  0b00000011);
            }
            //zera a variável de recebimento
            usb_rec=0;
        }
        
        ler(0x00,&statusfifo,1);
        while(((statusfifo)&&(0b00111111))==0)
        {
            ler(0x00,&statusfifo,1);
        }
        
        ler(0x01, xyz, 6);
        
        led_r = 1;
        led_g = 1;
        led_b = 1;
        if(((int8_t)xyz[0]>50)||((int8_t)xyz[0]<-50))
        {
            led_g=0;
        }
        if(((int8_t)xyz[2]>50)||((int8_t)xyz[2]<-50))
        {
            led_r=0;
        }
        if(((int8_t)xyz[4]>50)||((int8_t)xyz[4]<-50))
        {
            led_b=0;
        }
       
        caracteres[0]=xyz[0];
        caracteres[1]=(xyz[1]>>2)&0b00111111;
        caracteres[2]=xyz[2];
        caracteres[3]=(xyz[3]>>2)&0b00111111;
        caracteres[4]=xyz[4];
        caracteres[5]=(xyz[5]>>2)&0b00111111;
        caracteres[6]='\r';
        caracteres[7]='\n';
        
        for(i=0;i<8;i++){
           pc.putc(caracteres[i]);
        }
    }
}
