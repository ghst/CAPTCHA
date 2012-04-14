.code

; === Is (probs - etalon <= v_Eps) ? === ;		in: v_Probs and v_Etalon must be initialized		out: ZF == 0 ? Equal : NotEqual
IsEqual proc
	pushad
	
	xor ecx, ecx
	xor edx, edx							; is FALSE?
	finit
	fld [v_Eps]
	.while ecx < v_NDT
		fld tbyte ptr v_Probs[ecx]
		fld tbyte ptr v_Etalon[ecx]
		fsub								; probs[i] - etalon[i]
		fsubr
		ftst
		fstsw ax
		sahf
		ja v_breakIE
		jmp v_contIE
		
		v_breakIE:
			mov edx, 1
			fstp st(0)
			.break
			
		v_contIE:
		fstp st(0)
	.endw
	
	test edx, edx
	
	popad
	ret
IsEqual endp