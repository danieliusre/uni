.model small
.stack 100h
 
.data
    endl db 0Dh, 0Ah, 24h
 
    filename db 256 dup(?)
 
    in_fh dw 0000h
 
    buff db 1 dup(?)
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
;-----------------------------------------------------FAILO VARDO GAVIMAS IS KOMANDINES EILUTES-----------------------------------------------
 
	xor cx, cx
	mov cl, es:[80h]	; eilutes ilgis
	mov si, 82h		; 1 eilutes simbolis
 
pradzia:
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
 
	jmp open
 
eloop2:
	inc bx
	inc si
	loop loop2
 
jmp pabaiga
;------------------------------------------FAILO ATIDARYMAS-----------------------
open:
    push si
    push cx
    push bx

	xor cx, cx
	mov char_nr, cx
	mov word_nr, cx
	mov cap_nr, cx
	mov low_nr, cx

    mov ax, 3d00h
    lea dx, filename
    int 21h
    mov in_fh,ax
 
;--------------------------------SKAITYMAS IS FAILO----------------------------------------
skaitymas:
    lea dx,buff
    mov ax,3f00h		;read file
    mov bx,in_fh
    mov cx,01h
    int 21h
 
    cmp buff, 0Dh 		;tikrina ar charas ne endl
    je zodis
    cmp buff, 0Ah
    je zodis
    mov cx, char_nr  		;char counteris
    inc cx
    mov char_nr, cx
    ;mov cx, 01h
 
zodis:
    cmp buff, ' '
    je tarpas1
    cmp buff, 0Dh
    je newline1
;--------------------------TIKRINA AR RAIDE MAZOJI/DIDZIOJI--------------------------------------------------------
cap:
    cmp buff, 'z'
    ja failopab
    cmp buff, 'a'
    jnb mazoji1     		; mazoji z-a
    cmp buff, 'Z'
    ja failopab
    cmp buff, 'A'
    jnb didzioji1		; didzioji Z-A
 
failopab:
 
    mov dl, buff
    mov prevch, dl
 
    cmp ax, 0
    jnz skaitymas
 
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

    pop bx
    pop cx
    pop si
 
    jmp eloop2
;--------------------------------------------------------------------------------------------------------------
pabaiga:
    mov ah, 4ch			;exit
    mov al, 0
    int 21h
;----------------------------TARPINIAI JUMPAI------------------------------------------------------
tarpas1:
	jmp tarpas
cap1:
	jmp cap
newline1:
	jmp newline
mazoji1:
	jmp mazoji
didzioji1:
	jmp didzioji
;------------------------------------FUNKCIJOS--------------------------------------------------------------
tarpas:
    cmp prevch, ' '
    je cap1
    mov cx, word_nr
    inc cx
    mov word_nr, cx
    jmp cap
 
newline:
    cmp prevch, 0Ah
    je cap1
    mov cx, word_nr
    inc cx
    mov word_nr, cx
    jmp cap
;-----------------------------------MAZUJU/DIDZIUJU RAIDZIU COUNTERIS---------------------------------
mazoji:
	mov cx, low_nr
	inc cx
	mov low_nr, cx
	jmp failopab
 
didzioji:
	mov cx, cap_nr
	inc cx
	mov cap_nr, cx
	jmp failopab
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