/**************************************************************************//**
 * @file     startup_ARMCM3.S
 * @brief    CMSIS-Core(M) Device Startup File for Cortex-M3 Device
 * @version  V2.2.0
 * @date     26. May 2021
 ******************************************************************************/
/*
 * Copyright (c) 2009-2021 Arm Limited. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the License); you may
 * not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an AS IS BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

                .syntax  unified
                .arch    armv7-m

                .section .vectors
                .align   2
                .globl   __Vectors
                .globl   __Vectors_End
                .globl   __Vectors_Size
__Vectors:
                .long    __StackTop                         /*     Top of Stack */
                .long    Reset_Handler                      /*     Reset Handler */
                .long    NMI_Handler                        /* -14 NMI Handler */
                .long    HardFault_Handler                  /* -13 Hard Fault Handler */
                .long    MemManage_Handler                  /* -12 MPU Fault Handler */
                .long    BusFault_Handler                   /* -11 Bus Fault Handler */
                .long    UsageFault_Handler                 /* -10 Usage Fault Handler */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    SVC_Handler                        /*  -5 SVC Handler */
                .long    DebugMon_Handler                   /*  -4 Debug Monitor Handler */
                .long    0                                  /*     Reserved */
                .long    PendSV_Handler                     /*  -2 PendSV Handler */
                .long    SysTick_Handler                    /*  -1 SysTick Handler */

                /* Interrupts */
                .long   WWDG_IRQHandler                                 /* 0       Window Watchdog */
                .long   PVD_IRQHandler                                  /* 1       PVD through EXTI Line detect */
                .long   TAMPER_IRQHandler                               /* 2       Tamper */
                .long   RTC_IRQHandler                                  /* 3       RTC */
                .long   FLASH_IRQHandler                                /* 4       Flash */
                .long   RCC_CRS_IRQHandler                              /* 5       RCC */
                .long   EXTI0_IRQHandler                                /* 6       EXTI Line 0 */
                .long   EXTI1_IRQHandler                                /* 7       EXTI Line 1 */
                .long   EXTI2_IRQHandler                                /* 8       EXTI Line 2 */
                .long   EXTI3_IRQHandler                                /* 9       EXTI Line 3 */
                .long   EXTI4_IRQHandler                                /* 10      EXTI Line 4 */
                .long   DMA1_CH1_IRQHandler                             /* 11      DMA1 Channel 1 */
                .long   DMA1_CH2_IRQHandler                             /* 12      DMA1 Channel 2 */
                .long   DMA1_CH3_IRQHandler                             /* 13      DMA1 Channel 3 */
                .long   DMA1_CH4_IRQHandler                             /* 14      DMA1 Channel 4 */
                .long   DMA1_CH5_IRQHandler                             /* 15      DMA1 Channel 5 */
                .long   DMA1_CH6_IRQHandler                             /* 16      DMA1 Channel 6 */
                .long   DMA1_CH7_IRQHandler                             /* 17      DMA1 Channel 7 */
                .long   ADC1_2_IRQHandler                               /* 18      ADC1 and ADC2 */
                .long   FlashCache_IRQHandler                           /* 19      FlashCache outage */
                .long   0                                               /* 20      Reserved */
                .long   CAN1_RX_IRQHandler                              /* 21      CAN1_RX */
                .long   0                                               /* 22      Reserved */
                .long   EXTI9_5_IRQHandler                              /* 23      EXTI Line 9..5 */
                .long   TIM1_BRK_IRQHandler                             /* 24      TIM1 Break */
                .long   TIM1_UP_IRQHandler                              /* 25      TIM1 Update */
                .long   TIM1_TRG_COM_IRQHandler                         /* 26      TIM1 Trigger and Commutation */
                .long   TIM1_CC_IRQHandler                              /* 27      TIM1 Capture Compare */
                .long   TIM2_IRQHandler                                 /* 28      TIM2 */
                .long   TIM3_IRQHandler                                 /* 29      TIM3 */
                .long   TIM4_IRQHandler                                 /* 30      TIM4 */
                .long   I2C1_IRQHandler                                 /* 31      I2C1 Event */
                .long   0                                               /* 32      Reserved */
                .long   I2C2_IRQHandler                                 /* 33      I2C2 Event */
                .long   0                                               /* 34      Reserved */
                .long   SPI1_IRQHandler                                 /* 35      SPI1 */
                .long   SPI2_IRQHandler                                 /* 36      SPI2 */
                .long   UART1_IRQHandler                                /* 37      UART1 */
                .long   UART2_IRQHandler                                /* 38      UART2 */
                .long   UART3_IRQHandler                                /* 39      UART3 */
                .long   EXTI15_10_IRQHandler                            /* 40      EXTI Line 15..10 */
                .long   RTCAlarm_IRQHandler                             /* 41      RTC Alarm through EXTI Line 17 */
                .long   OTG_FS_WKUP_IRQHandler                          /* 42      USB OTG FS Wakeup through EXTI line */
                .long   TIM8_BRK_IRQHandler                             /* 43      TIM8 Break */
                .long   TIM8_UP_IRQHandler                              /* 44      TIM8 Update */
                .long   TIM8_TRG_COM_IRQHandler                         /* 45      TIM8 Trigger and Commutation */
                .long   TIM8_CC_IRQHandler                              /* 46      TIM8 Capture Compare */
                .long   ADC3_IRQHandler                                 /* 47      ADC3 */
                .long   0                                               /* 48      Reserved */
                .long   SDIO_IRQHandler                                 /* 49      SDIO */
                .long   TIM5_IRQHandler                                 /* 50      TIM5 */
                .long   SPI3_IRQHandler                                 /* 51      SPI3 */
                .long   UART4_IRQHandler                                /* 52      UART4 */
                .long   UART5_IRQHandler                                /* 53      UART5 */
                .long   TIM6_IRQHandler                                 /* 54      TIM6 */
                .long   TIM7_IRQHandler                                 /* 55      TIM7 */
                .long   DMA2_CH1_IRQHandler                             /* 56      DMA2 Channel 1 */
                .long   DMA2_CH2_IRQHandler                             /* 57      DMA2 Channel 2 */
                .long   DMA2_CH3_IRQHandler                             /* 58      DMA2 Channel 3 */
                .long   DMA2_CH4_IRQHandler                             /* 59      DMA2 Channel 4 */
                .long   DMA2_CH5_IRQHandler                             /* 60      DMA2 Channel 5 */
                .long   ETH_IRQHandler                                  /* 61      Ethernet */
                .long   0                                               /* 62      Reserved */
                .long   0                                               /* 63      Reserved */
                .long   COMP1_2_IRQHandler                              /* 64      COMP1,COMP2 */
                .long   0                                               /* 65      Reserved */
                .long   0                                               /* 66      Reserved */
                .long   OTG_FS_IRQHandler                               /* 67      USB OTG_FullSpeed */
                .long   0                                               /* 68      Reserved */
                .long   0                                               /* 69      Reserved */
                .long   0                                               /* 70      Reserved */
                .long   UART6_IRQHandler                                /* 71      UART6   */
                .long   0                                               /* 72      Reserved */
                .long   0                                               /* 73      Reserved */
                .long   0                                               /* 74      Reserved */
                .long   0                                               /* 75      Reserved */
                .long   0                                               /* 76      Reserved */
                .long   0                                               /* 77      Reserved */
                .long   0                                               /* 78      Reserved */
                .long   0                                               /* 79      Reserved */
                .long   0                                               /* 80      Reserved */
                .long   0                                               /* 81      Reserved */
                .long   UART7_IRQHandler                                /* 82      UART7 */
                .long   UART8_IRQHandler                                /* 83      UART8 */

            //    .space   (214 * 4)                          /* Interrupts 10 .. 224 are left out */
