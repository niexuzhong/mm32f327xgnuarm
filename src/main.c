/**
******************************************************************************
* @file     main.c
* @author   AE team
* @version  V1.0.1
* @date     23/11/2018
* @brief    
******************************************************************************
* @copy
*
* THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
* WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
* TIME. AS A RESULT, MindMotion SHALL NOT BE HELD LIABLE FOR ANY
* DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
* FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
* CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
*
* <h2><center>&copy; COPYRIGHT 2018 MindMotion</center></h2>
*/
#include "hal_device.h"
#include "hal_conf.h"
#include "stdio.h"
#include "pt-1.4/pt.h"

extern u32 SystemCoreClock;
void delay_init(void);
void delay_ms(__IO uint32_t nTime);
void TimingDelay_Decrement(void);
void LED_Init(void);

static __IO uint32_t TimingDelay;

#define LED1_Port  GPIOA
#define LED1_Pin   GPIO_Pin_15
#define LED1_ON()  GPIO_ResetBits(LED1_Port,LED1_Pin)	 
#define LED1_OFF()  GPIO_SetBits(LED1_Port,LED1_Pin)	 
#define LED1_TOGGLE()  (GPIO_ReadOutputDataBit(LED1_Port,LED1_Pin))?(GPIO_ResetBits(LED1_Port,LED1_Pin)):(GPIO_SetBits(LED1_Port,LED1_Pin))	 

#define LED2_Port  GPIOB
#define LED2_Pin   GPIO_Pin_3
#define LED2_ON()  GPIO_ResetBits(LED2_Port,LED2_Pin)	 
#define LED2_OFF()  GPIO_SetBits(LED2_Port,LED2_Pin)	 
#define LED2_TOGGLE()  (GPIO_ReadOutputDataBit(LED2_Port,LED2_Pin))?(GPIO_ResetBits(LED2_Port,LED2_Pin)):(GPIO_SetBits(LED2_Port,LED2_Pin))

#define LED3_Port  GPIOB
#define LED3_Pin   GPIO_Pin_4
#define LED3_ON()  GPIO_ResetBits(LED3_Port,LED3_Pin)	 
#define LED3_OFF()  GPIO_SetBits(LED3_Port,LED3_Pin)	 
#define LED3_TOGGLE()  (GPIO_ReadOutputDataBit(LED3_Port,LED3_Pin))?(GPIO_ResetBits(LED3_Port,LED3_Pin)):(GPIO_SetBits(LED3_Port,LED3_Pin))

#define LED4_Port  GPIOB
#define LED4_Pin   GPIO_Pin_5
#define LED4_ON()  GPIO_ResetBits(LED4_Port,LED4_Pin)	 
#define LED4_OFF()  GPIO_SetBits(LED4_Port,LED4_Pin)	 
#define LED4_TOGGLE()  (GPIO_ReadOutputDataBit(LED4_Port,LED4_Pin))?(GPIO_ResetBits(LED4_Port,LED4_Pin)):(GPIO_SetBits(LED4_Port,LED4_Pin))
uint32_t  systemTicks=0;
uint32_t  ledBlinkInterval=500;
typedef enum {KEYIDLE,KEYDOWN,KEYHOLD,KEYUP}keyStatusEnu;

typedef struct {
    uint16_t keyValue;
    keyStatusEnu  keyStatus;

}keyEvent;
keyEvent key;
struct pt keyPt,ledPt;
typedef struct  {
     uint32_t ledStartTick;
     uint32_t ledKeepTick;
}ledParmeter_t;

typedef struct {
    uint32_t keyPressingStartTick;
    uint32_t keyPressingHoldTick;
}keyPressTime_t;

ledParmeter_t  ledParameter;
keyPressTime_t  keyPressTimer;

void startLedTimer(uint32_t timeTick,uint32_t interval)
{
    ledParameter.ledStartTick=timeTick;
    ledParameter.ledKeepTick=interval;
}

uint32_t calTimeGap(uint32_t start,uint32_t end)
{
    if(start<=end){
        return end-start;
    }else{
        return 0xffffffff-start+end;
    }
}

void startKeyTimer(uint32_t timeTick,uint32_t interval)
{
    keyPressTimer.keyPressingStartTick=timeTick;
    keyPressTimer.keyPressingHoldTick=interval;
}
uint16_t checkKeyTimeExpired()
{
    if(calTimeGap(keyPressTimer.keyPressingStartTick,systemTicks)>keyPressTimer.keyPressingHoldTick){
       return 1;
    }else {
        return 0;
    }
}

uint16_t getKeyPressS(keyStatusEnu status)
{
    if(status==KEYDOWN){
       if(GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_10)==Bit_RESET)
           return 1;
       else
           return 0;
    }else{
       if(GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_10)==Bit_SET)
           return 1;
       else
           return 0;        
    }

}

uint16_t checkIfTimerExpired()
{
    if(calTimeGap(ledParameter.ledStartTick,systemTicks)>ledParameter.ledKeepTick){
        return 1;
    }else{
        return 0;
    }
}
static PT_THREAD(ledThread(struct pt *pt))
{
   PT_BEGIN(pt);
   while(1)
   {
      LED1_TOGGLE();
      startLedTimer(systemTicks,ledBlinkInterval);
      PT_WAIT_UNTIL(pt,checkIfTimerExpired());
      #if 0
      LED2_TOGGLE();
      startLedTimer(systemTicks,ledBlinkInterval);
      PT_WAIT_UNTIL(pt,checkIfTimerExpired());
      LED3_TOGGLE();
      startLedTimer(systemTicks,ledBlinkInterval);
      PT_WAIT_UNTIL(pt,checkIfTimerExpired());
      LED4_TOGGLE();
      startLedTimer(systemTicks,ledBlinkInterval);
      PT_WAIT_UNTIL(pt,checkIfTimerExpired());
      #endif
   }
   PT_END(pt);
}

