.model small
.stack 100h
.data
    endl db 0Dh, 0Ah, 24h

    src db "text.txt",0h

    in_fh dw 0000h
    
    buff db 256 dup(?)
    prevch db 1 dup(?)

    char_nr dw 0
    cap_nr dw 0
    low_nr dw 0
    word_nr dw 0

    msg1 db "Simboliu skaicius tekste: $"
    msg4 db "Zodziu skaicius tekste: $"
    msg3 db "Mazuju raidziu skaicius tekste: $"
    msg2 db "Didziuju raidziu skaicius tekste: $"

.code

start:
    mov dx,@data
    mov ds,dx
    
    mov ax, 3d00h
    lea dx, src
    int 21h
    mov in_fh,ax

;------------------------------------------------------------------------------------------------------------------
skaitymas:
    lea dx,buff
    mov ax,3f00h		;read file
    mov bx,in_fh
    mov cx,0100h
    int 21h

	mov cx, ax
	mov bx, offset buff
	cmp ax, 0
	je pab

loop1:
	;push cx
	mov ah, [bx]

	;mov cx, char_nr
	;inc cx
	;mov char_nr, cx

	inc [char_nr]

zodis:
    cmp ah, ' '
    jne cap
    cmp prevch, ' '
    je cap
	inc [word_nr]
	;mov cx, word_nr
	;inc cx
	;mov word_nr, cx
;--------------------------TIKRINA AR RAIDE MAZOJI/DIDZIOJI--------------------------------------------------------
cap:
    cmp ah, 'z'
    ja failopab
    cmp ah, 'a'
    jb nemazoji   		; mazoji z-a
	
	inc [low_nr]
	;mov cx, low_nr
	;inc cx
	;mov low_nr, cx
	jmp failopab

nemazoji:
    	cmp ah, 'Z'
    	ja failopab
    	cmp ah, 'A'
    	jb failopab		; didzioji Z-A
	
	inc [cap_nr]
	;mov cx, cap_nr
	;inc cx
	;mov cap_nr, cx
	jmp failopab

failopab:

    	mov prevch, ah

	inc bx
	loop loop1

    jmp skaitymas
pab:
    mov ax, 3e00h 		;close file
    mov bx, in_fh
    int 21h
;------------------------SPAUSDINA TEKSTO DUOMENIS--------------------------------------------------------------

    mov dx, offset msg1
    mov ah, 09h
    int 21h

    mov dx, char_nr		;spausdina simboliu skaiciu
    dec dx
    call bin2dec

    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov dx, cap_nr		;spausdina didziuju raidziu skaiciu
    call bin2dec

    mov dx, offset msg3
    mov ah, 09h
    int 21h

    mov dx, low_nr		;spausdina mazuju raidziu skaiciu
    call bin2dec
	
    mov dx, offset msg4
    mov ah, 09h
    int 21h

    mov dx, word_nr		;spausdina zodziu skaiciu
    inc dx
    call bin2dec
;--------------------------------------------------------------------------------------------------------------
pabaiga:
	mov ax, 4c00h	 ; iseina is programos
	int 21h
;-----------------------------------BINARY TO DECIMAL FUNKCIJA-----------------------------------------
bin2dec:
 
    push    ax
    push    cx
    push    dx
    push    si
    mov     ax,dx		;Skaicius prasideda dx
    mov     si,10		;decimal 10
    xor     cx,cx		;Pradeda skaiciavima nuo 0
 
    Nenulis:
    xor     dx,dx   		;Isvalo liekada
    div     si
    push    dx    		;Issaugo skaicius atbuline tvarka
    inc     cx
    or      ax,ax   		;Tikrina, ar pradinis skaicius 0
    jnz     Nenulis		;Jei ne, loopina
 
    mov     ah,02h
 
    rasymas:
    pop     dx
    add     dx,"0"  		;Pavercia i ascii
    int     21h     		;Printina dec skaiciu
    loop    rasymas
 
    mov dx, offset endl
    mov ah, 09h
    int 21h
 
    decpabaiga:
    pop     si
    pop     dx
    pop     cx
    pop     ax
RET

end start