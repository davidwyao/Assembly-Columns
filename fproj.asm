%include "simple_io.inc"

global asm_main
extern rperm

section .data
	array: dq 1,2,3,4,5,6,7,8
	prompt1: db "enter i,j to swap",10,0
	prompt2: db "0 to terminate: ",0
	a1: db "first coordinate not 1..8",10,0
	a2: db "comma not there",10,0
	a3: db "second coordinate not 1..8",10,0
	blank: 		db "          ",0
	twotop: 	db "     ++   ",0
	threetop: 	db "    +-+   ",0
	fourtop: 	db "    +--+  ",0
	fivetop: 	db "   +---+  ",0
	sixtop: 	db "   +----+ ",0
	seventop: 	db "  +-----+ ",0
	eighttop: 	db "  +------+",0
	threewall: 	db "    + +   ",0
	fourwall: 	db "    +  +  ",0
	fivewall: 	db "   +   +  ",0
	sixwall: 	db "   +    + ",0
	sevenwall: 	db "  +     + ",0
	eightwall: 	db "  +      +",0
	onebase: 	db ".....+....",0
	twobase: 	db ".....++...",0
	threebase: 	db "....+-+...",0
	fourbase:	db "....+--+..",0
	fivebase:	db "...+---+..",0
	sixbase:	db "...+----+.",0
	sevenbase:	db "..+-----+.",0
	eightbase:	db "..+------+",0
	space5:		db "     ",0
	space9:		db "         ",0
	
section .bss
	
section .text

display:
	
	enter 0,0
	saveregs
	
	mov rcx, qword 8 ;; loop counter
	mov rbx, qword 1 ;; which digit
	
display_start:
	cmp rcx, 0
	jle displaynumbers
	
digitone:
	mov rax, [rdi]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digittwo:
	inc rbx
	mov rax, [array+8]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digitthree:
	inc rbx
	mov rax, [array+16]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digitfour:
	inc rbx
	mov rax, [array+24]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digitfive:
	inc rbx
	mov rax, [array+32]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digitsix:
	inc rbx
	mov rax, [array+40]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digitseven:
	inc rbx
	mov rax, [array+48]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank
	
digiteight:
	inc rbx
	mov rax, [array+56]
	cmp rax, rcx
	je display_top
	cmp rcx, 1
	je display_base
	cmp rax, rcx
	ja display_wall
	jmp display_blank

next_digit:
	cmp rbx, 1
	je digittwo
	cmp rbx, 2
	je digitthree
	cmp rbx, 3
	je digitfour
	cmp rbx, 4
	je digitfive
	cmp rbx, 5
	je digitsix
	cmp rbx, 6
	je digitseven
	cmp rbx, 7
	je digiteight
	
	jmp next_loop

next_loop:
	call print_nl
	mov rbx, qword 1
	dec rcx
	jmp display_start

	
display_blank:
	mov rax, blank
	call print_string
	jmp next_digit

display_top:
	check_one:
		cmp rax, 1
		jne check_two
		mov rax, onebase
		call print_string
		jmp next_digit
	check_two:
		cmp rax, 2
		jne check_three
		mov rax, twotop
		call print_string
		jmp next_digit
	check_three:
		cmp rax, 3
		jne check_four
		mov rax, threetop
		call print_string
		jmp next_digit
	check_four:
		cmp rax, 4
		jne check_five
		mov rax, fourtop
		call print_string
		jmp next_digit
	check_five:
		cmp rax, 5
		jne check_six
		mov rax, fivetop
		call print_string
		jmp next_digit
	check_six:
		cmp rax, 6
		jne check_seven
		mov rax, sixtop
		call print_string
		jmp next_digit
	check_seven:
		cmp rax, 7
		jne check_eight
		mov rax, seventop
		call print_string
		jmp next_digit
	check_eight:
		mov rax, eighttop
		call print_string
		jmp next_digit
	
