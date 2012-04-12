include Random.inc
include windows.inc

.code

; === Constructor === ;		in: <none>		out: <none>
Perceptron proc
	pushad
	mov ebx, 32		;[v_W]
	mov ecx, 64		;[v_H]
	imul ecx, ebx
	mov ebx, 10
	imul ecx, ebx
	sub ecx, 10
	
	v_fillRand:
		mov eax, 10		; sizeof(dt)
		invoke Random
		inc eax
		mov [v_tmpDD], eax
		fild [v_tmpDD]
		fstp v_We[ecx]
		sub ecx, 10
		cmp ecx, 0
	jge v_fillRand
	
	popad
	ret
Perceptron endp

Recognize proc

	ret
Recognize endp

Teach proc
	ret
Teach endp