include Inc/Recognize.inc

.code

; === Calculate array of probabilities === ;		in: v_X and v_We must be initialized 		out: v_Probs = array of probabilities
Recognize proc
	pushad
	
	xor eax, eax
	xor edx, edx			; WHF offset
	finit
	.while eax < v_NDT		; for every neuron
	
		xor ebx, ebx
		fldz
		.while ebx < [v_WHF]
			fld tbyte ptr v_We[ebx+edx]
			fld tbyte ptr v_X[ebx+edx]
			fadd
			fadd
			add ebx, v_dtSize
		.endw
		
		call Sigma
		fstp tbyte ptr v_Probs[eax]
		add edx, v_WHF
		add eax, v_dtSize
	.endw
	
	popad
	ret
Recognize endp