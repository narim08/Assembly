	AREA ARMex, CODE, READONLY
	 ENTRY
start
	MOV r0, #0 ;sum(3x17)
	MOV r1, #3
	MOV r2, #17

	MUL r0, r1, r2 ;3x17

	LDR r8, TEMPADDR1
	STR r0, [r8]
	
TEMPADDR1 & &40000

	MOV pc, lr
	END
