include Inc/Perceptron.inc
include windows.inc

.code

; === Constructor === ;		in: <none>		out: <none>
Perceptron proc
	pushad
	
	mov ebx, v_W
	mov ecx, v_H
	imul ecx, ebx
	mov ebx, v_dtSize
	imul ecx, ebx
	mov ebx, v_N
	imul ecx, ebx
	sub ecx, v_dtSize
	finit
	
	v_fillRandP:
		push dword ptr 10		; range
		invoke Random
		inc eax
		mov [v_tmpDD], eax
		fild [v_tmpDD]
		fstp tbyte ptr v_We[ecx]
		sub ecx, v_dtSize
		cmp ecx, 0
	jge v_fillRandP
	
	popad
	ret
Perceptron endp