display_wall:
	wcheck_one:
		cmp rax, 1
		jne wcheck_two
		mov rax, blank
		call print_string
		jmp next_digit
	wcheck_two:
		cmp rax, 2
		jne wcheck_three
		mov rax, blank
		call print_string
		jmp next_digit
	wcheck_three:
		cmp rax, 3
		jne wcheck_four
		mov rax, threewall
		call print_string
		jmp next_digit
	wcheck_four:
		cmp rax, 4
		jne wcheck_five
		mov rax, fourwall
		call print_string
		jmp next_digit
	wcheck_five:
		cmp rax, 5
		jne wcheck_six
		mov rax, fivewall
		call print_string
		jmp next_digit
	wcheck_six:
		cmp rax, 6
		jne wcheck_seven
		mov rax, sixwall
		call print_string
		jmp next_digit
	wcheck_seven:
		cmp rax, 7
		jne wcheck_eight
		mov rax, sevenwall
		call print_string
		jmp next_digit
	wcheck_eight:
		mov rax, eightwall
		call print_string
		jmp next_digit
	
display_base:
	bcheck_one:
		cmp rax, 1
		jne bcheck_two
		mov rax, onebase
		call print_string
		jmp next_digit
	bcheck_two:
		cmp rax, 2
		jne bcheck_three
		mov rax, twobase
		call print_string
		jmp next_digit
	bcheck_three:
		cmp rax, 3
		jne bcheck_four
		mov rax, threebase
		call print_string
		jmp next_digit
	bcheck_four:
		cmp rax, 4
		jne bcheck_five
		mov rax, fourbase
		call print_string
		jmp next_digit
	bcheck_five:
		cmp rax, 5
		jne bcheck_six
		mov rax, fivebase
		call print_string
		jmp next_digit
	bcheck_six:
		cmp rax, 6
		jne bcheck_seven
		mov rax, sixbase
		call print_string
		jmp next_digit
	bcheck_seven:
		cmp rax, 7
		jne bcheck_eight
		mov rax, sevenbase
		call print_string
		jmp next_digit
	bcheck_eight:
		mov rax, eightbase
		call print_string
		jmp next_digit
	
displaynumbers:
	mov rax, space5
	call print_string
	mov rax,[array]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+8]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+16]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+24]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+32]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+40]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+48]
	call print_int 
	mov rax, space9
	call print_string
	mov rax, [array+56]
	call print_int 
	call print_nl
	
	jmp display_end

display_end:
	restoregs
	leave
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
asm_main:	
	enter	0,0
	saveregs
	mov	rdi, array     ;1st param for rperm
	mov	rsi, qword 8   ;2nd param for rperm
	
	call rperm
	
	;; now the array 'array' is randomly initialzed
	push rdi
	call display
	add rsp, qword 8
	
	jmp prompt
	
	jmp asm_main_end
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prompt:
	mov rax, prompt1
	call  print_string
	mov rax, prompt2
	call print_string
	
	jmp read
read:
	call read_char
	cmp al, '0'
	je asm_main_end
	cmp al, '1'
	jb error1
	cmp al, '8'
	ja error1
	
	mov r12, 0
	mov r12b, al
	sub r12b, '0'
	
	call read_char
	cmp al, ','
	jne error2
	call read_char
	cmp al, '1'
	jb error3
	cmp al, '8'
	ja error3
	mov r13, 0
	mov r13b, al
	sub r13b, '0'
	
	mov r14, array
	
	jmp LOOP1
	
LOOP1:
	cmp [r14], r12
	je  LOOP2
	add r14, 8
	
	jmp LOOP1
	
LOOP2:
	mov r15, array
	
	jmp LOOP3
	
LOOP3:
	cmp [r15], r13
	je LOOP4
	add r15, 8
	jmp LOOP3
LOOP4:
	mov [r14], r13
	mov [r15], r12
	
	call display 
	jmp cleanBuffer
	
error1:
	call print_nl 
	mov rax, a1  
	call print_string 
	jmp cleanBuffer
	
error2:
	call print_nl
	mov rax, a2
	call print_string
	jmp cleanBuffer
	
error3:
	call print_nl
	mov rax, a3
	call print_string
	jmp cleanBuffer

cleanBuffer:
	call read_char
	cmp al, 10
	je prompt
	jmp cleanBuffer
	
asm_main_end:
	restoregs
	leave 
	ret
