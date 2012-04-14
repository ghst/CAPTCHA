.code

; === CalcSigma <=> 1 / (1 + e^(-NEC)) === ;		in: st(0) = NEC		out: st(0) = Sigma(NEC)
Sigma proc			;
	; === ExpX === ;
	fldl2e				; [log2e][x]
	fmul
	fld st(0)
	fld1
	fxch				; [xlog2e][1][xlog2e]
	fprem
	fsub st(2), st(0)	; [fractPart][1][intPart]
	f2xm1
	fadd				; [e^x/2^fract][intPart]
	fscale
	fstp st(1)
	; === End === ;
	
	; === Sigma === ;
	fld1
	fdiv st(0), st(1)
	fstp st(1)
	fld1
	fadd
	fld1
	fdiv st(0), st(1)
	fstp st(1)
	; === End === ;
	ret
Sigma endp