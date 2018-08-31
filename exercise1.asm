;Calculate with full precise X^2+Y/4, where X:signed 8bit, 4bit integer part and 4bit fract part
;and Y:14bit with 5bit int part and 9bit fract part. You can use mul commands only for X^2.

.include "m16def.inc"
.def yl=r16
.def yh=r17
.def x=r18
.def resl=r19
.def resh=r20
.def resd=r21

;i set random values
ldi x,55
ldi yl,0b11101000
ldi yh,0b10010101
clr resd
clr resl
clr resh
;X^2
muls xx,xx 		;Multiply xx with xx. Result saved in R1:R0
add resd,r0
adc resl,r1
clr xx ;Clears xx
adc resh,xx

tst yh 		;Test if yh Zero or Negative
brpl ok		;branch if Positive (N=0)
ser x 		;Loads $FF directly to xx

ok:
lsl yl		;Shift Left (yl(n+1)=yl(n), yl(0) = 0, C = yl(7))
rol yh		;Shifts all bits in Rd one place to the left and the C into bit 0 of Rd.
rol x		;we do 3 times this in order to split the int and the fract part of Y
		;Y/4 needs to shifts to the rigth, and then the 5 int digits need to be shifted
lsl yl		;into x, that means 5 shifts to the left, so in total 3 shifts to the left.
rol yh
rol x

lsl yl
rol yh
rol x

add resd,yl 	;add without carry for the decimal
adc resl,yh 	;Add with carry for the low byte
adc resh,x 	;Add with carry for the high byte

end:
rjmp end
;result as resh:resl:resd