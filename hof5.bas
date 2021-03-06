// WARNING:
// * There is not a check on air pressure in this system.  As a consequence 
//   insufficient air pressure can cause undetected problems.   
//                                                                                     
//   2017-04-03: It would be possible to detect, at some level, insufficient air
//   pressure.  IV07, for example, could be asked to change position when                             
//   transitioning from the reset state.  If it failed to make the transition 
//   from on to off and back again, then an insufficient air pressure fault 
//   could be raised.                                           

// Calibration settings for the controller used 20/4/2015:                                  
// Analogue inputs:
//   - Scale factor: 0.663
//   - Offset: -2481
// Analogue outputs:
//   - Low: -22,200
//   - High: 20,110
 

// ==================
// Controller's Serial Settings (see page 143 of ICC402-REG-MAN.pdf):

// Port 1
MEM &BAUDRATE1 = 7 // 115,200 baud; 8 data bits; no parity; 2ms transmit delay (see page 144)
MEM &SERIAL_ADDRESS1 = 1
MEM &SERIAL_MODE1 = 4 // Ethernet

// Port 2
MEM &BAUDRATE2 = 7 // 115,200 baud; 8 data bits; no parity; 2ms transmit delay (see page 144)
MEM &SERIAL_ADDRESS2 = 1
MEM &SERIAL_MODE2 = 0 // ASCII protocol


// ==================
// SMART Input module 1 (ISOP1); code sourced from the wayback machine from 
// texmate.co.nz back in 2010.
//  Input Module Type: ISOP1
//  Smart 8 channel process input module
//
//  &SMART_RESULT1 = Current input 1
//  &SMART_RESULT2 = Current input 2
//  &SMART_RESULT3 = Current input 3
//  &SMART_RESULT4 = Current input 4
//  &SMART_RESULT5 = Current input 5
//  &SMART_RESULT6 = Current input 6
//  &SMART_RESULT7 = Current input 7
//  &SMART_RESULT8 = Current input 8
//
//

// When reading or writing to these code registers the data is treated in 
// octal format. The 1st digit of each Code register is stored in bits 6 and 7.
// The 2nd digit of each Code register is stored in bits 3, 4, and 5. The 3rd 
// digit of each Code register is stored in bits 0, 1, and 2.
// For example:
// If the setup for Code 4 shows 241 on the display, then reading register 8197
// in ASCII mode results in a value of 241. Converting this octal value to a 
// binary equivalent of 10100001 or hexadecimal equivalent of 0A1.


// Code 2 (Channel 1) provide the settings to select noise rejection, analog 
// sampling rate, and output rate for all input channels. It also allows you to
// select the input signal type and range setting for CH1.
// First digit
// 0: Sample rate of 10 samples/second (divided by the number of channels),
//    thus 1.25 samples/second/channel.
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
MEM &CODE2 = 070

// Code 3 (Channel 1):
// First digit
// 0: No processing on channel 1
// 1: Square root of channel 1
// 2: Inverse of channel 1
// Second digit
// 0: No linearization
// Third digit:
// Not used
mem &CODE3=000

// Code 4 (Channel 2):
// First digit
// 0: Voltage, Current
// Second Digit
// 4: Averaged signal 1
// 5: Averaged signal 2
// 6: Averaged signal 3
// 7: Averaged signal 4
mem &CODE4=050

// Code 5 (Channel 3):
// First digit
// 0: No processing of channel 3
// 1: Square root of channel 3
// 2: Inverse of channel 3
// 3: 32-point linearization of channel 3 using table 3
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
mem &CODE5=072

// Code 6 (Channel 4):
// First digit
// 0: No processing of channel 4
// 1: Square root of channel 4
// 2: Inverse of channel 4
// 3: 32-point linearization of channel 4 using table 4
// Second digit
// 7: Smart input module
// Third digit
// 0: Averaged signal 1
// 1: Averaged signal 2
// 2: Averaged signal 3
// 3: Averaged signal 4
// 4: Averaged signal 5
// 5: Averaged signal 6
// 6: Averaged signal 7
mem &CODE6=073

// Code 7 (Result):
// First digit
// 0: No processing of Result
// 1: Square root of Result
// 2: Inverse of Result
// Second digit
// 0: No linearization
// Third digit
// 0: Result register not updated
MEM &CODE7 = 000


// Smart Setup 1: [This is the best information I could find on this module (Mattthew 20/4/2015)] 
// 1st digit = frequency select                                                       
// 0 =
// 1 = 60hz
// 2 =
// 3 = 50hz
//
// 2nd digit=voltage range
// 0 =
// 1 =
// 2 =
// 3 =
// 4 =
// 5 =
// 6 =
//
// 3rd digit= output rate
// 0 =
// 1 =
// 2 =
// 3 =
// 4 =
// 5 =
MEM &SMART_SETUP1=0300 // For some reason the zero at the front is
                       // important for the compiler.


MEM &DATA_SOURCE_CH5 = ADDR(&SMART_RESULT5 )
MEM &DATA_SOURCE_CH6 = ADDR(&SMART_RESULT6 )
MEM &DATA_SOURCE_CH7 = ADDR(&SMART_RESULT7 )
MEM &DATA_SOURCE_RESULT = ADDR(&SMART_RESULT8 )

// No other SMART modules are installed
MEM &SMART_SETUP2 = 0
MEM &SMART_SETUP3 = 0




// ==================
// Start up text (visible for about a second after powering on)
// Two lines of 16 characters each:
                        // 1234567890123456
MEM &STARTUP_TEXT_LINE1 = "Membrane Process"
MEM &STARTUP_TEXT_LINE2 = "      HOF5      "

// ==================

REG &LT01 = &AUX8
MEM &AUX8_TEXT = "LT01 %"
MEM &DISPLAY_FORMAT_AUX8  = 6 //x.x

REG &LT02 = &AUX12
MEM &AUX12_TEXT = "LT02 %"
MEM &DISPLAY_FORMAT_AUX12  = 6 //x.x

REG &PT01 = &AUX13   
MEM &AUX13_TEXT = "PT01 bar"
MEM &DISPLAY_FORMAT_AUX13  = 4 //x.xxx

REG &PT04 = &AUX9   
MEM &AUX9_TEXT = "PT04 bar"
MEM &DISPLAY_FORMAT_AUX9  = 4 //x.xxx

REG &TT01 = &AUX10
MEM &AUX10_TEXT = "TT01 C"
MEM &DISPLAY_FORMAT_AUX10  = 6 //x.x

REG &FT01 = &AUX1
MEM &AUX1_TEXT = "FT01 l/h"
MEM &DISPLAY_FORMAT_AUX1 = 6 //x.x

REG &FT02 = &AUX11
MEM &AUX11_TEXT = "FT2 m3/h"
MEM &DISPLAY_FORMAT_AUX11 = 5 //x.xx

REG &PP01S = &AUX2
MEM &AUX2_TEXT = "PP01 %"
MEM &DISPLAY_FORMAT_AUX2 = 5 //x.xx
MEM &D2A_AOP1_ZERO = 0
MEM &D2A_AOP1_FULL_SCALE = 10000 
MEM &DATA_SOURCE_ANALOG1 = ADDR(&PP01S)

REG &PP02S = &AUX3
MEM &AUX3_TEXT = "PP02 %"
MEM &DISPLAY_FORMAT_AUX3 = 5 //x.xx
MEM &D2A_AOP2_ZERO = 0
MEM &D2A_AOP2_FULL_SCALE = 10000 
MEM &DATA_SOURCE_ANALOG2 = ADDR(&PP02S)

REG &T0acc = &AUX4
MEM &T0acc = 0 
MEM &AUX4_TEXT = "T0 s"
MEM &DISPLAY_FORMAT_AUX4 = 6 //x.x 

REG &fd100StepNumber = &AUX5
MEM &fd100StepNumber = 0 
MEM &AUX5_TEXT = "Step"
MEM &DISPLAY_FORMAT_AUX5 = 0 //x

                       // "1234567890123456": Display is 16 characters wide
DIM fd100StepMsgArray[] =["Reset           ",\
                          "    Check Level In Permeate Tank     ",\
                          "",\
                          "Production      ",\
                          "",\
                          "",\
                          "",\
                          "    Fill Tank For Backwash     ",\
                          "",\
                          "    Module 1 Backwash - Set Valves     ",\
                          "    Module 1 Backwash - Run Pump     ",\
                          "    Module 2 Backwash - Set Valves     ",\
                          "    Module 2 Backwash - Run Pump     ",\
                          "    Module 3 Backwash - Set Valves     ",\
                          "    Module 3 Backwash - Run Pump     ",\
                          "",\
                          "",\
                          "    Check Level In Feed Tank     ",\
                          "    Empty Permeate Tank     ",\
                          "    Empty Feed Tank     ",\
                          "End             ",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "",\
                          "    Manual Test Mode (State #30)     "]
                    
REG &T1acc = &AUX6
MEM &AUX6_TEXT = "T1 s"
MEM &DISPLAY_FORMAT_AUX6 = 6 //x.x

REG &T2acc = &AUX14
MEM &AUX14_TEXT = "T2 s"
MEM &DISPLAY_FORMAT_AUX14 = 6 //x.x

REG &fault = &AUX7
MEM &fault = 0
MEM &AUX7_TEXT = "Fault #"
MEM &DISPLAY_FORMAT_AUX7 = 0 //x

                    // "1234567890123456": Display is 16 characters wide
DIM faultMsgArray[] = ["No Faults       ",\
                       "     High Temperature     ",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       "",\
                       ""]

//BitFlags
BIT |AFI = |GPF1 

//Integer_Variables
REG &lastScanTimeFast = &INTEGER_VARIABLE1
REG &lastScanTimeShort = &INTEGER_VARIABLE2
REG &Temp1 = &INTEGER_VARIABLE3
REG &Temp2 = &INTEGER_VARIABLE4
REG &Temp3 = &INTEGER_VARIABLE5
REG &PP02S_LVL = &INTEGER_VARIABLE6
REG &Logtime = &INTEGER_VARIABLE7
REG &FT01time = &INTEGER_VARIABLE8
REG &FT01count = &INTEGER_VARIABLE9
REG &displayState = &INTEGER_VARIABLE10
MEM &displayState = 0
REG &faultNew = &INTEGER_VARIABLE11
REG &faultLastLog = &INTEGER_VARIABLE12
REG &fd100StepNumberLastLog = &INTEGER_VARIABLE13
REG &SEL_TYPE = &INTEGER_VARIABLE14 //0=NA 1=SS_Prod 2=SS_CIP 3=Poly_Prod 4=Poly_CIP 

//Float_Variables
REG &Calc01 = &FLOAT_VARIABLE1
REG &Calc02 = &FLOAT_VARIABLE2
REG &Calc03 = &FLOAT_VARIABLE3
REG &Calc04 = &FLOAT_VARIABLE4
REG &Calc05 = &FLOAT_VARIABLE5
REG &Calc06 = &FLOAT_VARIABLE6

//IO Mapping
BIT |PB07 = |CI_1       // Concentrate button
BIT |SW08 = |CI_2
BIT |SW09_1 = |CI_3
BIT |SW09_2 = |CI_4
BIT |PB01 = |CI_5       // Start button
BIT |PB02 = |CI_6       // Backflush button
BIT |PB03 = |CI_7       // Permeate out
BIT |PB04 = |CI_8       // Stop button
BIT |PB05 = |CI_9       // Reset button
BIT |PB06 = |CI_10      // Retentate Out button

BIT |IV08_E = |DI_1
BIT |IV08_D = |DI_2
BIT |IV09_E = |DI_3
BIT |IV09_D = |DI_4
BIT |IV10_E = |DI_5
BIT |IV10_D = |DI_6
BIT |IV17_E = |DI_7
BIT |IV17_D = |DI_8
BIT |PP01_E = |DI_9
BIT |PP02_E = |DI_10

BIT |IV01_E = |DI_17
BIT |IV01_D = |DI_18
BIT |IV02_E = |DI_19
BIT |IV02_D = |DI_20
BIT |IV03_E = |DI_21
BIT |IV03_D = |DI_22
BIT |IV05_E = |DI_23
BIT |IV05_D = |DI_24
BIT |IV06_E = |DI_25
BIT |IV06_D = |DI_26
BIT |IV07_E = |DI_27
BIT |IV07_D = |DI_28

