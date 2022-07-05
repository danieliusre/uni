.model small
.stack 100h
.data
	msg db "Iveskite simboliu eilute:$"
	msg1 db 13, 10, "Ivesta eilute be tarpu:$"
	buff db 255, 0, 255 dup(?) ; duomenu ivedimas, pildymas '?'
.code

start:
	mov dx, @data
	mov ds, dx

	mov ah, 09h
	mov dx, offset msg
	int 21h

	mov ah, 0ah  		;failo irasymas i buff + 1
	mov dx, offset buff
	int 21h

	mov ah, 09h
	mov dx, offset msg1
	int 21h

	mov ah, 40h
	mov bx, 1
	xor cx, cx ; cx nulinimas
	mov cl, [buff + 1]
	mov dx, offset buff + 2
	int 21h

	mov ax, 4c00h
	int 21h

end start
