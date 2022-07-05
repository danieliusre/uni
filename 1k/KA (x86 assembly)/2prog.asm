.model small
.stack 100h
 
.data
    endl db 0Dh, 0Ah, 24h
 
    filename db 256 dup(?)
 
    in_fh dw 0000h
 
    buff db 255 dup(?)
    prevch db 1 dup(?)
 
    char_nr dw 0
    cap_nr dw 0
    low_nr dw 0
    word_nr dw 0
 
    msg1 db "Simboliu skaicius tekste: $"
    msg4 db "Zodziu skaicius tekste: $"
    msg3 db "Mazuju raidziu skaicius tekste: $"
    msg2 db "Didziuju raidziu skaicius tekste: $"
    helpmsg db "Iveskite 2prog ir failo pavadinima (Pvz.:2prog text.txt), programa isspausdins  failo statistinius duomenis$"
    errormsg db "Failo atidaryti nepavyko arba jis neegzistuoja, bandykite is naujo$"
 
.code
 
start:
    mov dx,@data
    mov ds,dx
;-----------------------------------------------------FAILO VARDO GAVIMAS IS KOMANDINES EILUTES-----------------------------------------------
 
	xor cx, cx
	mov cl, es:[80h]	; eilutes ilgis
	mov si, 82h		; 1 eilutes simbolis
	mov ah, es:[si]
	cmp ah, "/"
	jne pradzia
	jmp pagalba
 
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

    mov ax, 3d00h
    lea dx, filename
    int 21h
    mov in_fh,ax

	jc klaida1

    xor cx, cx
    mov char_nr, cx
    mov low_nr, cx
    mov cap_nr, cx
    mov word_nr, cx
 
;--------------------------------SKAITYMAS IS FAILO----------------------------------------
skaitymas:
    mov ax,3f00h		;read file
    mov bx,in_fh
    mov cx,0100h
    mov dx, offset buff
    int 21h

    mov cx, ax
    mov bx, offset buff
    	cmp ax, 0           ;paklausti kodel neveike su push/pop
	je pab
loop1:

    mov ah, [bx]
    inc [char_nr]

zodis:
    cmp ah, ' '
    jne cap
    cmp prevch, ' '
    je cap

    inc [word_nr]
;--------------------------TIKRINA AR RAIDE MAZOJI/DIDZIOJI--------------------------------------------------------
cap:
    cmp ah, 'z'
    ja failopab
    cmp ah, 'a'
    jb nemazoji   		; mazoji z-a
	
    inc [low_nr]
    jmp failopab

nemazoji:
    cmp ah, 'Z'
    ja failopab
    cmp ah, 'A'
    jb failopab		; didzioji Z-A
	
    inc [cap_nr]

	jmp failopab

klaida1:
	jmp klaida

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

    pop bx
    pop cx
    pop si

    jmp eloop2
;-------------------------------PABAIGA-----------------------------------------------------------------
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
    inc [word_nr]
    jmp cap
klaida:
    mov dx, offset errormsg
    mov ah, 09h
    int 21h

    mov dx, offset endl
    mov ah, 09h
    int 21h

	jmp pabaiga
newline:
    cmp prevch, 0Ah
    je cap1
    inc [word_nr]
    jmp cap
pagalba:
    mov ah, es:[83h]
    cmp ah, "?"
    je pagalba1
	jmp pradzia
pagalba1:
    mov dx, offset helpmsg
    mov ah, 09h
    int 21h

    mov dx, offset endl
    mov ah, 09h
    int 21h

	jmp pabaiga

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
    xor     dx,dx   		;Isvalo liekana
    div     si
    inc     cx
    push    dx    		;Issaugo skaicius atbuline tvarka
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