BIT |PB01_L = |SP5
BIT |PB02_L = |SP6
BIT |PB03_L = |SP7
BIT |PB04_L = |SP8
BIT |PB05_L = |SP9
BIT |PB06_L = |SP10
BIT |PB07_L = |SP11  

BIT |IV01_O = |DO_1 
BIT |IV02_O = |DO_2
BIT |IV03_O = |DO_3
BIT |IV05_O = |DO_4
BIT |IV06_O = |DO_5
BIT |IV07_O = |DO_6
BIT |IV08_O = |DO_7
BIT |IV09_O = |DO_8
BIT |IV10_O = |DO_9
BIT |IV17_O = |DO_10
BIT |PP01_O = |DO_11
BIT |PP02_O = |DO_12
BIT |SV62_O = |DO_15
BIT |SV63_O = |DO_16



//User_Memory_1 to 99 Display Format x.x
MEM &USER_MEMORY16_BAND1 = 5219
MEM &DISPLAY_FORMAT_USER16_BAND1 = 6
REG &LT01SP01 = &USER_MEMORY_1
MEM &LT01SP01 = 200 // 20.0%: Minimum pump 2 speed below this level (for permeate tank pump out)
REG &LT01SP02 = &USER_MEMORY_2
MEM &LT01SP02 = 500 // 50.0%: Maximum pump 2 speed above this level (for permeate tank pump out)
REG &LT01SP03 = &USER_MEMORY_3 //Restart Prod, After Pump Out Of Retentate
MEM &LT01SP03 = 200 // 20.0%: Maximum permeate tank level at which we start production
REG &LT01SP04 = &USER_MEMORY_4 //Stop Prod, Pump Out Retentate
MEM &LT01SP04 = 800 // 80.0%: Maximum permeate tank level during production
REG &LT01SP05 = &USER_MEMORY_5 //Min Level For BW  
MEM &LT01SP05 = 150 // 15.0%: Minimum permeate tank level for backwash
REG &LT01SP06 = &USER_MEMORY_6 //Empty Level
MEM &LT01SP06 = 0 // 0.0%: Level at which emptying of the permeate tank becomes time-based

REG &T1SP13 = &USER_MEMORY_7
MEM &T1SP13 = 3000  // 300.0 seconds (5 mins, max is 3276.8 seconds): 
                    // Duration of production before backwash
REG &T2SP13 = &USER_MEMORY_8
MEM &T2SP13 = 9000  // 900.0 seconds (15 mins, max is 3276.8 seconds): 
                    // Total duration of each CIP step (including backwashes)
                    // The CIP steps include rinse, alkali wash, rinse, acid
                    // wash, rinse.

REG &T0SP09 = &USER_MEMORY_9
MEM &T0SP09 = 30 // 3.0 seconds for the valves to transition for module 1 backflush
REG &T0SP10 = &USER_MEMORY_10
MEM &T0SP10 = 100 // 10.0 seconds for module 1 to backflush
REG &T0SP11 = &USER_MEMORY_11
MEM &T0SP11 = 30 // 3.0 seconds for the valves to transition for module 2 backflush
REG &T0SP12 = &USER_MEMORY_12
MEM &T0SP12 = 100 // 10.0 seconds for module 2 to backflush
REG &T0SP13 = &USER_MEMORY_13
MEM &T0SP13 = 30 // 3.0 seconds for the valves to transition for module 3 backflush
REG &T0SP14 = &USER_MEMORY_14
MEM &T0SP14 = 100 // 10.0 seconds for module 3 to backflush
REG &T0SP18 = &USER_MEMORY_15
MEM &T0SP18 = 700 // 70.0 seconds for pump 2 to run when permeate tank has gone 
                  // below detectable level.  Commissioned 2017-04-03.
REG &T0SP19 = &USER_MEMORY_16
MEM &T0SP19 = 200 // 20.0 seconds for pump 1 to run when feed tank has gone 
                  // below detectable level

REG &T1SP33 = &USER_MEMORY_17
REG &T2SP33 = &USER_MEMORY_18

REG &TT01SP01 = &USER_MEMORY_25
MEM &TT01SP01 = 600 // High temperature threshold: 60.0 deg C

REG &LT02SP01 = &USER_MEMORY_31 //Empty Level
MEM &LT02SP01 = 0  // 0.0% is empty
REG &LT02SP02 = &USER_MEMORY_32 //Stop Fill Level
MEM &LT02SP02 = 300 // 30.0%: Stop filling the feed tank above this level 
REG &LT02SP03 = &USER_MEMORY_33 //Start Fill Level
MEM &LT02SP03 = 250 // 25.0%: Start filling the feed tank below this level
REG &LT02SP04 = &USER_MEMORY_34 //Stop Production
MEM &LT02SP04 = 50 // 5.0%: Stop production if the feed tank gets below this level 
REG &LT02SP05 = &USER_MEMORY_35 //Start Production
MEM &LT02SP05 = 100 // 10.0%: Start production once the feed tank is above this level

//User_Memory_100 to 199 Display Format x.xx
MEM &USER_MEMORY16_BAND2 = 5319
MEM &DISPLAY_FORMAT_USER16_BAND2 = 5

REG &PP01SP01 = &USER_MEMORY_100
MEM &PP01SP01 = 2000 // 20.00% Pump 1's default production speed (occurs if switch set to 'off' position) 
REG &PP01SP02 = &USER_MEMORY_101
MEM &PP01SP02 = 2000 // 20.00% Pump 1's default CIP speed (occurs if switch set to 'off' position) 
REG &PP01SP03 = &USER_MEMORY_102
MEM &PP01SP03 = 3000 // 30.00% Pump 1's speed to empty feed tank 


REG &PP02SP02 = &USER_MEMORY_104
REG &PP02SP03 = &USER_MEMORY_105
REG &PP02SP04 = &USER_MEMORY_106
MEM &PP02SP04 = 3000 // 30.00%: Pump speed during emptying of permeate tank
REG &PP02SP05 = &USER_MEMORY_107
MEM &PP02SP05 = 3000 // 30.00%: Minimum pump speed during permeate tank pump out (see also LT01SP01)
REG &PP02SP06 = &USER_MEMORY_108
MEM &PP02SP06 = 8000 // 80.00%: Maximum pump speed during permeate tank pump out (see also LT01SP02)
REG &PP02SP07 = &USER_MEMORY_109
MEM &PP02SP07 = 3500 // 35.00%: Miminum calculated pump speed before we restart 
                     //         permeate tank pump out

//SS_Prod
REG &PP01SP11 = &USER_MEMORY_110
REG &PP01SP12 = &USER_MEMORY_111
REG &PP02SP12 = &USER_MEMORY_112
REG &PP02SP13 = &USER_MEMORY_113

//SS_Prod_Conc
REG &PP01SP21 = &USER_MEMORY_120
REG &PP01SP22 = &USER_MEMORY_121
REG &PP02SP22 = &USER_MEMORY_122
REG &PP02SP23 = &USER_MEMORY_123

//SS_CIP
REG &PP01SP31 = &USER_MEMORY_130
REG &PP01SP32 = &USER_MEMORY_131
REG &PP02SP32 = &USER_MEMORY_132
REG &PP02SP33 = &USER_MEMORY_133
REG &PP02SP39 = &USER_MEMORY_134

///Poly_Prod
REG &PP01SP41 = &USER_MEMORY_140
MEM &PP01SP41 = 8500              // 85.00%: Pump 1's speed during production
                                  //         (worked well at 93% on water)
REG &PP01SP42 = &USER_MEMORY_141
MEM &PP01SP42 = 5000              // 50.00%: Pump 1's speed during module 
                                  //         backwash and setting of the valves
REG &PP02SP42 = &USER_MEMORY_142
MEM &PP02SP42 = 6000              // 60.00%: Pump 2's speed during setting of 
                                  //         the valves before module backwash
REG &PP02SP43 = &USER_MEMORY_143
MEM &PP02SP43 = 8500              // 85.00%: Pump 2's speed during module backwash

//Poly_Prod_Conc
REG &PP01SP51 = &USER_MEMORY_150
MEM &PP01SP51 = 5000              // 50.00%: Pump 1's speed during concentration
REG &PP01SP52 = &USER_MEMORY_151
REG &PP02SP52 = &USER_MEMORY_152
REG &PP02SP53 = &USER_MEMORY_153

//Poly_CIP
REG &PP01SP61 = &USER_MEMORY_160
MEM &PP01SP61 = 8500              // 85.00%: Pump 1's speed during CIP
REG &PP01SP62 = &USER_MEMORY_161           
MEM &PP01SP62 = 5000              // 50.00%: Pump 1's speed (during CIP) during  
                                  //         module backwash and setting of the 
                                  //         valves
REG &PP02SP62 = &USER_MEMORY_162
MEM &PP02SP62 = 6000              // 60.00%: Pump 2's speed (during CIP) during  
                                  //         setting of the valves before module
                                  //         backwash
REG &PP02SP63 = &USER_MEMORY_163
MEM &PP02SP63 = 8500              // 85.00%: Pump 2's speed (during CIP) during
                                  //         module backwash
REG &PP02SP69 = &USER_MEMORY_164

//User_Memory_200 to 299 Display Format x.xxx
MEM &USER_MEMORY16_BAND3 = 5419
MEM &DISPLAY_FORMAT_USER16_BAND3 = 4

//User_Memory_300 and above Display Format x


REG &XXstatus = &USER_MEMORY_400
BITREG &XXstatus = [|XXout, |XXeng, |XXdeeng, |XXfault, |XXmanualOn, |XXmanualOff, |XXautoOut, |XXengEnable, |XXdeengEnable, |XXfaultEnable]
REG &XXcmd = &USER_MEMORY_401
REG &XXtimerState = &USER_MEMORY_402
REG &XXtimerAcc = &USER_MEMORY_403
REG &XXtimerPre1 = &USER_MEMORY_404
REG &XXtimerPre2 = &USER_MEMORY_405
REG &XXtimerPre4 = &USER_MEMORY_406
REG &XXtimerPre5 = &USER_MEMORY_407

//IV01 Data
REG &IV01status = &USER_MEMORY_408
BITREG &IV01status = [|IV01out, |IV01eng, |IV01deeng, |IV01fault, |IV01manualOn, |IV01manualOff, |IV01autoOut, |IV01engEnable, |IV01deengEnable, |IV01faultEnable] 
MEM &IV01status = 896
REG &IV01cmd = &USER_MEMORY_409
REG &IV01timerState = &USER_MEMORY_410
REG &IV01timerAcc = &USER_MEMORY_411
MEM &IV01timerAcc = 0
REG &IV01timerPre1 = &USER_MEMORY_412
MEM &IV01timerPre1 = 0
REG &IV01timerPre2 = &USER_MEMORY_413
MEM &IV01timerPre2 = 1000
REG &IV01timerPre4 = &USER_MEMORY_414
MEM &IV01timerPre4 = 0
REG &IV01timerPre5 = &USER_MEMORY_415
MEM &IV01timerPre5 = 1000

//IV02 Data
REG &IV02status = &USER_MEMORY_416
BITREG &IV02status = [|IV02out, |IV02eng, |IV02deeng, |IV02fault, |IV02manualOn, |IV02manualOff, |IV02autoOut, |IV02engEnable, |IV02deengEnable, |IV02faultEnable] 
MEM &IV02status = 896
REG &IV02cmd = &USER_MEMORY_417
REG &IV02timerState = &USER_MEMORY_418
REG &IV02timerAcc = &USER_MEMORY_419
MEM &IV02timerAcc = 0
REG &IV02timerPre1 = &USER_MEMORY_420
MEM &IV02timerPre1 = 0
REG &IV02timerPre2 = &USER_MEMORY_421
MEM &IV02timerPre2 = 1000
REG &IV02timerPre4 = &USER_MEMORY_422
MEM &IV02timerPre4 = 0
REG &IV02timerPre5 = &USER_MEMORY_423
MEM &IV02timerPre5 = 1000

