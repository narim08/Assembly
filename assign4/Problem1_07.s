	AREA ARMex, CODE, READONLY
	 ENTRY
start
	MOV r0, #1 ;start, 1!
	MOV r0, r0, LSL #1 ;2!
	
	MOV r0, r0, LSL #1 ;2x2
	ADD r0, r0, #2 ;3!
	
	MOV r0, r0, LSL #2 ;2x3x4 =4!
	
	MOV r0, r0, LSL #2 ;2x3x4x4
	ADD r0, r0, #24 ;5!
	
	MOV r0, r0, LSL #2 ;2x3x4x5x4
	ADD r0, r0, #240 ;6!
	
	MOV r1, r0 ;r1=720
	MOV r0, r0, LSL #2 ;2x3x4x5x6x4
	MOV r2, r1, LSL #1 ;r2=720x2
	ADD r2, r2, r1 ;r2=720x3
	ADD r0, r0, r2 ;r0=7!
	
	MOV r0, r0, LSL #3 ;8!
	MOV r1, r0 ;r1=8!
	
	MOV r0, r0, LSL #3 ;8!x8
	ADD r0, r0, r1 ;9!
	
	MOV r1, r0  ;r1=9!
	MOV r1, r1, LSL #1 ;9!x2
	MOV r0, r0, LSL #3 ;9!x8
	ADD r0, r0, r1 ;10!
	
	LDR r8, TEMPADDR1
	STR r0, [r8]

TEMPADDR1 & &40000

	MOV pc, lr
	END
