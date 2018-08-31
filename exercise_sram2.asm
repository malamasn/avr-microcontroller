;An ASCII text is saved in SRAM in N bytes. The first two bytes contain number N.
;We have to count the words that have more than 5 alphanumeric characters.
;The only non alphanumeric characters that exist in the text are commas, full stops and spaces.

.def numL=r16
.def numH=r17
.def char=r18
.def tempH=r20
.def tempL=r19
.def counterL=r20
.def counterH=r21


.org 0
reset:
clr tempH
clr tempL
clr counterL
clr counterH
ldi ZL,0x60 
ldi ZH,0
ld numL,Z+ 
ld numH,Z+
rjmp main

main:

ld char,Z+ 
cpi char,0x2C 	;Check if it is a comma 0x2C
breq no_alphanumeric
cpi char,0x2E ;Check if it is a full stop 0x2E
breq no_alphanumeric
cpi char,0x20 	;Check if it is a space 0x20
breq no_alphanumeric
adiw tempH:tempL,1 	;else increment counter
rjmp main

No_alphanumeric:	 ;Check if number of chars in the word >5
cpitempL,0x05 		;Compare low byte
cpctempH,0x00 		;Compare high byte
brge increase_counter

Next:
clr tempH 	;Clear counter
clr tempL
sbiw numH:numL,1
brne loop 	
rjmp end

increase_counter:
adiw counterL:counterH,1 	;Increase counter
rjmp next

end:
rjmp end




