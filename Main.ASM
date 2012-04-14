.686P
.MMX
.model flat, stdcall

include Inc/Main.inc

.data
	message		db	"Hi", 0
	caption		db 	"Imma program", 0
	
	; === Global (v) === ;
	v_retAddr	dd	0
	
	; === Perceptron === ;
	v_N			EQU	10				; neurons amount
	v_dtSize	EQU	10				; sizeof(dt)
	v_NDT		EQU	v_N * v_dtSize
	v_PLimit	EQU	500				; pictures amount / 2
	v_W			EQU	6
	v_H			EQU	12
	v_WH		EQU	v_W * v_H
	v_WHF		EQU	v_W * v_H * v_dtSize
	ALIGN 16
	v_We		db	v_W * v_H * v_dtSize * v_N dup(0)
	ALIGN 16
	v_X			db	v_W * v_H * v_dtSize dup(0)
	ALIGN 16
	v_Probs		db	v_dtSize * v_N dup(0)
	ALIGN 16
	v_Etalon	db	v_dtSize * v_N dup(0)
	v_tmpDD		dd	0
	v_D			dt	0.0
	v_Eps		dt	0.001
	
	; === SimpleParser === ;
	v_ERROR		db	0
	v_newAddr	dd	0
	v_tenConst	dd	10
	v_Number	dw	0
	v_tmp		db "32 64", 13, 0
	
	; === Random === ;
	v_seed		dd	0

.code
start:
	call Randomize

	; === Get Command Line Params === ;		in: <none>		out: eax = addr to string
	call GetCommandLineA
	mov ecx, 512d
	add ecx, eax
v_space:
	inc eax
	cmp eax, ecx
	jz v_FATAL
	cmp byte ptr[eax], ' '
	jnz v_space
v_argSearch:
	inc eax
	cmp byte ptr[eax], 0
	jz v_FATAL
	cmp byte ptr[eax], 20h
	jz v_argSearch
	; === End === ;
	
	; TODO: proper command line parser ;
	
	; === Set v_W and v_H === ;			in: eax = addr of string		out: v_W = width, v_H = height
	;push dword ptr offset v_tmp		; DEBUG
	;call SimpleParser
	;
	;mov ax, [v_Number]
	;mov [v_H], ax
	;
	;push dword ptr [v_newAddr]
	;call SimpleParser
	;
	;mov ax, [v_Number]
	;mov [v_W], ax
	; === End === ;

	call Recognize
	invoke MessageBoxA, 0, addr message, addr caption, MB_OK
	jmp v_EXIT

v_FATAL:
	mov [v_ERROR], 1
	jmp v_EXIT
v_EXIT:
	invoke ExitProcess, 0
End start