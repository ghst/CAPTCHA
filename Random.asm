.code

; === Randomize === ;
Randomize Proc	;		in: <none>		out: v_seed = seed
	pushad
	call GetTickCount
	mov [v_seed], eax
	popad
	ret
Randomize EndP

; === Random === ;
Random Proc		;		in: stack(0) = range (Int32)			out: eax = random value
	pop [v_retAddr]
	pop eax
	
	push ebx
	push edx
	xchg ebx, eax
	mov eax, [v_seed]
	imul eax, 8088405h		; just a value
	inc eax
	mov [v_seed], eax
	xor edx, edx
	mul ebx
    xchg edx, eax
    pop edx
    pop ebx
    
    push [v_retAddr]
	ret
Random EndP