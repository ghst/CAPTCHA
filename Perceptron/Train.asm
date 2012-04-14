include Inc/Train.inc

.code

; === Train perceptron by change weights === ;		in: v_X and v_Etalon must be initialized		out: <none>
Train proc
	pushad
	call Recognize
	.while TRUE
		call IsEqual
		jnz v_stopTrainingT
		
		xor eax, eax		; counter * 10
		.while eax < v_NDT
			fld tbyte ptr v_Probs[eax]
			fld tbyte ptr v_Etalon[eax]
			fsub							; probs - etalon
			
			; === Change weights === ;
			push eax
			mov ebx, v_WHF
			mul ebx
			mov ebx, eax			; ebx = eax * v_WHF
			pop eax
			
			push eax
			inc eax
			mov ecx, ebx
			mul ecx
			mov ecx, eax
			pop eax					; ecx = (eax + 1) * v_WHF
			xor edx, edx
			.while ebx < ecx		; v_WHF * (eax + 1)
				fld tbyte ptr v_X[edx]
				fld tbyte ptr v_We[ebx]		; [v_X][v_We][d]   <---0---7---
				fmul st(0), st(2)
				fadd
				fstp tbyte ptr v_We[ebx]
				add ebx, v_dtSize
				add edx, v_dtSize
			.endw
			; === End === ;
			
			add eax, v_dtSize
		.endw
		
		call Recognize
		
		v_stopTrainingT:
			.break
	.endw
	
	ret
Train endp