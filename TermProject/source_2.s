	AREA code_area, CODE, READONLY
		ENTRY

float_number_series EQU 0x0450
sorted_number_series EQU 0x00018AEC
final_result_series EQU 0x00031190

;========== Do not change this area ===========

initialization
	LDR r0, =0xDEADBEEF				; seed for random number
	LDR r1, =float_number_series	
	LDR r2, =10000   				; The number of element in stored sereis
	LDR r3, =0x0EACBA90				; constant for random number

save_float_series
	CMP r2, #0
	BEQ is_init
	BL random_float_number
	STR r0, [r1], #4
	SUB r2, r2, #1
	MOV r5, #0
	B save_float_series

random_float_number
	MOV r5, LR
	EOR r0, r0, r3
	EOR r3, r0, r3, ROR #2
	CMP r0, r1
	BLGE shift_left
	BLLT shift_right
	BX r5

shift_left
	LSL r0, r0, #1
	BX LR

shift_right
	LSR r0, r0, #1
	BX LR
	
;============================================

;========== Start your code here ===========
	
is_init
	LDR r1, =float_number_series
	LDR r3, =final_result_series
	LDR r2, =10000
	MOV r4, #1 ;i=1
	MOV r0, #0 ;result index
	
for_1 ;out loop
	CMP r4, r2 ;i<arr size
	BGE end_for_1
	
	LDR r6, [r1, r4, LSL #2] ;key=arr[i]
	MOV r5, r4 ;j=i-1
	SUB r5, r5, #1

for_2 ;in loop
	CMP r5, #0 ;j>=0
	BLT end_for_2
	
	LDR r7, [r1, r5, LSL #2] ;arr[j]
	CMP r7, r6 ;arr[j] > key
	BLE end_for_2
	
	ADD r8, r5, #1 ;j+1 temp
	STR r7, [r1, r8, LSL #2] ;arr[j+1]=arr[j]
	SUB r5, r5, #1 ;j--
	B for_2
	
	
end_for_2
	ADD r8, r5, #1 ;j+1 temp
	STR r6, [r1, r8, LSL #2] ;arr[j+1]=key
	ADD r4, r4, #1 ;i++
	B for_1

end_for_1 ;sort end
	LDR r9, [r1, r0, LSL #2]
	STR r9, [r3, r0, LSL #2] ;store result
	ADD r0, r0, #1
	
	CMP r0, r2
	BNE end_for_1

exit
	mov pc, #0 ;Program end
	END

;========== End your code here ===========