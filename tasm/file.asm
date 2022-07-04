.model small
.stack 100h

.data
	endl db 0Dh, 0Ah, 24h
	src db "text.txt", 0h
	;dst db "tekstas2.txt", 0h

	msg1 db "Simboliu skaicius tekste: "
	msg2 db "Zodziu skaicius tekste: "
	msg3 db "Mazuju raidziu skaicius tekste: "
	msg4 db "Didziuju raidziu skaicius tekste: "
	
	msgerror db "Failo atidaryti nepavyko arba jis neegzistuoja$"

	in_fh dw 0000h
	out_fh dw 0000h
    
	buff db 256 dup(?)

	char_number dw 0
	word_number dw 0
	low_number dw 0
	up_number dw 0

.code

start:
	mov dx,@data
	mov ds,dx
    
	mov ax, 3d00h    ;open file
	lea dx, src
	int 21h
	mov in_fh, ax

	;mov ax, 3c00h   ;create file
	;xor cx, cx
	;lea dx, dst
	;int 21h
	;mov out_fh, ax
    
	lea dx, buff    ;load effective address(?)
l:
	mov ax, 3f00h   ;read file
	mov bx, in_fh
	mov cx, 0100h   ;read char from stdin
	int 21h

	;mov bx, offset buff
	xor cx, cx
	mov cl, buff
charai:
	inc char_number
	loop charai
	

	;mov cx, ax
	;mov ax, 4000h ; write file
	;mov bx, out_fh
	;int 21h

	

	cmp ax,0
	jnz l

	mov ax,3e00h ; close file
	mov bx, out_fh
 	int 21h

	;mov ax,3e00h ; close file
	;mov bx, in_fh
	;int 21h

exit:
	mov ah, 09h
	mov dx, char_number
	int 21h


	mov ah, 4ch
	mov al, 0
	int 21h

end start
