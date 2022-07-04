.model tiny 
.code
org 0100h

start:

	mov al, bh
	mov si, dx
	mov ah, bh

	mov ax, atmintis1
	mov atmintis1, ax
	mov al, atmintis
	
	mov al, es:[si+02h]
	mov si, [bp+di]
	
	mov cl, 01h

	mov ax, [bx+si]
	mov ax, bx
	


	not ah
	not cl
	not bh
	not si
	not dx
	
	atmintis db 99h
	atmintis1 dw 6325h
	
	rcr ax, cl
	rcr dx, 1
	rcr si, 1
	
	mov dx, 0100h
	mov al, cs:[si]
	mov cl, ss:[bx+si]
	
	xlat
	xlat
	xlat 
	
end start