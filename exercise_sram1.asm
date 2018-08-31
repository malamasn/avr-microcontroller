;Count the numbers that are saved in SRAM that are even and in the space (11, 200).
;All numbers are positive integers of 8bits. In the first position of the SRAM is the number of numbers we
;have to check.

.def sizel=r16
.def sizeh=r17
.def countl=r18 
.def counth=r19 
.def a=r20
.def temp=r21

.org 0
reset:
ldi zl,0x60 
clr zh
ld countl,z+   
ldi counth,z+
clr sizel
clr sizeh
rjmp main

main:
subi countl,1 	;countl--
sbci counth,0 	;counth-- with Carry
ld a,Z+ 	;Load Z to a and make Z = Z + 1
mov temp,a
lsr temp 	;Shift right (Temp(n) = Temp(n+1),Temp(7) = 0, C = Temp (0))
brcs no 	;if C=1 means it is odd
cpi a,200
brsh no 	;if a >= 200
cpi a,12
brlo no 	;if a < 12

yes:
ldi temp,1
add sizel,temp 	;sizel++
ldi temp,0
adc sizeh,temp 	;sizeh++

no:
tst counth 	;test if counth <=0
brne next
tst countl 	;test if countl <=0
brne next

end:
rjmp end