	AREA ARMex, CODE, READONLY
	 ENTRY
start
	MOV r0, #2 ;2!
	MOV r1, #0 ;sum

	MOV r2, #3
	MUL r1, r0, r2 ;3!
	
	MOV r0, r1 ;r0=sum
	MOV r2, #4
	MUL r0, r1, r2 ;4!
	
	MOV r2, #5
	MUL r1, r0, r2 ;r1=sum=5!
	
	MOV r2, #6
	MUL r0, r1, r2 ;r0=sum=6!
	
	MOV r2, #7
	MUL r1, r0, r2 ;r1=sum=7!
	
	MOV r2, #8
	MUL r0, r1, r2 ;r0=sum=8!
	
	MOV r2, #9
	MUL r1, r0, r2 ;r1=sum=9!
	
	MOV r2, #10
	MUL r0, r1, r2 ;r0=sum=10!

	LDR r8, TEMPADDR1
	STR r0, [r8]

TEMPADDR1 & &40000

	MOV pc, lr
	END
