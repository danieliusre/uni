.model small
.stack 100h
.data
	buff db 256 dup(?)
	filename db 256 dup(?)
	;errormsg1 db "Failo atidaryti nepavyko arba jis neegzistuoja$"
    	endl db 0Dh, 0Ah, 24h

.code
start:
	mov dx, @data
	mov ds, dx

	xor cx, cx
	mov cl, es:[80h]	; eilutes ilgis
	mov si, 82h		; eilutes simbolis
	

	xor ah, ah
	mov bx, offset filename
loop2:
	mov al, es:[si]
	cmp al, ' '
	je yra
	cmp al, 13 ; EOL
	je yra
	mov [bx], al
	inc ah
	jmp eloop2

yra:
	push cx

	mov cl, ah
	mov ah, 40h
	mov bx, 1
	mov dx, offset filename
	int 21h

	mov cl, 02h
	mov ah, 40h
	mov bx, 1
	mov dx, offset endl
	int 21h
	
	mov bx, offset [filename - 1]
	pop cx

	xor ah, ah
eloop2:
	inc bx
	inc si
	loop loop2

finish:
	mov ax, 4c00h
	int 21h

end start