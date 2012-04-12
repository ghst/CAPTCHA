.code

; === Is AL a digit? === ;		in: AL		out: ZF == 0 ? NotDigit : Digit
IsDigit proc
	push eax
	mov ah, 0
	cmp al, '0'
	jb v_isNotDigit
	cmp al, '9'
	ja v_isNotDigit
	mov ah, 1
v_isNotDigit:
	cmp ah, 0
	pop eax
	ret
IsDigit endp