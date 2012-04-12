.586P
.MMX
.model flat, stdcall

include Main.inc

.data
	message		db	"Hi", 0
	caption		db 	"Imma program", 0
	
	; === Perceptron === ;
	v_W			dw	0
	v_H			dw	0
	v_PLimit	equ	500
	v_We		dt	32*64*10 dup(0)
	v_tmpDD		dd	0
	
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
	mov eax, offset v_tmp		; DEBUG
	call SimpleParser
	mov ax, [v_Number]
	mov [v_H], ax
	mov eax, [v_newAddr]
	call SimpleParser
	mov ax, [v_Number]
	mov [v_W], ax
	; === End === ;

	invoke MessageBoxA, 0, addr message, addr caption, MB_OK
	jmp v_EXIT

v_FATAL:
	mov [v_ERROR], 1
	jmp v_EXIT
v_EXIT:
	invoke ExitProcess, 0
End start