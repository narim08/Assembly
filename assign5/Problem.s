CR EQU 0x0D
 
 AREA ARMex, CODE, READONLY
	 ENTRY
Main
	MOV r4, #1
	STRB r4, K
	LDR r0, =Arr1 ;data
	LDR r3, =Arr2 ;result
	MOV r4, #0 ;count index
	BL copy_arr_wo_space
	
	STRB r4, K
	SWI &11 ;finish
	
copy_arr_wo_space
	LDRB r2,[r0],#1
	
	CMP r2,#CR ;end arr
	BEQ sizeArr
	
	CMP r2, #0x00000020 ;if space, continue
	BEQ copy_arr_wo_space
	
	STRB r2,[r3,r4] ;put the value
	ADD r4, r4, #1
	
	B copy_arr_wo_space

sizeArr
	BX lr

;Data area
 AREA dataArray, DATA
K
	DCB 0
Arr1
	DCB "Hello, World",CR
	ALIGN
Arr2
	DCB 0
	
	END