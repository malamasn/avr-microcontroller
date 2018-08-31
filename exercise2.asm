;Calculate 8X -3Y/8 + 25.15625, where X,Y are 10bit integers without using mul

.def xhd = r16
.def xmd = r17
.def xmf = r26
.def temp = r18
.def yhd = r19
.def ymd = r20
.def ymf = r21
.def numD = r22
.def numF = r23
.def yh = r24
.def yl = r25

clr temp
ldi numF = 0b00101000 ;0.15625
ldi numD = 0b00011001 ;25

;8x
lsl xmd
rol xhd
lsl xmd
rol xhd
lsl xmd
rol xhd
;3y
mov yh,yhd
mov yl,ymd
lsl ymd ;multiply by 2
rol yhd
add ymd,yl ;add y
adc yhd,yh
;3y/8
lsr yhd
ror ymd
ror ymf
lsr yhd
ror ymd
ror ymf
lsr yhd
ror ymd
ror ymf
;8x- 3y/8
sub xmf,ymf
subc xmd, ymd
subc xhd, yhd
;+25.15625
add xmf,numF
adc xmd,numD
adc xhd,temp	 ;is zero, but we add the carry this way

end: 		;result saved as tempxhd:tempxmd:tempxmf
rjmp end