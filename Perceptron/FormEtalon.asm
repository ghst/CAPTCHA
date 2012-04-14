.code

; === Form and set to zero array then put ONE at position that correspond to recognizing digit === ;		in: stack(0) = recognizing digit		out: <none>
FormEtalon proc
	pop [v_retAddr]
	pop ebx
	pushad
	
	xor ecx, ecx
	finit
	.while ecx < v_NDT
		fldz
		fstp tbyte ptr v_Etalon[ecx]
		add ecx, v_N
	.endw
	fld1
	mov eax, v_N
	mul ebx
	fstp tbyte ptr v_Etalon[ebx]
	
	popad
	push [v_retAddr]
	ret
FormEtalon endp