;Calculate with full precise the multiplication of two BCD numbers with 3 digits each


.include "m16def.inc"
.def temp=r16 
.def l1=r17 
.def m1=r18 
.def h1=r19 
.def l2=r20 
.def m2=r21 
.def h2=r22
.def lsb1=r23 
.def msb1=r24 
.def lsb2=r25 
.def msb2=r26 
.def a=r27 
.def b=r28 
.def c=r29
.def d=r30 
.def e=r31


;i set random values
ldi h1,4
ldi m1,4
ldi l1,2
ldi h2,1
ldi m2,7
ldi l2,5


;convert bcd1 to binary number
clr msb1
mov lsb1,l1
ldi temp,10
mul m1,temp
add lsb1,r0
adc msb1,r1
ldi temp,100
mul h1,temp
add lsb1,R0
adc msb1,r1

;convert bcd2 to binary number
clr msb1
mov lsb2,l1
ldi temp,10
mul m1,temp
add lsb2,r0
adc msb2,r1
ldi temp,100
mul h1,temp
add lsb2,R0
adc msb2,r1

;last is a mul between 16bit numbers
mul lsb2,lsb1
mov a,r0
mov b,r1
mul msb2,lsb1
add b,r0
adc c,r1
mul msb1,lsb2
mov d,r0
mov e,r1
mul msb1,msb2
add e,r0
add b,d
adc c,e

;result is cba


