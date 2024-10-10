	AREA ARMex, CODE, READONLY
	 ENTRY
start
	LDR r1, Val_m1
	LDR r2, Val_m2
	
	;val_1 Sign bit
	LDR r3, [r1]
	LSR r3, r3, #31
	
	;val_1 Exponent bits
	LDR r4, [r1]
	LSR r4, r4, #23
	AND r4, r4, #0xFF ;8bit
	
	;val_1 Fraction Bits
	LDR r5, [r1]
	LSL r5, r5, #9
	LSR r5, r5, #25
	ADD r5, r5, #0x80
	
	;val_2 Sign bit
	LDR r6, [r2]
	LSR r6, r6, #31
	
	;val_2 Exponent bits
	LDR r7, [r2]
	LSR r7, r7, #23
	AND r7, r7, #0xFF ;8bit
	
	;val_2 Fraction Bits
	LDR r8, [r2]
	LSL r8, r8, #9
	LSR r8, r8, #25
	ADD r8, r8, #0x80
	
	;Compare Exponent
	CMP r4, r7
	BLT ManSub1 ;r4 < r7
	BGT ManSub2 ;r7 < r4
	MOVEQ r9, #0 ;r4 = r7
	
ManSub1 
	SUB r9, r7, r4
	LSR r5, r5, r9
	B Normalize
	
ManSub2
	SUB r9, r4, r7
	LSR r8, r5, r9
	B Normalize
	
Normalize
	LSL r1, r1, #31 ;Sign
	ADD r9, r9, #127 ;Exponent
	LSL r9, r9, #23
	ADD r10, r5, r8 ;mantissa addition
	LSL r10, r10, #15
	ADD r11, r9, r10

	LDR r12, TEMPADDR1
	STR r11, [r12]
	B EndPro

Val_m1 DCD Val1
Val1 DCI 0x3FC00000

Val_m2 DCD Val2
Val2 DCI 0x40500000

TEMPADDR1 & &40000

EndPro ;End program
	END
