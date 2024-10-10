	AREA code_area, CODE, READONLY
		ENTRY

float_number_series EQU 0x0450
sorted_number_series EQU 0x00018AEC
final_result_series EQU 0x00031190

;========== Do not change this area ===========

initialization
	LDR r0, =0xDEADBEEF				; seed for random number
	LDR r1, =float_number_series	
	LDR r2, =10000  				; The number of element in stored sereis
	LDR r3, =0x0EACBA90				; constant for random number

save_float_series
	CMP r2, #0
	BEQ ms_init
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
	
ms_init
	LDR r0, =float_number_series
    LDR r1, =sorted_number_series
    LDR r2, =10000 ;The number of element in stored sereis
	
	MOV r4,#0 ;first
	MOV r6,r2 ;last
	SUB r6,r6,#1 
	
	B merge_sort ;merge_sort(arr, 0, arr_size-1)
	
	
merge_sort ;merge_sort(arr, first, last)
	PUSH {r4,r5,r6,lr} ;first, mid, last, lr
	CMP r4,r6 ;first < last
	BGE ms_end
	
	;mid
	ADD r5,r4,r6 ;first + last
	LSR r5,r5,#1 ;mid = (first + last) / 2
	
	MOV r3, r6 ;last save
	
	;merge_sort(arr, first, mid)
	MOV r6, r5
	BL merge_sort
	
	MOV r7, r4 ;first save
	
	;merge_sort(arr, mid+1, last)
	MOV r6, r3
	ADD r4,r5,#1
	BL merge_sort
	
	;merge(arr, first, mid, last)
	MOV r4, r7 ;first

	MOV r6, r3 ;last
	BL merge
	

ms_end
	POP{r4,r5,r6,lr}
	BX lr

;=============================
merge ;merge(arr, first, mid, last)
    MOV r1, r4 ;i=first, first array index
    MOV r2, r5 ;j=mid+1, second array index
	ADD r5, r5, #1
    MOV r3, #0 ;k=0, sorted array index
    LDR r9, =sorted_number_series

;==============

cmp_1
    CMP r1, r5 ;i <= mid
    BGT while_1_end

cmp_2
    CMP r2, r6 ;j <= last
    BGT while_1_end

while_1
    LDR r7, [r0, r1, LSL #2] ;arr[i]
    LDR r8, [r0, r2, LSL #2] ;arr[j]
    CMP r7, r8 ;arr[i] <= arr[j]
	BLE sort_Arr_LE
	BGT sort_Arr_GT

sort_Arr_LE
    STR r7, [r9, r3, LSL #2] ;sorted[k]=arr[i]
    ADD r1, r1, #1 ;i++
    ADD r3, r3, #1 ;k++
    B cmp_1

sort_Arr_GT
    STR r8, [r9, r3, LSL #2] ;sorted[k]=arr[j]
    ADD r2, r2, #1 ;j++
    ADD r3, r3, #1 ;k++
    B cmp_1

;==============

while_1_end
    CMP r1, r5 ;i>mid
	BGT cmp_if
	BLE cmp_else
	
cmp_if
	CMP r2, r6 ;j<=last
	BLE sort_Arr_LE_j
	BGT result_Arr
	
cmp_else
	CMP r1, r5 ;i<=mid
	BLE sort_Arr_LE_i
	BGT result_Arr


sort_Arr_LE_i
    STR r7, [r9, r3, LSL #2] ;sorted[k]=arr[i]
    ADD r1, r1, #1 ;i++
    ADD r3, r3, #1 ;k++
    B cmp_else

sort_Arr_LE_j
    STR r8, [r9, r3, LSL #2] ;sorted[k]=arr[j]
    ADD r2, r2, #1 ;j++
    ADD r3, r3, #1 ;k++
    B cmp_if

;==============

result_Arr
    MOV r1, r4 ;i=first
    MOV r3, #0 ;k=0
    LDR r10, =final_result_series
    B cmp_for

cmp_for
	CMP r1, r6 ;i<=last
	BLE for_result_Arr
	BGT exit ;end merge sort
	
for_result_Arr
	LDR r11, [r9, r3, LSL #2] ;sorted[k]
	STR r11, [r10, r1, LSL #2] ;result[i]=sorted[k]
	ADD r3, r3, #1 ;k++
	ADD r1, r1, #1 ;i++
	B cmp_for
	
;=============================

exit
	MOV PC, #0 ;Program end
	END

;========== End your code here ===========