//IV03 Data
REG &IV03status = &USER_MEMORY_424
BITREG &IV03status = [|IV03out, |IV03eng, |IV03deeng, |IV03fault, |IV03manualOn, |IV03manualOff, |IV03autoOut, |IV03engEnable, |IV03deengEnable, |IV03faultEnable] 
MEM &IV03status = 896
REG &IV03cmd = &USER_MEMORY_425
REG &IV03timerState = &USER_MEMORY_426
REG &IV03timerAcc = &USER_MEMORY_427
MEM &IV03timerAcc = 0
REG &IV03timerPre1 = &USER_MEMORY_428
MEM &IV03timerPre1 = 0
REG &IV03timerPre2 = &USER_MEMORY_429
MEM &IV03timerPre2 = 1000
REG &IV03timerPre4 = &USER_MEMORY_430
MEM &IV03timerPre4 = 0
REG &IV03timerPre5 = &USER_MEMORY_431
MEM &IV03timerPre5 = 1000

//IV05 Data
REG &IV05status = &USER_MEMORY_432
BITREG &IV05status = [|IV05out, |IV05eng, |IV05deeng, |IV05fault, |IV05manualOn, |IV05manualOff, |IV05autoOut, |IV05engEnable, |IV05deengEnable, |IV05faultEnable] 
MEM &IV05status = 896
REG &IV05cmd = &USER_MEMORY_433
REG &IV05timerState = &USER_MEMORY_434
REG &IV05timerAcc = &USER_MEMORY_435
MEM &IV05timerAcc = 0
REG &IV05timerPre1 = &USER_MEMORY_436
MEM &IV05timerPre1 = 0
REG &IV05timerPre2 = &USER_MEMORY_437
MEM &IV05timerPre2 = 1000
REG &IV05timerPre4 = &USER_MEMORY_438
MEM &IV05timerPre4 = 0
REG &IV05timerPre5 = &USER_MEMORY_439
MEM &IV05timerPre5 = 1000

//IV06 Data
REG &IV06status = &USER_MEMORY_440
BITREG &IV06status = [|IV06out, |IV06eng, |IV06deeng, |IV06fault, |IV06manualOn, |IV06manualOff, |IV06autoOut, |IV06engEnable, |IV06deengEnable, |IV06faultEnable] 
MEM &IV06status = 896
REG &IV06cmd = &USER_MEMORY_441
REG &IV06timerState = &USER_MEMORY_442
REG &IV06timerAcc = &USER_MEMORY_443
MEM &IV06timerAcc = 0
REG &IV06timerPre1 = &USER_MEMORY_444
MEM &IV06timerPre1 = 0
REG &IV06timerPre2 = &USER_MEMORY_445
MEM &IV06timerPre2 = 1000
REG &IV06timerPre4 = &USER_MEMORY_446
MEM &IV06timerPre4 = 0
REG &IV06timerPre5 = &USER_MEMORY_447
MEM &IV06timerPre5 = 1000

//IV07 Data
REG &IV07status = &USER_MEMORY_448
BITREG &IV07status = [|IV07out, |IV07eng, |IV07deeng, |IV07fault, |IV07manualOn, |IV07manualOff, |IV07autoOut, |IV07engEnable, |IV07deengEnable, |IV07faultEnable] 
MEM &IV07status = 896
REG &IV07cmd = &USER_MEMORY_449
REG &IV07timerState = &USER_MEMORY_450
REG &IV07timerAcc = &USER_MEMORY_451
MEM &IV07timerAcc = 0
REG &IV07timerPre1 = &USER_MEMORY_452
MEM &IV07timerPre1 = 0
REG &IV07timerPre2 = &USER_MEMORY_453
MEM &IV07timerPre2 = 1000
REG &IV07timerPre4 = &USER_MEMORY_454
MEM &IV07timerPre4 = 0
REG &IV07timerPre5 = &USER_MEMORY_455
MEM &IV07timerPre5 = 1000

//IV08 Data
REG &IV08status = &USER_MEMORY_456
BITREG &IV08status = [|IV08out, |IV08eng, |IV08deeng, |IV08fault, |IV08manualOn, |IV08manualOff, |IV08autoOut, |IV08engEnable, |IV08deengEnable, |IV08faultEnable] 
MEM &IV08status = 896
REG &IV08cmd = &USER_MEMORY_457
REG &IV08timerState = &USER_MEMORY_458
REG &IV08timerAcc = &USER_MEMORY_459
MEM &IV08timerAcc = 0
REG &IV08timerPre1 = &USER_MEMORY_460
MEM &IV08timerPre1 = 0
REG &IV08timerPre2 = &USER_MEMORY_461
MEM &IV08timerPre2 = 1000
REG &IV08timerPre4 = &USER_MEMORY_462
MEM &IV08timerPre4 = 0
REG &IV08timerPre5 = &USER_MEMORY_463
MEM &IV08timerPre5 = 1000

//IV09 Data
REG &IV09status = &USER_MEMORY_464
BITREG &IV09status = [|IV09out, |IV09eng, |IV09deeng, |IV09fault, |IV09manualOn, |IV09manualOff, |IV09autoOut, |IV09engEnable, |IV09deengEnable, |IV09faultEnable] 
MEM &IV09status = 896
REG &IV09cmd = &USER_MEMORY_465
REG &IV09timerState = &USER_MEMORY_466
REG &IV09timerAcc = &USER_MEMORY_467
MEM &IV09timerAcc = 0
REG &IV09timerPre1 = &USER_MEMORY_468
MEM &IV09timerPre1 = 0
REG &IV09timerPre2 = &USER_MEMORY_469
MEM &IV09timerPre2 = 1000
REG &IV09timerPre4 = &USER_MEMORY_470
MEM &IV09timerPre4 = 0
REG &IV09timerPre5 = &USER_MEMORY_471
MEM &IV09timerPre5 = 1000

//IV10 Data
REG &IV10status = &USER_MEMORY_472
BITREG &IV10status = [|IV10out, |IV10eng, |IV10deeng, |IV10fault, |IV10manualOn, |IV10manualOff, |IV10autoOut, |IV10engEnable, |IV10deengEnable, |IV10faultEnable] 
MEM &IV10status = 896
REG &IV10cmd = &USER_MEMORY_473
REG &IV10timerState = &USER_MEMORY_474
REG &IV10timerAcc = &USER_MEMORY_475
MEM &IV10timerAcc = 0
REG &IV10timerPre1 = &USER_MEMORY_476
MEM &IV10timerPre1 = 0
REG &IV10timerPre2 = &USER_MEMORY_477
MEM &IV10timerPre2 = 1000
REG &IV10timerPre4 = &USER_MEMORY_478
MEM &IV10timerPre4 = 0
REG &IV10timerPre5 = &USER_MEMORY_479
MEM &IV10timerPre5 = 1000

//IV17 Data
REG &IV17status = &USER_MEMORY_480
BITREG &IV17status = [|IV17out, |IV17eng, |IV17deeng, |IV17fault, |IV17manualOn, |IV17manualOff, |IV17autoOut, |IV17engEnable, |IV17deengEnable, |IV17faultEnable] 
MEM &IV17status = 896
REG &IV17cmd = &USER_MEMORY_481
REG &IV17timerState = &USER_MEMORY_482
REG &IV17timerAcc = &USER_MEMORY_483
MEM &IV17timerAcc = 0
REG &IV17timerPre1 = &USER_MEMORY_484
MEM &IV17timerPre1 = 0
REG &IV17timerPre2 = &USER_MEMORY_485
MEM &IV17timerPre2 = 1000
REG &IV17timerPre4 = &USER_MEMORY_486
MEM &IV17timerPre4 = 0
REG &IV17timerPre5 = &USER_MEMORY_487
MEM &IV17timerPre5 = 1000

//PP01 Data
REG &PP01status = &USER_MEMORY_488
BITREG &PP01status = [|PP01out, |PP01eng, |PP01deeng, |PP01fault, |PP01manualOn, |PP01manualOff, |PP01autoOut, |PP01engEnable, |PP01deengEnable, |PP01faultEnable] 
MEM &PP01status = 0
REG &PP01cmd = &USER_MEMORY_489
REG &PP01timerState = &USER_MEMORY_490
REG &PP01timerAcc = &USER_MEMORY_491
MEM &PP01timerAcc = 0
REG &PP01timerPre1 = &USER_MEMORY_492
MEM &PP01timerPre1 = 100
REG &PP01timerPre2 = &USER_MEMORY_493
MEM &PP01timerPre2 = 1000
REG &PP01timerPre4 = &USER_MEMORY_494
MEM &PP01timerPre4 = 0
REG &PP01timerPre5 = &USER_MEMORY_495
MEM &PP01timerPre5 = 1000

//PP02 Data
REG &PP02status = &USER_MEMORY_496
BITREG &PP02status = [|PP02out, |PP02eng, |PP02deeng, |PP02fault, |PP02manualOn, |PP02manualOff, |PP02autoOut, |PP02engEnable, |PP02deengEnable, |PP02faultEnable] 
MEM &PP02status = 0
REG &PP02cmd = &USER_MEMORY_497
REG &PP02timerState = &USER_MEMORY_498
REG &PP02timerAcc = &USER_MEMORY_499
MEM &PP02timerAcc = 0
REG &PP02timerPre1 = &USER_MEMORY_500
MEM &PP02timerPre1 = 100
REG &PP02timerPre2 = &USER_MEMORY_501
MEM &PP02timerPre2 = 1000
REG &PP02timerPre4 = &USER_MEMORY_502
MEM &PP02timerPre4 = 0
REG &PP02timerPre5 = &USER_MEMORY_503
MEM &PP02timerPre5 = 1000

//SV62 Data
REG &SV62status = &USER_MEMORY_504
BITREG &SV62status = [|SV62out, |SV62eng, |SV62deeng, |SV62fault, |SV62manualOn, |SV62manualOff, |SV62autoOut, |SV62engEnable, |SV62deengEnable, |SV62faultEnable] 
MEM &SV62status = 896
REG &SV62cmd = &USER_MEMORY_505
REG &SV62timerState = &USER_MEMORY_506
REG &SV62timerAcc = &USER_MEMORY_507
MEM &SV62timerAcc = 0
REG &SV62timerPre1 = &USER_MEMORY_508
MEM &SV62timerPre1 = 0
REG &SV62timerPre2 = &USER_MEMORY_509
MEM &SV62timerPre2 = 1000
REG &SV62timerPre4 = &USER_MEMORY_510
MEM &SV62timerPre4 = 0
REG &SV62timerPre5 = &USER_MEMORY_511
MEM &SV62timerPre5 = 1000

//SV63 Data
REG &SV63status = &USER_MEMORY_512
BITREG &SV63status = [|SV63out, |SV63eng, |SV63deeng, |SV63fault, |SV63manualOn, |SV63manualOff, |SV63autoOut, |SV63engEnable, |SV63deengEnable, |SV63faultEnable] 
MEM &SV63status = 896
REG &SV63cmd = &USER_MEMORY_513
REG &SV63timerState = &USER_MEMORY_514
REG &SV63timerAcc = &USER_MEMORY_515
MEM &SV63timerAcc = 0
REG &SV63timerPre1 = &USER_MEMORY_516
MEM &SV63timerPre1 = 0
REG &SV63timerPre2 = &USER_MEMORY_517
MEM &SV63timerPre2 = 1000
REG &SV63timerPre4 = &USER_MEMORY_518
MEM &SV63timerPre4 = 0
REG &SV63timerPre5 = &USER_MEMORY_519
MEM &SV63timerPre5 = 1000

REG &fd100StepMsgTacc = &USER_MEMORY_549

//OP_X Data
REG &OP_Xstatus = &USER_MEMORY_550
BITREG &OP_Xstatus = [|OP_Xons, |OP_Xrun]
MEM &OP_Xstatus = 0
REG &OP_Xcmd = &USER_MEMORY_551
MEM &OP_Xcmd = 0
REG &OP_Xmsg = &USER_MEMORY_552
MEM &OP_Xmsg = 0

//OP_START Data
REG &OP_STARTstatus = &USER_MEMORY_553
BITREG &OP_STARTstatus = [|OP_STARTons, |OP_STARTrun]
MEM &OP_STARTstatus = 0
REG &OP_STARTcmd = &USER_MEMORY_554
MEM &OP_STARTcmd = 0
REG &OP_STARTmsg = &USER_MEMORY_555
MEM &OP_STARTmsg = 0

