.386
.model flat, stdcall

include Main.inc

.data
	message		db	"Hi", 0
	caption		db 	"Imma program", 0

.const

.code
start:
	mov eax, 20h
	invoke MessageBoxA, 0, addr message, addr caption, MB_OK
	
	invoke ExitProcess, 0
End start