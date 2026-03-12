// LED 闪烁代码
#include<wiringPi.h>

#define LED 7

int main()
{
    if(wiringPiSetup() == -1)
        return -1;
    pinMode(LED,OUTPUT);

    for(int i=0;i<10;i++)
    {

        digitalWrite(LED,1);
        delay(1000);
        // 
        digitalWrite(LED,0);
        delay(1000);
    }
    
    digitalWrite(LED,1);
    return 0;
}