//OP_EMPTYP Data
REG &OP_EMPTYPstatus = &USER_MEMORY_556
BITREG &OP_EMPTYPstatus = [|OP_EMPTYPons, |OP_EMPTYPrun]
MEM &OP_EMPTYPstatus = 0
REG &OP_EMPTYPcmd = &USER_MEMORY_557
MEM &OP_EMPTYPcmd = 0
REG &OP_EMPTYPmsg = &USER_MEMORY_558
MEM &OP_EMPTYPmsg = 0

//OP_BW Data
REG &OP_BWstatus = &USER_MEMORY_559
BITREG &OP_BWstatus = [|OP_BWons, |OP_BWrun]
MEM &OP_BWstatus = 0
REG &OP_BWcmd = &USER_MEMORY_560
MEM &OP_BWcmd = 0
REG &OP_BWmsg = &USER_MEMORY_561
MEM &OP_BWmsg = 0

//OP_STOP Data
REG &OP_STOPstatus = &USER_MEMORY_562
BITREG &OP_STOPstatus = [|OP_STOPons, |OP_STOPrun]
MEM &OP_STOPstatus = 0
REG &OP_STOPcmd = &USER_MEMORY_563
MEM &OP_STOPcmd = 0
REG &OP_STOPmsg = &USER_MEMORY_564
MEM &OP_STOPmsg = 0

//OP_RESET Data
REG &OP_RESETstatus = &USER_MEMORY_565
BITREG &OP_RESETstatus = [|OP_RESETons, |OP_RESETrun]
MEM &OP_RESETstatus = 0
REG &OP_RESETcmd = &USER_MEMORY_566
MEM &OP_RESETcmd = 0
REG &OP_RESETmsg = &USER_MEMORY_567
MEM &OP_RESETmsg = 0

//OP_CONC Data
REG &OP_CONCstatus = &USER_MEMORY_568
BITREG &OP_CONCstatus = [|OP_CONCons, |OP_CONCrun]
MEM &OP_CONCstatus = 0
REG &OP_CONCcmd = &USER_MEMORY_569
MEM &OP_CONCcmd = 0
REG &OP_CONCmsg = &USER_MEMORY_570
MEM &OP_CONCmsg = 0

//OP_EMPTYR Data
REG &OP_EMPTYRstatus = &USER_MEMORY_571
BITREG &OP_EMPTYRstatus = [|OP_EMPTYRons, |OP_EMPTYRrun]
MEM &OP_EMPTYRstatus = 0
REG &OP_EMPTYRcmd = &USER_MEMORY_572
MEM &OP_EMPTYRcmd = 0
REG &OP_EMPTYRmsg = &USER_MEMORY_573
MEM &OP_EMPTYRmsg = 0

// Run timer data
REG &runTimerSecondsx100 = &USER_MEMORY_572
REG &runTimerSeconds = &USER_MEMORY_573
REG &runTimerMinutes = &USER_MEMORY_574
REG &runTimerHours = &USER_MEMORY_575
REG &runTimerDays = &USER_MEMORY_576


// Up and down buttons
REG &buttonStatus = &USER_MEMORY_577
BITREG &buttonStatus = [|upButtonPressed, |downButtonPressed]
MEM &buttonStatus = 0




MEM &CODE_BLANKING=0
MEM &VIEW_MODE_BLANKING=0
MEM &SETPOINT_BLANKING=0

//Setup Datalogging
MEM &LOG_REG1 = ADDR(&LT01)
MEM &LOG_REG2 = ADDR(&PT04)
MEM &LOG_REG3 = ADDR(&TT01)
MEM &LOG_REG4 = ADDR(&FT02)
MEM &LOG_REG5 = ADDR(&PP01S)
MEM &LOG_REG6 = ADDR(&PP02S)
MEM &LOG_REG7 = ADDR(&fd100StepNumber)
MEM &LOG_REG8 = ADDR(&fault)
MEM &LOG_REG9 = 0
MEM &LOG_REG10 = 0
MEM &LOG_REG11 = 0
MEM &LOG_REG12 = 0
MEM &LOG_REG13 = 0
MEM &LOG_REG14 = 0
MEM &LOG_REG15 = 0
MEM &LOG_REG16 = 0
MEM &LOG_REG17 = 0
MEM &LOG_REG18 = 0
MEM &LOG_REG19 = 0
MEM &LOG_REG20 = 0
MEM &LOG_REG21 = 0
MEM &LOG_REG22 = 0
MEM &LOG_REG23 = 0
MEM &LOG_REG24 = 0
MEM &LOG_REG25 = 0
MEM &LOG_REG26 = 0
MEM &LOG_REG27 = 0
MEM &LOG_REG28 = 0
MEM &LOG_REG29 = 0
MEM &LOG_REG30 = 0
MEM &LOG_REG31 = 0
MEM &LOG_REG32 = 0  


// *****************************************************************************
// *
// *                     Reset Macro
// *
// *****************************************************************************

// This macro is called when the power is turned on to the controller
  

RESET_MACRO:
  &displayState = 0
  &fd100StepNumber = 0
  &fd100StepNumberLastLog = 0
  &T0acc = 0
  &T1acc = 0
  &T2acc = 0
  |AFI = OFF
  &FT01count = 0
  &fault = 0
  &faultLastLog = 0
  
  // Switch all valves to auto
  &IV01cmd = 1
  &IV02cmd = 1
  &IV03cmd = 1
  &IV05cmd = 1
  &IV06cmd = 1
  &IV07cmd = 1
  &IV08cmd = 1
  &IV09cmd = 1
  &IV10cmd = 1
  &IV17cmd = 1
  &SV62cmd = 1
  &SV63cmd = 1
  
  // Switch all pumps to auto
  &PP01cmd = 1
  &PP02cmd = 1 
  
END



// *****************************************************************************
// *
// *                     Main Macro
// *
// *****************************************************************************

// This macro is called repeatedly while the controller is running



MAIN_MACRO:

 //Get the time since the start of the last main macro scan
 &lastScanTimeFast = &FAST_TIMER1 
 &FAST_TIMER1 = &FAST_TIMER1 - &lastScanTimeFast
 
 &lastScanTimeShort = &SHORT_TIMER1
 &SHORT_TIMER1 = &SHORT_TIMER1 - &lastScanTimeShort

 // Increment the "on timer"
 &runTimerSecondsx100 = &runTimerSecondsx100 + &lastScanTimeFast
 IF (&runTimerSecondsx100 >= 100) THEN
  &runTimerSecondsx100 = &runTimerSecondsx100 - 100
  &runTimerSeconds = &runTimerSeconds + 1
 ENDIF
 IF (&runTimerSeconds >= 60) THEN
  &runTimerSeconds = &runTimerSeconds - 60
  &runTimerMinutes = &runTimerMinutes + 1
 ENDIF
 IF (&runTimerMinutes >= 60) THEN
  &runTimerMinutes = &runTimerMinutes - 60
  &runTimerHours = &runTimerHours + 1
 ENDIF
 IF (&runTimerHours >=24 ) THEN
  &runTimerHours = &runTimerHours - 24
  &runTimerDays = &runTimerDays + 1
 ENDIF

 // Calculate Flowrate -- as at 2017-06-29 the capture pin wasn't working, thus
 // FT01count isn't updating and so FT01 is locked at zero.
 &FT01time = &FT01time + &lastScanTimeShort
 IF (&FT01time >= 20) THEN
  &FT01time = 0
  &FT01 = &FT01count * 235.35
  &FT01count = 0
 ENDIF 

 &LT01 = ((&CH2 - 90) * 0.122)
 &LT02 = ((&CH6 - 90) * 0.122)
 &PT01 = (&CH7 * 0.6)
 &PT04 = (&CH3 * 1)
 &TT01 = (&CH4 * 0.1)
 &FT02 = ((&CH5 + 30) * 0.5059)
 
 // Start the pass by assuming there aren't any faults
 &faultNew = 0
 // Check for faults
 IF &TT01 > &TT01SP01 AND &fd100StepNumber<>0 THEN
  &faultNew = 1  // High temperature and not stopped
 ENDIF
 IF &faultNew > 0 THEN
  // A fault has been detected; overwrite the fault variable
  &fault = &faultNew
 ELSIF |PB05 = ON THEN
  // No faults were detected in this pass and the reset button (PB05) has been
  // pushed.  This clears the fault variable.
  &fault = &faultNew
 ENDIF
 
 // Set the fault light (PB05_L)
 IF &fault = 0 THEN
  |PB05_L = OFF
 ELSE
  |PB05_L = ON 
 ENDIF  
 
 |IV01eng = |IV01_E
 |IV01deeng = |IV01_D
 |IV02eng = |IV02_E
 |IV02deeng = |IV02_D
 |IV03eng = |IV03_E
 |IV03deeng = |IV03_D
 |IV05eng = |IV05_E
 |IV05deeng = |IV05_D
 |IV06eng = |IV06_E
 |IV06deeng = |IV06_D
 |IV07eng = |IV07_E
 |IV07deeng = |IV07_D
 |IV08eng = |IV08_E
 |IV08deeng = |IV08_D
 |IV09eng = |IV09_E
 |IV09deeng = |IV09_D
 |IV10eng = |IV10_E
 |IV10deeng = |IV10_D
 |IV17eng = |IV17_E
 |IV17deeng = |IV17_D
  
  

 // ****************************************************************************
 // *
 // *                     Display
 // *                                                
 // ****************************************************************************
  
