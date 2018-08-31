;Calculate with full precise X^2-2Y+W^(1/2), where 0<=X<=15, Ysigned 8bit integer and 0<=W<=100.
;X^2 is calculated from a Look up table(LUT) saved in SRAM.
;The square root is calculated from a LUT saved in program memory. Every byte is in 4bit int- 4bit fract format.

.include "m16def.inc"
.def x1 = r16 
.def y1 = r17 
.def w = r18 
.def temp = r19
.def resD = r15 
.def resL = r14 
.def resH = r13 
.def tempL = r12 
.def tempH = r11

.dseg
	x_cube: .byte 16 ;=0,1,4,9,16,25,36,49,64,81,100,121,144,169,196,225

.cseg
.org 0x00
rjmp main
	w_sqr: .db 0x00,0x10,0x16,... ;for w= 0,1,2,3,... 

main:
clr temp
clr tempH
clr tempL
clr resD
clr resH
clr resL

;i set random values in x,y,w
ldi x1, 10
ldi y1, -5
ldi w, 45

x:
ldi xl, low(x_cube)
ldi xh, high(x_cube)
add xl, x1
adc xh, temp ;which is zero
ld resL, x

y:
mov tempL, y1
lsl tempL
brcc y_not_negative
com tempH
y_not_negative:
sub resL, tempL
sbc resH, tempH

w:
clr tempL
clr tempH
clr temp
ldi zl, low(w_sqr<<1)
ldi zh, high(w_sqr<<1)
add zl, w
adc zh,temp	 
lpm tempL, z 	

ldi temp, 4 	
loop:
lsl tempL
rol tempH
dec temp2
brne loop
add resD, tempL
adc resL, tempH
adc resH, temp

end
rjmp end

;result if resH:resL:resD






