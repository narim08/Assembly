	AREA ARMex, CODE, READONLY
	 ENTRY
start
	MOV r0, #0 ;sum(17x3)
	MOV r1, #17
	MOV r2, #3

	MUL r0, r1, r2 ;17x3

	LDR r8, TEMPADDR1
	STR r0, [r8]

TEMPADDR1 & &40000

	MOV pc, lr
	END