static PT_THREAD(keyCheckThread(struct pt *pt))
{
    PT_BEGIN(pt);
    keyPressTimer.keyPressingHoldTick=200;
    while(1){       
       PT_WAIT_UNTIL(pt,getKeyPressS(KEYDOWN));
       startKeyTimer(systemTicks,20);
       PT_WAIT_UNTIL(pt,checkKeyTimeExpired());
       if(getKeyPressS(KEYDOWN)==0){
         key.keyValue=4;
         key.keyStatus=KEYDOWN;
         ledBlinkInterval=ledBlinkInterval+500;
       }else{
          continue;
       }
       while(1){
            startKeyTimer(systemTicks,200);
            PT_WAIT_UNTIL(pt,getKeyPressS(KEYUP)||checkKeyTimeExpired());
            if(getKeyPressS(KEYUP)==1)break;
            key.keyStatus=KEYHOLD;
       }
      
       key.keyStatus=KEYUP;      
       startKeyTimer(systemTicks,200);    
       PT_WAIT_UNTIL(pt,checkKeyTimeExpired());  
       key.keyStatus=KEYIDLE;
       key.keyValue=4;  
   }
   PT_END(pt);

}



int main(void)    
{
    delay_init();
    LED_Init();
    KEY_Init();
    while(1)             
    {
       keyCheckThread(&keyPt);
       ledThread(&ledPt);
    }
}


void delay_init(void)
{
    if (SysTick_Config(SystemCoreClock / 1000))
    { 
        /* Capture error */ 
        while (1);
    }
    /* Configure the SysTick handler priority */
    NVIC_SetPriority(SysTick_IRQn, 0x0);//SysTick�ж����ȼ�����
}


void SysTick_Handler(void)
{
    systemTicks++;
}


void TimingDelay_Decrement(void)
{
    if (TimingDelay != 0x00)
    { 
        TimingDelay--;
    }
}


void delay_ms(__IO uint32_t nTime)
{ 
    TimingDelay = nTime;
    
    while(TimingDelay != 0);
}

/*******************************************************************************
* @name   : GPIO_Clock_Set
* @brief  : RCC clock set
* @param  : Portx , State
* @retval : void
*******************************************************************************/
void GPIO_Clock_Set(GPIO_TypeDef* GPIOx, FunctionalState NewState)
{

    if(GPIOx == GPIOA)
    {
        RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOA, NewState);                         //GPIO clock starts  
    }
    if(GPIOx == GPIOB)
    {
        RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOB, NewState);                         //GPIO clock starts  
    }
    if(GPIOx == GPIOC)
    {
        RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOC, NewState);                         //GPIO clock starts  
    }
    if(GPIOx == GPIOD)
    {
        RCC_AHBPeriphClockCmd(RCC_AHBPeriph_GPIOD, NewState);                         //GPIO clock starts  
    }
}

void LED_Init(void)
{
    
    GPIO_InitTypeDef  GPIO_InitStructure;
   
    GPIO_Clock_Set(LED1_Port, ENABLE);  
    
    GPIO_InitStructure.GPIO_Pin  =  LED1_Pin;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(LED1_Port, &GPIO_InitStructure);

    
    LED1_OFF();

     GPIO_Clock_Set(LED2_Port, ENABLE);  
    
    GPIO_InitStructure.GPIO_Pin  =  LED2_Pin;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(LED2_Port, &GPIO_InitStructure);

    
    LED2_OFF();   


   //  GPIO_Clock_Set(LED3_Port, ENABLE);  
    
    GPIO_InitStructure.GPIO_Pin  =  LED3_Pin;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(LED3_Port, &GPIO_InitStructure);

    
    LED3_OFF();

 //    GPIO_Clock_Set(LED4_Port, ENABLE);  
    
    GPIO_InitStructure.GPIO_Pin  =  LED4_Pin;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(LED4_Port, &GPIO_InitStructure);

    
    LED4_OFF();      

}

#define KEY3_GPIO_Port                  GPIOB
#define KEY3_Pin                        GPIO_Pin_10
#define KEY4_GPIO_Port                  GPIOB
#define KEY4_Pin                        GPIO_Pin_0
#define KEY3_PIN_SOURCE                 GPIO_PinSource10
#define KEY4_PIN_SOURCE                 GPIO_PinSource0

void KEY_Init(void)
{
    GPIO_InitTypeDef GPIO_InitStruct;
    RCC_AHBPeriphClockCmd(RCC_AHBENR_GPIOA | RCC_AHBENR_GPIOB | RCC_AHBENR_GPIOC, ENABLE);

    GPIO_InitStruct.GPIO_Pin  = KEY3_Pin;
    GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(KEY3_GPIO_Port, &GPIO_InitStruct);
    GPIO_InitStruct.GPIO_Pin  = KEY4_Pin;
    GPIO_InitStruct.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(KEY4_GPIO_Port, &GPIO_InitStruct);
   // GPIO_PinAFConfig(KEY1_GPIO_Port, KEY1_PIN_SOURCE, GPIO_AF_15);
   // GPIO_PinAFConfig(KEY2_GPIO_Port, KEY2_PIN_SOURCE, GPIO_AF_15);
    GPIO_PinAFConfig(KEY3_GPIO_Port, KEY3_PIN_SOURCE, GPIO_AF_15);
    GPIO_PinAFConfig(KEY4_GPIO_Port, KEY4_PIN_SOURCE, GPIO_AF_15);
}

/**
* @}
*/

/**
* @}
*/

/**
* @}
*/

/*-------------------------(C) COPYRIGHT 2018 MindMotion ----------------------*/