// Check if we're in display mode; if so, handle the pressing of buttons 
 IF (&EDIT_STATE = 0) THEN
  // Check if the down button has been pushed
  IF (|DOWN_BUTTON = ON) THEN
   |downButtonPressed = ON 
  ENDIF
  
  // Check if the up button has been pushed
  IF (|UP_BUTTON = ON) THEN
   |upButtonPressed = ON 
  ENDIF
  
  // Check if the down button has been released
  IF (|downButtonPressed = ON and |DOWN_BUTTON = OFF) THEN
   |downButtonPressed = OFF
   // Increment display state and loop back to the beginning if necessary
   &displayState = &displayState + 1
   IF (&displayState > 11) THEN
    // Loop back to zero is we've got passed the maximum page  
    &displayState = 0
   ENDIF  
   WRITE "" // Stop the display of any text
  ENDIF
  
  // Check if the up button has been released
  IF (|upButtonPressed = ON and |UP_BUTTON = OFF) THEN
   |upButtonPressed = OFF
   // Decrement display state and loop back to the beginning if necessary
   &displayState = &displayState - 1
   IF (&displayState < 0) THEN
    // Loop back to the maximum page if we go up from the first
    &displayState = 11
   ENDIF  
   WRITE "" // Stop the display of any text
  ENDIF
 ENDIF



 //Determine which values to show on local display
 SELECT &displayState 
  CASE  0:
   &DATA_SOURCE_DISPLAY1 = ADDR(&PT01)
   &DATA_SOURCE_DISPLAY2 = ADDR(&PT04)
  
  CASE  1: 
   &DATA_SOURCE_DISPLAY1 = ADDR(&LT01)
   &DATA_SOURCE_DISPLAY2 = ADDR(&LT02)
  
  CASE  2: 
   &DATA_SOURCE_DISPLAY1 = ADDR(&PP01S)
   &DATA_SOURCE_DISPLAY2 = ADDR(&PP02S)
  
  CASE  3:
   //Display Step Msg
   &fd100StepMsgTacc = &fd100StepMsgTacc + &lastScanTimeShort
   IF &EDIT_STATE <> 0 THEN
    &fd100StepMsgTacc = 0
   ENDIF
   IF &fd100StepMsgTacc > 100 THEN
    WRITE 2 fd100StepMsgArray[&fd100StepNumber]
    &fd100StepMsgTacc = 0
   ENDIF
   
   &DATA_SOURCE_DISPLAY1 = ADDR(&T0acc)
   &DATA_SOURCE_DISPLAY2 = ADDR(&fd100StepNumber)
  
  CASE  4:
   &DATA_SOURCE_DISPLAY1 = ADDR(&T1acc)
   &DATA_SOURCE_DISPLAY2 = ADDR(&T2acc)

  CASE  5:
   &DATA_SOURCE_DISPLAY1 = ADDR(&FT01)
   &DATA_SOURCE_DISPLAY2 = ADDR(&FT02)
     
  CASE  6:
   //Display Step Msg
   &fd100StepMsgTacc = &fd100StepMsgTacc + &lastScanTimeShort
   IF &EDIT_STATE <> 0 THEN
    &fd100StepMsgTacc = 0
   ENDIF
   IF &fd100StepMsgTacc > 100 THEN
    WRITE 2 faultMsgArray[&fault]
    &fd100StepMsgTacc = 0
   ENDIF
   //Display Step Msg    
   &DATA_SOURCE_DISPLAY1 = ADDR(&TT01)
   &DATA_SOURCE_DISPLAY2 = ADDR(&fault)
   
  CASE  7:
   &DATA_SOURCE_DISPLAY1 = 0 // Clear top line (can only write to one line)
   WRITE 2 "On: "+&runTimerDays+"d "+&runTimerHours+":"+&runTimerMinutes+":"+&runTimerSeconds
   
  CASE  8:
   &DATA_SOURCE_DISPLAY1 = ADDR(&T1SP13)
   WRITE 2 "      T1SP13 (x10s; Duration of production before backwash)      " 

  CASE  9:
   &DATA_SOURCE_DISPLAY1 = ADDR(&T0SP10)
   WRITE 2 "      T0SP10 (x10s; Module 1 backflush duration)      " 

  CASE 10:
   &DATA_SOURCE_DISPLAY1 = ADDR(&T0SP12)
   WRITE 2 "      T0SP12 (x10s; Module 2 backflush duration)      " 

  CASE 11:
   &DATA_SOURCE_DISPLAY1 = ADDR(&T0SP14)
   WRITE 2 "      T0SP14 (x10s; Module 3 backflush duration)      " 
 
      
  DEFAULT:
 ENDSEL

 IF |F1_BUTTON = ON AND |F3_BUTTON =ON AND &STATE = 0 THEN
  SELECT &displayState 
   CASE  1:
    EDIT &LT01SP01
    &EDIT_MAX=1000
    &EDIT_MIN=0
    &EDIT_DEF=&LT01SP01
    WRITE ""
    WRITE "LT01SP01 (%)"
    &STATE=ADDR(&LT01SP01)

   CASE  2:
    EDIT &PP01SP01
    &EDIT_MAX=10000
    &EDIT_MIN=0
    &EDIT_DEF=&PP01SP01
    WRITE ""
    WRITE "PP01SP01 (%)"
    &STATE=ADDR(&PP01SP01)
    
   CASE  3:
    EDIT &T0SP09
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T0SP09
    WRITE ""
    WRITE "T0SP09 (s)"
    &STATE=ADDR(&T0SP09)
    
   CASE   4:
    EDIT &T1SP13
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T1SP13
    WRITE ""
    WRITE "T1SP13 (s)"
    &STATE=ADDR(&T1SP13)

   CASE   8:
    EDIT &T1SP13   
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T1SP13
    &STATE=ADDR(&T1SP13)
    // Accept the scrolling text from the display page

   CASE   9:
    EDIT &T0SP10
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T0SP10
    &STATE=ADDR(&T0SP10)
    // Accept the scrolling text from the display page

   CASE  10:
    EDIT &T0SP12
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T0SP12
    &STATE=ADDR(&T0SP12)
    // Accept the scrolling text from the display page
    
   CASE  11:
    EDIT &T0SP14
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T0SP14
    &STATE=ADDR(&T0SP14)
    // Accept the scrolling text from the display page

   DEFAULT:
  ENDSEL  
 ENDIF

 IF |F1_BUTTON = ON AND |F4_BUTTON =ON AND &STATE = 0 THEN
  SELECT &displayState
   CASE  1:
    EDIT &LT02SP01
    &EDIT_MAX=1000
    &EDIT_MIN=0
    &EDIT_DEF=&LT02SP01
    WRITE ""
    WRITE "LT02SP01 (%)"
    &STATE=ADDR(&LT02SP01)    
   
   CASE  2:
    EDIT &PP02SP02
    &EDIT_MAX=10000
    &EDIT_MIN=0
    &EDIT_DEF=&PP02SP02
    WRITE ""
    WRITE "PP02SP02 (%)"
    &STATE=ADDR(&PP02SP02)
    
   CASE  4:
    EDIT &T2SP13
    &EDIT_MAX=32000
    &EDIT_MIN=0
    &EDIT_DEF=&T2SP13
    WRITE ""
    WRITE "T2SP13 (s)"
    &STATE=ADDR(&T2SP13) 
    
   DEFAULT:
  ENDSEL  
 ENDIF





 // ****************************************************************************
 //
 //                      Production sequence: FD101
 //
 // ****************************************************************************

 &Temp1 = &SEL_TYPE
 IF (|OP_CONCons = ON) THEN
  SELECT &SEL_TYPE
   CASE 1: //SS_Production_Fill
    &Temp1 = 2
      
   CASE 2: //SS_Production_Concentrate
    &Temp1 = 1
               
   CASE 3: //SS_CIP
    // Do nothing
              
   CASE 4: //Poly_Production_Fill
    &Temp1 = 5
        
   CASE 5: //Poly_Production_Concentrate
    &Temp1 = 4
         
   CASE 6: //Poly_CIP                     
    // Do nothing
    
   DEFAULT:
    // Do nothing
  ENDSEL
 ENDIF
 &SEL_TYPE = &Temp1  // Note that this is overwritten in Step 0 of FD100, but is
                     // valid for any other step number.



 // ****************************************************************************
 //
 //                      Pump Speed Calculations
 //
 // ****************************************************************************

 
    // Calculate pump speed based on level; set between minimum and maximum 
    // speeds for pump 2 based on minimum and maxmimum levels in permeate tank
    IF &LT01 < &LT01SP01 THEN
     &Calc06 = &PP02SP05
    ELSIF &LT01 > &LT01SP02 THEN
     &Calc06 = &PP02SP06
    ELSE
     &Calc01 = &PP02SP06 - &PP02SP05
     &Calc02 = &LT01 - &LT01SP01
     &Calc03 = &LT01SP02 - &LT01SP01
     IF &Calc03 < 1 THEN
      &Calc03 = 1
     ENDIF 
     &Calc04 = &Calc01 * &Calc02
     &Calc05 = &Calc04 / &Calc03       
     &Calc06 = &PP02SP05 + &Calc05
    ENDIF
    
    IF &Calc06 < &PP02SP05 THEN
     &PP02S_LVL = &PP02SP05          
    ELSIF &Calc06 > &PP02SP06 THEN
     &PP02S_LVL = &PP02SP06
    ELSE
     &PP02S_LVL = &Calc06    
    ENDIF



 // ****************************************************************************
 //
 //                      Main control sequence: FD100
 //
 // ****************************************************************************
  
 &Temp1 = &fd100StepNumber
 SELECT &fd100StepNumber
  CASE 0: //Reset
   // Check the state of the switch indicating membrane type 
   // (SS = Stainless Steel, Poly = Polysulfone)
   // SW08 is the CIP/Production switch
   // SW09_1 is Stainless Steel
   // SW09_2 is Polysulfone
   &SEL_TYPE = 0 //0=NA 1=SS_Prod 2=SS_Prod_Conc 3=SS_CIP 4=Poly_Prod 5=Poly_Prod_Conc 6=Poly_CIP
   IF |SW09_1 = ON THEN
    // Stainless Steel selected
    IF |SW08 = ON THEN      
     // CIP Selected
     &SEL_TYPE = 3 
    ELSE
     // Production selected
     &SEL_TYPE = 1
    ENDIF
   ENDIF
   IF |SW09_2 = ON THEN
    // Polysulfone selected
    IF |SW08 = ON THEN
     // CIP Selected
     &SEL_TYPE = 6 
    ELSE
     // Production selected
     &SEL_TYPE = 4
    ENDIF
   ENDIF 
   
   |PB01_L = OFF  // Start button light
   |PB02_L = OFF
   |PB03_L = OFF
   |PB04_L = ON   // Stop button light
   |PB06_L = OFF   
   |IV01autoOut = OFF //Module 1 Inlet 
   |IV02autoOut = OFF //Module 2 Inlet
   |IV03autoOut = OFF //Module 3 Inlet
   |IV05autoOut = OFF //Module 3 Backwash
   |IV06autoOut = OFF //Module 2 Backwash
   |IV07autoOut = OFF //Module 1 Backwash
   |IV08autoOut = OFF //Module 3 Permeate
   |IV09autoOut = OFF //Module 1 Permeate            
   |IV10autoOut = OFF //Module 2 Permeate
   |IV17autoOut = OFF //Permeate Out
   |SV62autoOut = OFF //Retentate/FeedTank Out
   |SV63autoOut = OFF //FeedTank Inlet
   |PP01autoOut = OFF //Main Feed Pump
   //&PP01S = 0 
   |PP02autoOut = OFF //Backwash Pump
   //&PP02S = 0

   SELECT &SEL_TYPE
    CASE 1: //SS_Production_Fill      
     |PB07_L = OFF //CONC_PUSHBUTTON_LED
     &T2acc = 0
       
    CASE 2: //SS_Production_Concentrate
     |PB07_L = ON //CONC_PUSHBUTTON_LED
     &T2acc = 0       
               
    CASE 3: //SS_CIP
     |PB07_L = OFF //CONC_PUSHBUTTON_LED
              
    CASE 4: //Poly_Production_Fill
     |PB07_L = OFF //CONC_PUSHBUTTON_LED
     &T2acc = 0       
        
    CASE 5: //Poly_Production_Concentrate
     |PB07_L = ON //CONC_PUSHBUTTON_LED
     &T2acc = 0
         
    CASE 6: //Poly_CIP
     |PB07_L = OFF //CONC_PUSHBUTTON_LED
     // Allow the membranes to drain if the system is stopped and CIP is
     // selected
     |IV05autoOut = ON
     |IV06autoOut = ON
     |IV07autoOut = ON
     |IV08autoOut = ON
     |IV09autoOut = ON            
     |IV10autoOut = ON
     
                            
    DEFAULT:
   ENDSEL
   
   &T0acc = 0  
   
   IF (|OP_STARTons = ON) and (&fault = 0) THEN
    &Temp1 = 17
   ELSIF (|OP_BWons = ON) and (&fault = 0) THEN
    &Temp1 = 7
   ELSIF (|OP_EMPTYPons = ON) and (&fault = 0) THEN
    &Temp1 = 18
   ELSIF (|OP_EMPTYRons = ON) and (&fault = 0) THEN
    &Temp1 = 19 
   ENDIF

  CASE 17: // Start filling the feed tank
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = ON   // Start button
    |PB02_L = OFF
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate

    |IV17autoOut = OFF //Permeate Out   
    |SV62autoOut = OFF //Retentate/FeedTank Out    
           
    |PP01autoOut = OFF
    &PP01S = 0
    
    |PP02autoOut = OFF
    &PP02S = 0

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
    ENDSEL
    
    //Transistion Condtions
    &T0acc = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      IF (&LT02 > &LT02SP05) THEN
       &Temp1 = 1
      ENDIF
            
     CASE 2: //SS_Production_Concentrate
       &Temp1 = 1 
     
     CASE 3: //SS_CIP
       &Temp1 = 1
      
     CASE 4: //Poly_Production
      IF (&LT02 > &LT02SP05) THEN
       &Temp1 = 1
      ENDIF     
      
     CASE 5: //Poly_Production_Conc
       &Temp1 = 1     
     
     CASE 6: //Poly_CIP
       &Temp1 = 1             // 2017-04-03: Matthew: Why is this not like 
                              // Poly_Production?  Why do we not wait for the 
                              // tank to fill?    
            
    ENDSEL
    
   //Fault state         
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
   
  CASE 1: // Pump out the permeate tank
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = ON
    |PB02_L = OFF
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate

    |IV17autoOut = ON //Permeate Out   
    |SV62autoOut = OFF //Retentate/FeedTank Out    
           
    |PP01autoOut = OFF
    &PP01S = 0
    
    // Quietly pump out permeate tank if it's over the set point limit
    |PP02autoOut = ON
    &PP02S = &PP02S_LVL

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
    ENDSEL
    
    //Transistion Condtions
    &T0acc = 0
    IF |OP_STOPons = ON THEN
       &Temp1 = 20
    ELSIF (&LT01 <= &LT01SP03) THEN
       &Temp1 = 3
    ENDIF
    
    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF            
     CASE 2: //SS_Production_Concentrate      
     CASE 3: //SS_CIP      
     CASE 4: //Poly_Production
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF           
     CASE 5: //Poly_Production_Conc           
     CASE 6: //Poly_CIP            
    ENDSEL
    
   //Fault state         
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
 
  CASE 3: // Production / CIP
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = ON
    |PB02_L = OFF
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |SV62autoOut = OFF //Retentate/FeedTank Out     
           
    |PP01autoOut = ON

    // Turn pump 2 off once the calculated speed gets to the minimum (SP05)    
    IF (&PP02S_LVL <= &PP02SP05) THEN
     |PP02autoOut = OFF
     |IV17autoOut = OFF    
    ENDIF
    // Turn pump 2 back on once the calculated speeds gets above a minimum (SP07)
    IF (&PP02S_LVL >= &PP02SP07) THEN
     |PP02autoOut = ON
     |IV17autoOut = ON
    ENDIF
    &PP02S = &PP02S_LVL

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &T2acc = 0 //Reset CIP Timer
      &PP01S = &PP01SP11
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = 0 //Reset CIP Timer
      &PP01S = &PP01SP21 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort
      &PP01S = &PP01SP31      
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &T2acc = 0 //Reset CIP Timer
      &PP01S = &PP01SP41
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = 0 //Reset CIP Timer
      &PP01S = &PP01SP51 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort
      &PP01S = &PP01SP61
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = 0 //Reset CIP Timer
      &PP01S = &PP01SP01
      
    ENDSEL

    //Transistion Conditions   
    &T0acc = 0
    &T1acc = &T1acc + &lastScanTimeShort
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF (&T2acc >= &T2SP13) THEN // Check if CIP timer is over limit
     &Temp1 = 20
     &T2acc = 0 //Reset CIP Timer
    ELSIF (&T1acc >= &T1SP13) OR (|OP_BWons = ON) THEN  // Checks if production timer is up before going to a backwash
     &Temp1 = 7
    ELSIF &LT01 >= &LT01SP04 THEN
     &Temp1 = 1
    ENDIF
    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF            
     CASE 2: //SS_Production_Concentrate      
     CASE 3: //SS_CIP      
     CASE 4: //Poly_Production
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF           
     CASE 5: //Poly_Production_Conc           
     CASE 6: //Poly_CIP            
    ENDSEL
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF           

  CASE 7: // Fill permeate tank for backwash
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = ON
    |PB02_L = OFF
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out
        
    |PP01autoOut = ON
    |PP02autoOut = OFF
    &PP02S = 0
    
    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP11
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
      &PP01S = &PP01SP21
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort
      &PP01S = &PP01SP31
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP41
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP51 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort
      &PP01S = &PP01SP61
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP01
      
    ENDSEL
    
    &T0acc = 0
    
    //Transistion Conditions
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &LT01 >= &LT01SP05 THEN
     &Temp1 = 9
    ENDIF
    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF            
     CASE 2: //SS_Production_Concentrate      
     CASE 3: //SS_CIP      
     CASE 4: //Poly_Production
      IF (&LT02 <= &LT02SP04) THEN
       &Temp1 = 17
      ENDIF           
     CASE 5: //Poly_Production_Conc           
     CASE 6: //Poly_CIP            
    ENDSEL    
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF

  CASE 9: //Module 1 Backwash - Set Valves
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    //|IV01autoOut = ON Module 1 Inlet Only For Poly (see below)
    |IV07autoOut = ON //Module 1 Backwash
    |IV09autoOut = ON //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out    

    |PP01autoOut = ON
    |PP02autoOut = ON

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      |IV01autoOut = OFF //Module 1 Inlet
      &PP01S = &PP01SP12
      &PP02S = &PP02SP12
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      |IV01autoOut = OFF //Module 1 Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP22 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      |IV01autoOut = OFF //Module 1 Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP32
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      |IV01autoOut = ON //Module 1 Inlet
      &PP01S = &PP01SP42
      &PP02S = &PP02SP42
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      |IV01autoOut = ON //Module 1 Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP52 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      |IV01autoOut = ON //Module 1 Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP62
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |IV01autoOut = ON //Module 1 Inlet
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP02
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort
    
    //Transistion Conditions    
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP09 THEN
     &Temp1 = 10
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF

  
  CASE 10: //Module 1 Backwash - Run Pump
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = ON //Module 1 Inlet
    |IV07autoOut = ON //Module 1 Backwash
    |IV09autoOut = ON //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out     
    
    |PP01autoOut = ON
    |PP02autoOut = ON


    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP12
      &PP02S = &PP02SP13
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP23 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP33
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP42
      &PP02S = &PP02SP43
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP53 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP63
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP03
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort
    //dwb 2010 09 15
    &T1acc = 0
    
    //Transistion Conditions
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP10 THEN
     SELECT &SEL_TYPE
      CASE 1:        //SS_Prod
       &Temp1 = 3
      CASE 2:        //SS_Prod_Conc
       &Temp1 = 3
      CASE 3:        //SS_CIP
       &Temp1 = 3
      CASE 4:        //Poly_Production
       &Temp1 = 11
      CASE 5:        //Poly_Production_Conc
       &Temp1 = 11 
      CASE 6:        //Poly_CIP
       &Temp1 = 11                     
      DEFAULT:
       &Temp1 = 3
     ENDSEL 
    ENDIF

   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
   
  CASE 11: //Module 2 Backwash - Set Valves
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = ON //Module 2 Inlet
    |IV06autoOut = ON //Module 2 Backwash
    |IV10autoOut = ON //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out    
     
    |PP01autoOut = ON    
    |PP02autoOut = ON
    

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP12
      &PP02S = &PP02SP12
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP22 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP32
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP42
      &PP02S = &PP02SP42
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP52 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP62
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP02
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort

    //Transistion Conditions    
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP11 THEN
     &Temp1 = 12
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
  
  CASE 12: //Module 2 Backwash - Run Pump
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF

    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = ON //Module 2 Inlet
    |IV06autoOut = ON //Module 2 Backwash
    |IV10autoOut = ON //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out
     
    |PP01autoOut = ON
    |PP02autoOut = ON

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP12
      &PP02S = &PP02SP13
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP23 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP33
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP42
      &PP02S = &PP02SP43
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP53 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP63
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP03
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort
    
    //Transistion Conditions
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP12 THEN
     &Temp1 = 13
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
      
  CASE 13: //Module 3 Backwash - Set Valves
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = ON //Module 3 Inlet
    |IV05autoOut = ON //Module 3 Backwash
    |IV08autoOut = ON //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out    
    
    |PP01autoOut = ON
    |PP02autoOut = ON

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP12
      &PP02S = &PP02SP12
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP22 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP32
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP42
      &PP02S = &PP02SP42
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP52 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP62
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP02
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort
    
    //Transistion Conditions 
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP13 THEN
     &Temp1 = 14
    ENDIF

   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF

  
  CASE 14: //Module 3 Backwash - Run Pump
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = ON
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = OFF

    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = ON //Module 3 Inlet
    |IV05autoOut = ON //Module 3 Backwash
    |IV08autoOut = ON //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out 
        
    |PP01autoOut = ON
    |PP02autoOut = ON

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP12
      &PP02S = &PP02SP13
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP22
      &PP02S = &PP02SP23 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP32
      &PP02S = &PP02SP33
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      IF (&LT02 > &LT02SP02) THEN
       |SV63autoOut = OFF //FeedTank Inlet
      ELSIF (&LT02 < &LT02SP03) THEN
       |SV63autoOut = ON //FeedTank Inlet
      ENDIF
      &PP01S = &PP01SP42
      &PP02S = &PP02SP43
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP52
      &PP02S = &PP02SP53 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &T2acc = &T2acc + &lastScanTimeShort //CIP Timer
      &PP01S = &PP01SP62
      &PP02S = &PP02SP63
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      &PP01S = &PP01SP02
      &PP02S = &PP02SP03
      
    ENDSEL

    &T0acc = &T0acc + &lastScanTimeShort
    &T1acc = 0
    
    //Transistion Conditions
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP14 THEN
     &Temp1 = 3
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF
   ENDIF
   
  CASE 18: //Empty Permeate Tank
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = OFF
    |PB03_L = ON
    |PB04_L = OFF
    |PB06_L = OFF
    
    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = ON //Permeate Out
    |SV62autoOut = OFF //Retentate/FeedTank Out    
        
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = ON
    &PP02S = &PP02SP04

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
    ENDSEL
   
    IF &LT01 < &LT01SP06 THEN
     &T0acc = &T0acc + &lastScanTimeShort
    ELSE
     &T0acc = 0
    ENDIF
    
    //Transistion Conditions   
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP18 THEN
     &Temp1 = 20
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF 
   ENDIF

  CASE 19: //Empty Feed/Retentate Tank
   //No fault state
   IF &fault = 0 THEN
    |PB01_L = OFF
    |PB02_L = OFF
    |PB03_L = OFF
    |PB04_L = OFF
    |PB06_L = ON   // Retentate Out light

    |IV01autoOut = OFF //Module 1 Inlet
    |IV07autoOut = OFF //Module 1 Backwash
    |IV09autoOut = OFF //Module 1 Permeate
         
    |IV02autoOut = OFF //Module 2 Inlet
    |IV06autoOut = OFF //Module 2 Backwash
    |IV10autoOut = OFF //Module 2 Permeate
            
    |IV03autoOut = OFF //Module 3 Inlet
    |IV05autoOut = OFF //Module 3 Backwash
    |IV08autoOut = OFF //Module 3 Permeate
    
    |IV17autoOut = OFF //Permeate Out
    |SV62autoOut = ON  //Retentate/FeedTank Out
        
    |PP01autoOut = ON
    &PP01S = &PP01SP03
    |PP02autoOut = OFF
    &PP02S = 0

    SELECT &SEL_TYPE
     CASE 1: //SS_Prod
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 2: //SS_Production_Concentrate
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 3: //SS_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 4: //Poly_Production
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
     CASE 5: //Poly_Production_Conc
      |PB07_L = ON //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet 
     
     CASE 6: //Poly_CIP
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
                           
     DEFAULT:
      |PB07_L = OFF //CONC_PUSHBUTTON_LED
      |SV63autoOut = OFF //FeedTank Inlet
      
    ENDSEL
   
    // If the feed tank is below the 'empty' level, start timing
    IF &LT02 < &LT02SP01 THEN
     &T0acc = &T0acc + &lastScanTimeShort
    ELSE
     &T0acc = 0
    ENDIF
    
    &T2acc = 0  //Reset CIP Timer
    
    //Transistion Conditions   
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ELSIF &T0acc >= &T0SP19 THEN
     &Temp1 = 20
    ENDIF
    
   //Fault State             
   ELSE 
    |PP01autoOut = OFF
    &PP01S = 0
    |PP02autoOut = OFF
    &PP02S = 0
    IF |OP_STOPons = ON THEN
     &Temp1 = 20
    ENDIF 
   ENDIF   
     
  CASE 20: //End
  
   |IV01autoOut = OFF //Module 1 Inlet
   |IV07autoOut = OFF //Module 1 Backwash
   |IV09autoOut = OFF //Module 1 Permeate
         
   |IV02autoOut = OFF //Module 2 Inlet
   |IV06autoOut = OFF //Module 2 Backwash
   |IV10autoOut = OFF //Module 2 Permeate
            
   |IV03autoOut = OFF //Module 3 Inlet
   |IV05autoOut = OFF //Module 3 Backwash
   |IV08autoOut = OFF //Module 3 Permeate
    
   |IV17autoOut = OFF //Permeate Out
   |SV62autoOut = OFF //Retentate/FeedTank Out
   |SV63autoOut = OFF //FeedTank Inlet  
  
   |PP01autoOut = OFF
   &PP01S = 0
   |PP02autoOut = OFF
   &PP02S = 0

   &Temp1 = 0
   
  CASE 30:
   // Manual Test Mode XXX
   
   |PB01_L = |PB01  // Start button
   |PB02_L = |PB02  // Backflush button
   |PB03_L = |PB03  // Permeate button
   |PB04_L = |PB04  // Stop button
   |PB05_L = |PB05  // Reset button
   |PB06_L = |PB06  // Retentate Out button
   |PB07_L = |PB07  // Concentrate button

  
  DEFAULT:
   &Temp1 = 0
   
 ENDSEL 
 
 IF &Temp1 <> &fd100StepNumber THEN
  &fd100StepNumber = &Temp1
  &T0acc = 0
 ENDIF
 
 //Log data to SD Card
 &Logtime = &Logtime + &lastScanTimeShort
 IF (&fd100StepNumberLastLog <> &fd100StepNumber) OR (&faultLastLog <> &fault) OR (&Logtime >= 600) THEN
  &Logtime = 0
  &faultLastLog = &fault
  &fd100StepNumberLastLog = &fd100StepNumber
  FORCE_LOG 
 ELSIF (&fd100StepNumber = 0) THEN
  &Logtime = 0 
 ENDIF
 
 // ****************************************************************************
 //
 //                      Selection logic for push buttons
 //
 // ****************************************************************************
 
 IF (|PB01 = ON and &OP_STARTcmd = 0 and &SEL_TYPE > 0) THEN
  &OP_STARTcmd = 2
 ELSIF (|PB01 = OFF and &OP_STARTcmd = 1) THEN
  &OP_STARTcmd = 0  
 ENDIF

 IF (|PB04 = ON and &OP_STOPcmd = 0) THEN
  &OP_STOPcmd = 2
 ELSIF (|PB04 = OFF and &OP_STOPcmd = 1) THEN
  &OP_STOPcmd = 0  
 ENDIF
 
 IF (|PB02 = ON and &OP_BWcmd = 0) THEN
  &OP_BWcmd = 2
 ELSIF (|PB02 = OFF and &OP_BWcmd = 1) THEN
  &OP_BWcmd = 0  
 ENDIF
  
 IF (|PB03 = ON and &OP_EMPTYPcmd = 0) THEN
  &OP_EMPTYPcmd = 2
 ELSIF (|PB03 = OFF and &OP_EMPTYPcmd = 1) THEN
  &OP_EMPTYPcmd = 0  
 ENDIF
   
 // 2017-07-03: The following five lines look like a copy and paste error
 // It seems like this sould reference PB04 (the stop button), but instead it
 // is an exact copy of the code of PB05.  PB04 is however already dealt to
 // above.
 //IF (|PB05 = ON and &OP_RESETcmd = 0) THEN
 // &OP_RESETcmd = 2
 //ELSIF (|PB05 = OFF and &OP_RESETcmd = 1) THEN
 // &OP_RESETcmd = 0  
 //ENDIF
 
 IF (|PB05 = ON and &OP_RESETcmd = 0) THEN
  &OP_RESETcmd = 2
 ELSIF (|PB05 = OFF and &OP_RESETcmd = 1) THEN
  &OP_RESETcmd = 0  
 ENDIF
 
 IF (|PB06 = ON and &OP_EMPTYRcmd = 0) THEN
  &OP_EMPTYRcmd = 2
 ELSIF (|PB06 = OFF and &OP_EMPTYRcmd = 1) THEN
  &OP_EMPTYRcmd = 0  
 ENDIF
 
 IF (|PB07 = ON and &OP_CONCcmd = 0) THEN
  &OP_CONCcmd = 2
 ELSIF (|PB07 = OFF and &OP_CONCcmd = 1) THEN
  &OP_CONCcmd = 0  
 ENDIF 
  
  
 // Loop through the seven buttons and set their status bits based on their cmd
 // variables.
 // For buttons under normal (no error) conditions, the cmd variable is set to
 // 2, which turns on both the ons (one shot) and run (running) bits and sets 
 // the cmd to 1.  On the next pass the ons bit is turned off and the run bit 
 // remains on.  When the cmd is set to 0, both bits are turned off.
 FOR &Temp1 = 1 TO 7 STEP 1
  &OP_Xstatus = &OP_Xstatus[&Temp1*3]
  &OP_Xcmd = &OP_Xcmd[&Temp1*3]
  &OP_Xmsg = &OP_Xmsg[&Temp1*3]
  
  SELECT &OP_Xcmd
   CASE 0:
    |OP_Xons = OFF
    |OP_Xrun = OFF
   CASE 1:
    |OP_Xons = OFF
    |OP_Xrun = ON   
   CASE 2:
    IF &OP_Xmsg = 0 THEN
     |OP_Xons = ON
     |OP_Xrun = ON
    ELSE
     //Add code to display msg
    ENDIF
    &OP_Xcmd = 1 
          
   DEFAULT:

  ENDSEL
   
  &OP_Xstatus[&Temp1*3] = &OP_Xstatus
  &OP_Xcmd[&Temp1*3] = &OP_Xcmd
  
 NEXT &Temp1
 


