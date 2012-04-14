.code

; === Parse values contained into string. Stop-symbols is ' ' or #13 === ;			in: eax = addr of string		out: v_Number = number, v_newAddr = addr to first symbol AFTER stop-symbol, v_ERROR = Did error happen?
SimpleParser proc
	pop [v_retAddr]
	pop eax
	pushad
	mov [v_ERROR], 0
	xor ecx, ecx
	xor edi, edi
	mov ebp, [eax]
	mov edx, ebp
	and edx, 0FFh
	cmp dl, '-'
	jne v_StackSP
	mov edi, 1
	inc eax
	mov ebp, [eax]

v_StackSP:
	mov edx, ebp
	and edx, 0FFh
	cmp dl, ' '
	jz v_PrepFNCSP
	cmp dl, 13
	jz v_PrepFNCSP

	push edx
	inc eax
	mov ebp, [eax]
	inc ecx
	jmp v_StackSP

v_PrepFNCSP:
	inc eax
	mov [v_newAddr], eax
	xor ebx, ebx
	mov edx, 1

v_formNumberCycleSP:
	pop eax
	call IsDigit
	jz v_errorSP
	sub al, 30h
	push edx
	mul edx
	pop edx
	add ebx, eax
	mov eax, edx
	mul [v_tenConst]
	mov edx, eax
	loop v_formNumberCycleSP

v_preQuitSP:
	cmp edi, 1
	jnz v_quitSP
	neg ebx
	jmp v_quitSP
v_errorSP:
	mov [v_ERROR], 1
	jmp v_quitSP
v_quitSP:
	mov [v_Number], bx
	popad
	push [v_retAddr]
	ret
SimpleParser endp