__Vectors_End:
                .equ     __Vectors_Size, __Vectors_End - __Vectors
                .size    __Vectors, . - __Vectors


                .thumb
                .section .text
                .align   2

                .thumb_func
                .type    Reset_Handler, %function
                .globl   Reset_Handler
                .fnstart
Reset_Handler:
                bl       SystemInit

                ldr      r4, =__copy_table_start__
                ldr      r5, =__copy_table_end__

.L_loop0:
                cmp      r4, r5
                bge      .L_loop0_done
                ldr      r1, [r4]                /* source address */
                ldr      r2, [r4, #4]            /* destination address */
                ldr      r3, [r4, #8]            /* word count */
                lsls     r3, r3, #2              /* byte count */

.L_loop0_0:
                subs     r3, #4                  /* decrement byte count */
                ittt     ge
                ldrge    r0, [r1, r3]
                strge    r0, [r2, r3]
                bge      .L_loop0_0

                adds     r4, #12
                b        .L_loop0
.L_loop0_done:

                ldr      r3, =__zero_table_start__
                ldr      r4, =__zero_table_end__

.L_loop2:
                cmp      r3, r4
                bge      .L_loop2_done
                ldr      r1, [r3]                /* destination address */
                ldr      r2, [r3, #4]            /* word count */
                lsls     r2, r2, #2              /* byte count */
                movs     r0, 0

.L_loop2_0:
                subs     r2, #4                  /* decrement byte count */
                itt      ge
                strge    r0, [r1, r2]
                bge      .L_loop2_0

                adds     r3, #8
                b        .L_loop2
.L_loop2_done:

                bl       _start

                .fnend
                .size    Reset_Handler, . - Reset_Handler

/* The default macro is not used for HardFault_Handler
 * because this results in a poor debug illusion.
 */
                .thumb_func
                .type    HardFault_Handler, %function
                .weak    HardFault_Handler
                .fnstart
HardFault_Handler:
                b        .
                .fnend
                .size    HardFault_Handler, . - HardFault_Handler

                .thumb_func
                .type    Default_Handler, %function
                .weak    Default_Handler
                .fnstart
Default_Handler:
                b        .
                .fnend
                .size    Default_Handler, . - Default_Handler

/* Macro to define default exception/interrupt handlers.
 * Default handler are weak symbols with an endless loop.
 * They can be overwritten by real handlers.
 */
                .macro   Set_Default_Handler  Handler_Name
                .weak    \Handler_Name
                .set     \Handler_Name, Default_Handler
                .endm


/* Default exception/interrupt handler */

                Set_Default_Handler  NMI_Handler
                Set_Default_Handler  MemManage_Handler
                Set_Default_Handler  BusFault_Handler
                Set_Default_Handler  UsageFault_Handler
                Set_Default_Handler  SVC_Handler
                Set_Default_Handler  DebugMon_Handler
                Set_Default_Handler  PendSV_Handler
                Set_Default_Handler  SysTick_Handler

                Set_Default_Handler   WWDG_IRQHandler                                 /* 0       Window Watchdog */
                Set_Default_Handler   PVD_IRQHandler                                  /* 1       PVD through EXTI Line detect */
                Set_Default_Handler   TAMPER_IRQHandler                               /* 2       Tamper */
                Set_Default_Handler   RTC_IRQHandler                                  /* 3       RTC */
                Set_Default_Handler   FLASH_IRQHandler                                /* 4       Flash */
                Set_Default_Handler   RCC_CRS_IRQHandler                              /* 5       RCC */
                Set_Default_Handler   EXTI0_IRQHandler                                /* 6       EXTI Line 0 */
                Set_Default_Handler   EXTI1_IRQHandler                                /* 7       EXTI Line 1 */
                Set_Default_Handler   EXTI2_IRQHandler                                /* 8       EXTI Line 2 */
                Set_Default_Handler   EXTI3_IRQHandler                                /* 9       EXTI Line 3 */
                Set_Default_Handler   EXTI4_IRQHandler                                /* 10      EXTI Line 4 */
                Set_Default_Handler   DMA1_CH1_IRQHandler                             /* 11      DMA1 Channel 1 */
                Set_Default_Handler   DMA1_CH2_IRQHandler                             /* 12      DMA1 Channel 2 */
                Set_Default_Handler   DMA1_CH3_IRQHandler                             /* 13      DMA1 Channel 3 */
                Set_Default_Handler   DMA1_CH4_IRQHandler                             /* 14      DMA1 Channel 4 */
                Set_Default_Handler   DMA1_CH5_IRQHandler                             /* 15      DMA1 Channel 5 */
                Set_Default_Handler   DMA1_CH6_IRQHandler                             /* 16      DMA1 Channel 6 */
                Set_Default_Handler   DMA1_CH7_IRQHandler                             /* 17      DMA1 Channel 7 */
                Set_Default_Handler   ADC1_2_IRQHandler                               /* 18      ADC1 and ADC2 */
                Set_Default_Handler   FlashCache_IRQHandler                           /* 19      FlashCache outage */
                Set_Default_Handler   CAN1_RX_IRQHandler                              /* 21      CAN1_RX */

                Set_Default_Handler   EXTI9_5_IRQHandler                              /* 23      EXTI Line 95 */
                Set_Default_Handler   TIM1_BRK_IRQHandler                             /* 24      TIM1 Break */
                Set_Default_Handler   TIM1_UP_IRQHandler                              /* 25      TIM1 Update */
                Set_Default_Handler   TIM1_TRG_COM_IRQHandler                         /* 26      TIM1 Trigger and Commutation */
                Set_Default_Handler   TIM1_CC_IRQHandler                              /* 27      TIM1 Capture Compare */
                Set_Default_Handler   TIM2_IRQHandler                                 /* 28      TIM2 */
                Set_Default_Handler   TIM3_IRQHandler                                 /* 29      TIM3 */
                Set_Default_Handler   TIM4_IRQHandler                                 /* 30      TIM4 */
                Set_Default_Handler   I2C1_IRQHandler                                 /* 31      I2C1 Event */

                Set_Default_Handler   I2C2_IRQHandler                                 /* 33      I2C2 Event */

                Set_Default_Handler   SPI1_IRQHandler                                 /* 35      SPI1 */
                Set_Default_Handler   SPI2_IRQHandler                                 /* 36      SPI2 */
                Set_Default_Handler   UART1_IRQHandler                                /* 37      UART1 */
                Set_Default_Handler   UART2_IRQHandler                                /* 38      UART2 */
                Set_Default_Handler   UART3_IRQHandler                                /* 39      UART3 */
                Set_Default_Handler   EXTI15_10_IRQHandler                            /* 40      EXTI Line 1510 */
                Set_Default_Handler   RTCAlarm_IRQHandler                             /* 41      RTC Alarm through EXTI Line 17 */
                Set_Default_Handler   OTG_FS_WKUP_IRQHandler                          /* 42      USB OTG FS Wakeup through EXTI line */
                Set_Default_Handler   TIM8_BRK_IRQHandler                             /* 43      TIM8 Break */
                Set_Default_Handler   TIM8_UP_IRQHandler                              /* 44      TIM8 Update */
                Set_Default_Handler   TIM8_TRG_COM_IRQHandler                         /* 45      TIM8 Trigger and Commutation */
                Set_Default_Handler   TIM8_CC_IRQHandler                              /* 46      TIM8 Capture Compare */
                Set_Default_Handler   ADC3_IRQHandler                                 /* 47      ADC3 */ 
                Set_Default_Handler   SDIO_IRQHandler                                 /* 49      SDIO */
                Set_Default_Handler   TIM5_IRQHandler                                 /* 50      TIM5 */
                Set_Default_Handler   SPI3_IRQHandler                                 /* 51      SPI3 */
                Set_Default_Handler   UART4_IRQHandler                                /* 52      UART4 */
                Set_Default_Handler   UART5_IRQHandler                                /* 53      UART5 */
                Set_Default_Handler   TIM6_IRQHandler                                 /* 54      TIM6 */
                Set_Default_Handler   TIM7_IRQHandler                                 /* 55      TIM7 */
                Set_Default_Handler   DMA2_CH1_IRQHandler                             /* 56      DMA2 Channel 1 */
                Set_Default_Handler   DMA2_CH2_IRQHandler                             /* 57      DMA2 Channel 2 */
                Set_Default_Handler   DMA2_CH3_IRQHandler                             /* 58      DMA2 Channel 3 */
                Set_Default_Handler   DMA2_CH4_IRQHandler                             /* 59      DMA2 Channel 4 */
                Set_Default_Handler   DMA2_CH5_IRQHandler                             /* 60      DMA2 Channel 5 */
                Set_Default_Handler   ETH_IRQHandler                                  /* 61      Ethernet */
                Set_Default_Handler   COMP1_2_IRQHandler                              /* 64      COMP1,COMP2 */
                Set_Default_Handler   OTG_FS_IRQHandler                               /* 67      USB OTG_FullSpeed */
                Set_Default_Handler   UART6_IRQHandler                                /* 71      UART6   */
                Set_Default_Handler   UART7_IRQHandler                                /* 82      UART7 */
                Set_Default_Handler   UART8_IRQHandler                                /* 83      UART8 */


                .end