// *****************************************************************************
//
// Valve and Motor logic
//
// ***************************************************************************** 

// Loop through the automatic valves.

 FOR &Temp1 = 1 TO 14 STEP 1
  //Get Values  
  &XXstatus = &XXstatus[&Temp1*8]
  &XXcmd = &XXcmd[&Temp1*8]
  &XXcmd[&Temp1*8] = 0
  &XXtimerState = &XXtimerState[&Temp1*8]
  &XXtimerAcc = &XXtimerAcc[&Temp1*8]
  &XXtimerPre1 = &XXtimerPre1[&Temp1*8]
  &XXtimerPre2 = &XXtimerPre2[&Temp1*8]
  &XXtimerPre4 = &XXtimerPre4[&Temp1*8]
  &XXtimerPre5 = &XXtimerPre5[&Temp1*8]
  
  //cmd 0=none 1=auto 2=manualOff 3=manualOn
  SELECT &XXcmd
   CASE 0:
    //No action
   CASE 1:
    |XXmanualOn = OFF
    |XXmanualOff = OFF

   CASE 2:
    |XXmanualOn = OFF
    |XXmanualOff = ON

   CASE 3:
    |XXmanualOn = ON
    |XXmanualOff = OFF
        
   DEFAULT:

   ENDSEL
  
  //timerState
  SELECT &XXtimerState
   CASE 0: //Deenergised or Stopped
    |XXout = OFF
    IF (|XXfaultEnable = ON AND ((|XXeng = ON AND |XXengEnable = ON) OR (|XXdeeng = OFF AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF    
    IF (|XXmanualOff = ON) THEN
     &XXtimerState = 0
    ELSIF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF (|XXautoOut = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 1
    ENDIF

   CASE 1: //Delay before Energising or Starting
    |XXout = OFF
    IF (|XXfaultEnable = ON AND ((|XXeng = ON AND |XXengEnable = ON) OR (|XXdeeng = OFF AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF 
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 0
    ELSIF ((|XXmanualOn = ON) OR (&XXtimerAcc >= &XXtimerPre1)) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF (|XXautoOut = OFF) THEN
     &XXtimerAcc = 0
     &XXtimerState = 0  
    ENDIF
    
   CASE 2: //Energising or Starting Time
    |XXout = ON
    IF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF ((|XXmanualOn = OFF) AND (|XXautoOut = OFF)) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 4 
    ELSIF (&XXtimerAcc >= &XXtimerPre2) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 3
    ENDIF

   CASE 3: //Energised or Started
    |XXout = ON
    IF (|XXfaultEnable = ON AND ((|XXeng = OFF AND |XXengEnable = ON) OR (|XXdeeng = ON AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3
    ELSIF (|XXmanualOff = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF (|XXautoOut = OFF) THEN
     &XXtimerAcc = 0
     &XXtimerState = 4
    ENDIF 
   
   CASE 4: //Delay before Deenergising or Stopping
    |XXout = ON
    IF (|XXfaultEnable = ON AND ((|XXeng = OFF AND |XXengEnable = ON) OR (|XXdeeng = ON AND |XXdeengEnable = ON))) THEN
     |XXfault = ON
    ELSIF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3
    ELSIF ((|XXmanualOff = ON) OR (&XXtimerAcc >= &XXtimerPre4)) THEN
     &XXtimerAcc = 0
     &XXtimerState = 5
    ELSIF (|XXautoOut = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 3  
    ENDIF 
   
   CASE 5: //Deenergising or Stopping Time
    |XXout = OFF
    IF |XXfaultEnable = ON THEN
     |XXfault = OFF
    ENDIF
    &XXtimerAcc = &XXtimerAcc + &lastScanTimeFast
    IF (|XXmanualOn = ON) THEN
     &XXtimerAcc = 0
     &XXtimerState = 2
    ELSIF ((|XXmanualOff = OFF) AND (|XXautoOut = ON)) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 1 
    ELSIF (&XXtimerAcc >= &XXtimerPre5) THEN 
     &XXtimerAcc = 0 
     &XXtimerState = 0
    ENDIF
           
   DEFAULT:
    &XXtimerAcc = 0
    &XXtimerState = 0
   ENDSEL
   
  //Update Values
  &XXstatus[&Temp1*8] = &XXstatus
  &XXtimerState[&Temp1*8] = &XXtimerState
  &XXtimerAcc[&Temp1*8] = &XXtimerAcc  
 NEXT &Temp1

 |SP1 = OFF
 |SP2 = OFF
 |SP3 = OFF
 |SP4 = OFF

 //Module Inlet Valves  
 |IV01_O = |IV01out //Module 1
 |IV02_O = |IV02out //Module 2
 |IV03_O = |IV03out //Module 3
 
 //Module Outlet Valves 
 |IV05_O = |IV05out //Module 3 
 |IV06_O = |IV06out //Module 2   
 |IV07_O = |IV07out //Module 1 
 
 //Module Permeate Valves 
 |IV08_O = |IV08out //Module 3
 |IV09_O = |IV09out //Module 1 
 |IV10_O = |IV10out //Module 2
  
 |IV17_O = |IV17out //Permeate Outlet Valve 
 |SV62_O = |SV62out //Retentate/Feedtank Outlet Valve
 |SV63_O = |SV63out //Feedtank Inlet Valve
 
 |PP01_O = |PP01out
 |PP02_O = |PP02out
 
  
END

//Called by the operating system when Prog button is pressed in edit mode
EDIT_MACRO:
 SELECT &STATE

  CASE ADDR(&PP01SP01):
   EXIT_EDIT &PP01SP01
   EDIT &PP01SP02
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP02
   WRITE ""
   WRITE "PP01SP02 (%)"
   &STATE=ADDR(&PP01SP02)
   
  CASE ADDR(&PP01SP02):
   EXIT_EDIT &PP01SP02
   EDIT &PP01SP03
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP03
   WRITE ""
   WRITE "PP01SP03 (%)"
   &STATE=ADDR(&PP01SP03)
   
  CASE ADDR(&PP01SP03):
   EXIT_EDIT &PP01SP03   
   EDIT &PP01SP11
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP11
   WRITE ""
   WRITE "PP01SP11 (%)"
   &STATE=ADDR(&PP01SP11)
   
  CASE ADDR(&PP01SP11):
   EXIT_EDIT &PP01SP11   
   EDIT &PP01SP12
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP12
   WRITE ""
   WRITE "PP01SP12 (%)"
   &STATE=ADDR(&PP01SP12)
   
  CASE ADDR(&PP01SP12):
   EXIT_EDIT &PP01SP12   
   EDIT &PP01SP21
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP21
   WRITE ""
   WRITE "PP01SP21 (%)"
   &STATE=ADDR(&PP01SP21)
   
  CASE ADDR(&PP01SP21):
   EXIT_EDIT &PP01SP21   
   EDIT &PP01SP22
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP22
   WRITE ""
   WRITE "PP01SP22 (%)"
   &STATE=ADDR(&PP01SP22)
   
  CASE ADDR(&PP01SP22):
   EXIT_EDIT &PP01SP22   
   EDIT &PP01SP31
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP31
   WRITE ""
   WRITE "PP01SP31 (%)"
   &STATE=ADDR(&PP01SP31)
   
  CASE ADDR(&PP01SP31):
   EXIT_EDIT &PP01SP31   
   EDIT &PP01SP32
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP32
   WRITE ""
   WRITE "PP01SP32 (%)"
   &STATE=ADDR(&PP01SP32)
   
  CASE ADDR(&PP01SP32):
   EXIT_EDIT &PP01SP32   
   EDIT &PP01SP41
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP41
   WRITE ""
   WRITE "PP01SP41 (%)"
   &STATE=ADDR(&PP01SP41)
   
  CASE ADDR(&PP01SP41):
   EXIT_EDIT &PP01SP41   
   EDIT &PP01SP42
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP42
   WRITE ""
   WRITE "PP01SP42 (%)"
   &STATE=ADDR(&PP01SP42)
   
  CASE ADDR(&PP01SP42):
   EXIT_EDIT &PP01SP42   
   EDIT &PP01SP51
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP51
   WRITE ""
   WRITE "PP01SP51 (%)"
   &STATE=ADDR(&PP01SP51)
   
  CASE ADDR(&PP01SP51):
   EXIT_EDIT &PP01SP51   
   EDIT &PP01SP52
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP52
   WRITE ""
   WRITE "PP01SP52 (%)"
   &STATE=ADDR(&PP01SP52)
   
  CASE ADDR(&PP01SP52):
   EXIT_EDIT &PP01SP52   
   EDIT &PP01SP61
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP61
   WRITE ""
   WRITE "PP01SP61 (%)"
   &STATE=ADDR(&PP01SP61)
   
  CASE ADDR(&PP01SP61):
   EXIT_EDIT &PP01SP61   
   EDIT &PP01SP62
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP01SP62
   WRITE ""
   WRITE "PP01SP62 (%)"
   &STATE=ADDR(&PP01SP62)
   
  CASE ADDR(&PP01SP62):
   EXIT_EDIT &PP01SP62   
       
  CASE ADDR(&PP02SP02):
   EXIT_EDIT &PP02SP02
   EDIT &PP02SP03
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP03
   WRITE ""
   WRITE "PP02SP03 (%)"
   &STATE=ADDR(&PP02SP03)
   
  CASE ADDR(&PP02SP03):
   EXIT_EDIT &PP02SP03   
   EDIT &PP02SP04
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP04
   WRITE ""
   WRITE "PP02SP04 (%)"
   &STATE=ADDR(&PP02SP04)
   
  CASE ADDR(&PP02SP04):
   EXIT_EDIT &PP02SP04
   EDIT &PP02SP05
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP05
   WRITE ""
   WRITE "PP02SP05 (%)"
   &STATE=ADDR(&PP02SP05)
   
  CASE ADDR(&PP02SP05):
   EXIT_EDIT &PP02SP05
   EDIT &PP02SP06
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP06
   WRITE ""
   WRITE "PP02SP06 (%)"
   &STATE=ADDR(&PP02SP06)
   
  CASE ADDR(&PP02SP06):
   EXIT_EDIT &PP02SP06
   EDIT &PP02SP07
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP07
   WRITE ""
   WRITE "PP02SP07 (%)"
   &STATE=ADDR(&PP02SP07)
   
  CASE ADDR(&PP02SP07):
   EXIT_EDIT &PP02SP07
   EDIT &PP02SP12
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP12
   WRITE ""
   WRITE "PP02SP12 (%)"
   &STATE=ADDR(&PP02SP12)
   
  CASE ADDR(&PP02SP12):
   EXIT_EDIT &PP02SP12
   EDIT &PP02SP13
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP13
   WRITE ""
   WRITE "PP02SP13 (%)"
   &STATE=ADDR(&PP02SP13)
   
  CASE ADDR(&PP02SP13):
   EXIT_EDIT &PP02SP13
   EDIT &PP02SP22
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP22
   WRITE ""
   WRITE "PP02SP22 (%)"
   &STATE=ADDR(&PP02SP22)
   
  CASE ADDR(&PP02SP22):
   EXIT_EDIT &PP02SP22
   EDIT &PP02SP23
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP23
   WRITE ""
   WRITE "PP02SP23 (%)"
   &STATE=ADDR(&PP02SP23)
   
  CASE ADDR(&PP02SP23):
   EXIT_EDIT &PP02SP23
   EDIT &PP02SP32
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP32
   WRITE ""
   WRITE "PP02SP32 (%)"
   &STATE=ADDR(&PP02SP32)
   
  CASE ADDR(&PP02SP32):
   EXIT_EDIT &PP02SP32
   EDIT &PP02SP33
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP33
   WRITE ""
   WRITE "PP02SP33 (%)"
   &STATE=ADDR(&PP02SP33)
   
  CASE ADDR(&PP02SP33):
   EXIT_EDIT &PP02SP33
   EDIT &PP02SP39
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP39
   WRITE ""
   WRITE "PP02SP39 (%)"
   &STATE=ADDR(&PP02SP39)
   
  CASE ADDR(&PP02SP39):
   EXIT_EDIT &PP02SP39
   EDIT &PP02SP42
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP42
   WRITE ""
   WRITE "PP02SP42 (%)"
   &STATE=ADDR(&PP02SP42)
   
  CASE ADDR(&PP02SP42):
   EXIT_EDIT &PP02SP42
   EDIT &PP02SP43
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP43
   WRITE ""
   WRITE "PP02SP43 (%)"
   &STATE=ADDR(&PP02SP43)
   
  CASE ADDR(&PP02SP43):
   EXIT_EDIT &PP02SP43
   EDIT &PP02SP52
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP52
   WRITE ""
   WRITE "PP02SP52 (%)"
   &STATE=ADDR(&PP02SP52)
   
  CASE ADDR(&PP02SP52):
   EXIT_EDIT &PP02SP52
   EDIT &PP02SP53
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP53
   WRITE ""
   WRITE "PP02SP53 (%)"
   &STATE=ADDR(&PP02SP53)
   
  CASE ADDR(&PP02SP53):
   EXIT_EDIT &PP02SP53
   EDIT &PP02SP62
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP62
   WRITE ""
   WRITE "PP02SP62 (%)"
   &STATE=ADDR(&PP02SP62)
   
  CASE ADDR(&PP02SP62):
   EXIT_EDIT &PP02SP62
   EDIT &PP02SP63
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP63
   WRITE ""
   WRITE "PP02SP63 (%)"
   &STATE=ADDR(&PP02SP63)
   
  CASE ADDR(&PP02SP63):
   EXIT_EDIT &PP02SP63
   EDIT &PP02SP69
   &EDIT_MAX=10000
   &EDIT_MIN=0
   &EDIT_DEF=&PP02SP69
   WRITE ""
   WRITE "PP02SP69 (%)"
   &STATE=ADDR(&PP02SP69)
   
  CASE ADDR(&PP02SP69):
   EXIT_EDIT &PP02SP69
 
  CASE ADDR(&LT01SP01):
   EXIT_EDIT &LT01SP01   
   EDIT &LT01SP02
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT01SP02
   WRITE ""
   WRITE "LT01SP02 (%)"
   &STATE=ADDR(&LT01SP02)
   
  CASE ADDR(&LT01SP02):
   EXIT_EDIT &LT01SP02
   EDIT &LT01SP03
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT01SP03
   WRITE ""
   WRITE "LT01SP03 (%)"
   &STATE=ADDR(&LT01SP03)
   
  CASE ADDR(&LT01SP03):
   EXIT_EDIT &LT01SP03
   EDIT &LT01SP04
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT01SP04
   WRITE ""
   WRITE "LT01SP04 (%)"
   &STATE=ADDR(&LT01SP04)
   
  CASE ADDR(&LT01SP04):
   EXIT_EDIT &LT01SP04
   EDIT &LT01SP05
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT01SP05
   WRITE ""
   WRITE "LT01SP05 (%)"
   &STATE=ADDR(&LT01SP05)
   
  CASE ADDR(&LT01SP05):
   EXIT_EDIT &LT01SP05
   EDIT &LT01SP06
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT01SP06
   WRITE ""
   WRITE "LT01SP06 (%)"
   &STATE=ADDR(&LT01SP06)
   
  CASE ADDR(&LT01SP06):
   EXIT_EDIT &LT01SP06
      
  CASE ADDR(&LT02SP01):
   EXIT_EDIT &LT02SP01   
   EDIT &LT02SP02
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT02SP02
   WRITE ""
   WRITE "LT02SP02 (%)"
   &STATE=ADDR(&LT02SP02)
   
  CASE ADDR(&LT02SP02):
   EXIT_EDIT &LT02SP02
   EDIT &LT02SP03
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT02SP03
   WRITE ""
   WRITE "LT02SP03 (%)"
   &STATE=ADDR(&LT02SP03)
   
  CASE ADDR(&LT02SP03):
   EXIT_EDIT &LT02SP03   
   EDIT &LT02SP04
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT02SP04
   WRITE ""
   WRITE "LT02SP04 (%)"
   &STATE=ADDR(&LT02SP04)
   
  CASE ADDR(&LT02SP04):
   EXIT_EDIT &LT02SP04
   EDIT &LT02SP05
   &EDIT_MAX=1000
   &EDIT_MIN=0
   &EDIT_DEF=&LT02SP05
   WRITE ""
   WRITE "LT02SP05 (%)"
   &STATE=ADDR(&LT02SP05)
   
  CASE ADDR(&LT02SP05):
   EXIT_EDIT &LT02SP05         
      
  CASE ADDR(&T0SP09):
   EXIT_EDIT &T0SP09
   EDIT &T0SP10
   &EDIT_MAX=32000
   &EDIT_MIN=0
   &EDIT_DEF=&T0SP10
   WRITE ""
   WRITE "T0SP10 (s)"
   &STATE=ADDR(&T0SP10)
   
//  CASE ADDR(&T0SP10):
//   EXIT_EDIT &T0SP10
//   EDIT &T0SP11
//   &EDIT_MAX=32000
//   &EDIT_MIN=0
//   &EDIT_DEF=&T0SP11
//   WRITE ""
//   WRITE "T0SP11 (s)"
//   &STATE=ADDR(&T0SP11)
   
  CASE ADDR(&T0SP11):
   EXIT_EDIT &T0SP11
   EDIT &T0SP12
   &EDIT_MAX=32000
   &EDIT_MIN=0
   &EDIT_DEF=&T0SP12
   WRITE ""
   WRITE "T0SP12 (s)"
   &STATE=ADDR(&T0SP12)
   
//  CASE ADDR(&T0SP12):
//   EXIT_EDIT &T0SP12
//   EDIT &T0SP13
//   &EDIT_MAX=32000
//   &EDIT_MIN=0
//   &EDIT_DEF=&T0SP13
//   WRITE ""
//   WRITE "T0SP13 (s)"
//   &STATE=ADDR(&T0SP13)   
   
  CASE ADDR(&T0SP13):
   EXIT_EDIT &T0SP13
   EDIT &T0SP14
   &EDIT_MAX=32000
   &EDIT_MIN=0
   &EDIT_DEF=&T0SP14
   WRITE ""
   WRITE "T0SP14 (s)"
   &STATE=ADDR(&T0SP14)   
      
//  CASE ADDR(&T0SP14):
//   EXIT_EDIT &T0SP14
//   EDIT &T0SP18
//   &EDIT_MAX=32000
//   &EDIT_MIN=0
//   &EDIT_DEF=&T0SP18
//   WRITE ""
//   WRITE "T0SP18 (s)"
//   &STATE=ADDR(&T0SP18)   
      
  CASE ADDR(&T0SP18):
   EXIT_EDIT &T0SP18
         
//  CASE ADDR(&T1SP13):
//   EXIT_EDIT &T1SP13
//   EDIT &T1SP33
//   &EDIT_MAX=32000
//   &EDIT_MIN=0
//   &EDIT_DEF=&T1SP33
//   WRITE ""
//   WRITE "T1SP33 (s)"
//   &STATE=ADDR(&T1SP33)   
      
  CASE ADDR(&T1SP33):
   EXIT_EDIT &T1SP33
  
  CASE ADDR(&T2SP13):
   EXIT_EDIT &T2SP13
   EDIT &T2SP33
   &EDIT_MAX=32000
   &EDIT_MIN=0
   &EDIT_DEF=&T2SP33
   WRITE ""
   WRITE "T2SP33 (s)"
   &STATE=ADDR(&T2SP33)   
      
  CASE ADDR(&T2SP33):
   EXIT_EDIT &T2SP33 

  CASE ADDR(&T1SP13):
   EXIT_EDIT &T1SP13 

  CASE ADDR(&T0SP10):
   EXIT_EDIT &T0SP10 

  CASE ADDR(&T0SP12):
   EXIT_EDIT &T0SP12 

  CASE ADDR(&T0SP14):
   EXIT_EDIT &T0SP14 

  //DEFAULT:
  // &STATE = 0
 ENDSEL
 
END

// As at 2017-06-29 the capture pin wasn't working, thus this macro isn't being
// called, which means that FT01count isn't updating, and so FT01 is locked at
// zero.
CAPTURE_MACRO:
 &FT01count  = &FT01count + 1 
END
