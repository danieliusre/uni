;Apdoroti MOV, OUT, NOT, RCR, XLAT
.model small
.stack 100h
.data
	endl db 0Dh, 0Ah, 24h
	
	filename db 256 dup(?)
	dst db "rez.txt", 0h
	
	in_fh dw 0000h
	out_fh dw 0000h

	movkomanda db "mov "
	notkomanda db "not "
	outkomanda db "out "
	rcrkomanda db "rcr "
	xlatkomanda db "xlat "
	tarpas db ", "
	rcr1 db "1 "
	msg db ":   "
	pliusas db "+"
	
	output db 256 dup(?)
	
	buff db 256 dup(?)
	
	komanda db 1 dup(?)
	
	d db 1 dup(?)
	w db 1 dup(?)
	modd db 1 dup(?)
	reg db 1 dup(?)
	rm db 1 dup(?)
	poslinkis1 db 0
	poslinkis2 dw 0
	
	operandas1 dw 1 dup(?)
	operandas2 dw 1 dup(?)
	siop db "SI"
	diop db "DI"


.code
start:
	mov dx, @data
	mov ds, dx
;------------------------------------------------------------FAILO VARDO GAVIMAS----------------------------------
	xor cx, cx
	mov cl, es:[80h]	; eilutes ilgis
	mov si, 82h		; 1 eilutes simbolis
	mov ah, es:[si]
	;cmp ah, "/"
	;jne pradzia
	;jmp pagalba
 
pradzia:
	xor ah, ah
	mov bx, offset filename
	
loop2:
	mov al, es:[si]
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
;----------------------------------------------------------------------FAILO ATIDARYMAS----------------------------------------
open:
	mov ax, 3d00h
	lea dx, filename
	int 21h
	mov in_fh, ax
	
	;jc klaida

    mov ax, 3c00h
    xor cx,cx
    lea dx, dst
    int 21h
    mov out_fh,ax
;---------------------------------------------------------------------SKAITYMAS IS FAILO---------------------------------------
read:
	mov ax, 3f00h
	mov bx, in_fh
	mov cx, 100h
	mov dx, offset buff
	int 21h
	
	mov cx, ax
	mov bx, offset buff
	cmp ax, 0
	jne loop1
	jmp pabaiga

loop1:
	push cx	

	xor ax, ax
	mov ah, [bx]
	
	jmp compare

nemano:
	pop cx
	inc bx
	loop loop1
	
	jmp read
	
compare:
;call printhex

	cmp ah, 88h
	jne p1
	jmp mov8
p1:
	cmp ah, 89h
	jne p2
	jmp mov9
p2:
	cmp ah, 8Ah
	jne p3
	jmp movA	
p3:
	cmp ah, 8Bh
	jne p4
	jmp movB
p4:
	cmp ah, 11110110b
	jne p5
	jmp not0
p5:
	cmp ah, 11110111b
	jne p6
	jmp not1
p6:
	cmp ah, 11010111b
	jne p7
	jmp xlat1
p7:
	cmp ah, 11010000b
	jne p8
	jmp rcr00
p8:
	cmp ah, 11010010b
	jne p9
	jmp rcr10
p9:
	cmp ah, 11010001b
	jne p10
	jmp rcr01
p10:
	cmp ah, 11010011b
	jne p11
	jmp rcr11
p11:
	cmp ah, 11000110b
	jne p12
	jmp mov20
p12:
	cmp ah, 11000111b
	jne p13
	jmp mov21
p13:
	cmp ah, 1011b
	jne p14
	jmp mov3
p14:
	cmp ah, 10100000b
	jne p15
	jmp mov40
p15:
	cmp ah, 10100001b
	jne p16
	jmp mov41
p16:
	cmp ah, 10100010b
	jne p17
	jmp mov50
p17:
	cmp ah, 10100011b
	jne p18
	jmp mov51
p18:
	cmp ah, 10001100b
	jne p19
	jmp mov60
p19:
	cmp ah, 10001110b
	jne p20
	jmp mov61
p20:
	
	
	
	
	jmp nemano
	
pabaiga:

	mov ax, 3e00h 		;close file
    mov bx, in_fh
    int 21h
	
	mov ax, 3e00h 		;close file
    mov bx, out_fh
    int 21h
	
    mov ah, 4ch			;exit
    mov al, 0
    int 21h	
	
mov8:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov d, cl
	mov w, cl
	
	jmp movadresavimobaitas
mov9:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov d, cl
	mov cl, 1
	mov w, cl

	jmp movadresavimobaitas
movA:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov cl, 0
	mov w, cl
	
	jmp movadresavimobaitas
movB:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
	
mov20:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov w, cl

	jmp movadresavimobaitas
mov21:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov w, cl

	jmp movadresavimobaitas
mov3:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov40:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov41:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov50:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov51:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov60:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
mov61:
	push bx
	
	mov cx, 4h
	mov dx, offset movkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov d, cl
	mov w, cl

	jmp movadresavimobaitas
	
not0:
	push bx
	
	mov cx, 4h
	mov dx, offset notkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov w, cl
	jmp notadresavimobaitas
not1:
	push bx
	
	mov cx, 4h
	mov dx, offset notkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov w, cl
	jmp notadresavimobaitas
xlat1:
	push bx
	
	mov cx, 4h
	mov dx, offset xlatkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	mov cx, 2h
	mov dx, offset endl
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	jmp nemano
rcr00:
	push bx
	
	mov cx, 4h
	mov dx, offset rcrkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov w, cl
	
	mov komanda, 4
	
	jmp rcradresavimobaitas
rcr01:
	push bx
	
	mov cx, 4h
	mov dx, offset rcrkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov w, cl
	
	mov komanda, 4
	
	jmp rcradresavimobaitas

rcr10:
	push bx
	
	mov cx, 4h
	mov dx, offset rcrkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 0
	mov w, cl
	
	mov operandas2, "LC"
	jmp rcradresavimobaitas
rcr11:
	push bx
	
	mov cx, 4h
	mov dx, offset rcrkomanda
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	pop bx
	
	mov cl, 1
	mov w, cl
	mov operandas2, "LC"
	jmp rcradresavimobaitas
	
movadresavimobaitas:
	inc bx
	
	mov ah, [bx]
	and ah, 11000000b
	mov modd, ah
	
	mov ah, [bx]
	and ah, 00111000b
	mov reg, ah
	
	mov ah, [bx]
	and ah, 00000111b
	mov rm, ah
	
	cmp w, 0
	je w0
	jmp w1
	
notadresavimobaitas:
	inc bx
	
	mov ah, [bx]
	and ah, 11000000b
	mov modd, ah
	
	mov reg, 00010000b
	
	mov ah, [bx]
	and ah, 00000111b
	mov rm, ah
	
	mov d, 0
	mov komanda, 2
	jmp operandai2
	
rcradresavimobaitas:
	inc bx
	
	mov ah, [bx]
	and ah, 11000000b
	mov modd, ah
	
	mov reg, 00011000b
	
	mov ah, [bx]
	and ah, 00000111b
	mov rm, ah
	
	mov d, 0
	jmp operandai2
	
w0:  ;------------------------------------- w=0, tikrina reg ---------------------------
	cmp reg, 00000000b
	jne persoka1
	jmp reg000w0
persoka1:
	cmp reg, 00001000b
	jne persoka2
	jmp reg001w0
persoka2:
	cmp reg, 00010000b
	jne persoka3
	jmp reg010w0
persoka3:
	cmp reg, 00011000b
	jne persoka4
	jmp reg011w0
persoka4:
	cmp reg, 00100000b
	jne persoka5
	jmp reg100w0
persoka5:
	cmp reg, 00101000b
	jne persoka6
	jmp reg101w0
persoka6:
	cmp reg, 00110000b
	jne persoka7
	jmp reg110w0
persoka7:
	cmp reg, 00111000b
	jne persoka8
	jmp reg111w0
persoka8:
	
w1: ;------------------------------------- w=1, tikrina reg ---------------------------
	cmp reg, 00000000b
	jne persoka11
	jmp reg000w1
persoka11:
	cmp reg, 00001000b
	jne persoka12
	jmp reg001w1
persoka12:
	cmp reg, 00010000b
	jne persoka13
	jmp reg010w1
persoka13:
	cmp reg, 00011000b
	jne persoka14
	jmp reg011w1
persoka14:
	cmp reg, 00100000b
	jne persoka15
	jmp reg100w1
persoka15:
	cmp reg, 00101000b
	jne persoka16
	jmp reg101w1
persoka16:
	cmp reg, 00110000b
	jne persoka17
	jmp reg110w1
persoka17:
	cmp reg, 00111000b
	jne persoka18
	jmp reg111w1
persoka18:

reg000w0: ;--------------------------- w=0, priskiria reiksme pagal reg ---------------
	cmp d, 1
	jne ne0000
	mov operandas1, "LA"
ne0000:
	mov operandas2, "LA"
	jmp operandai2
	
reg001w0:
	cmp d, 1
	jne ne0010
	mov operandas1, "LC"
ne0010:
	mov operandas2, "LC"
	jmp operandai2
	
reg010w0:
	cmp d, 1
	jne ne0100
	mov operandas1, "LD"
ne0100:
	mov operandas2, "LD"
	jmp operandai2
	
reg011w0:
	cmp d, 1
	jne ne0110
	mov operandas1, "LB"
ne0110:
	mov operandas2, "LB"
	jmp operandai2
	
reg100w0:
	cmp d, 1
	jne ne1000
	mov operandas1, "HA"
ne1000:
	mov operandas2, "HA"
	jmp operandai2
	
reg101w0:
	cmp d, 1
	jne ne1010
	mov operandas1, "HC"
ne1010:
	mov operandas2, "HC"
	jmp operandai2
	
reg110w0:
	cmp d, 1
	jne ne1100
	mov operandas1, "HD"
ne1100:
	mov operandas2, "HD"
	jmp operandai2
	
reg111w0:
	cmp d, 1
	jne ne1110
	mov operandas1, "HB"
ne1110:
	mov operandas2, "HB"
	jmp operandai2

reg000w1: ;--------------------------- w=1, priskiria reiksme pagal reg ---------------
	cmp d, 1
	jne ne0001
	mov operandas1, "XA"
		jmp operandai2
ne0001:
	mov operandas2, "XA"
	jmp operandai2
	
reg001w1:
	cmp d, 1
	jne ne0011
	mov operandas1, "XC"
		jmp operandai2
ne0011:
	mov operandas2, "XC"
	jmp operandai2
	
reg010w1:
	cmp d, 1
	jne ne0101
	mov operandas1, "DX"
		jmp operandai2
ne0101:
	mov operandas2, "DX"
	jmp operandai2
	
reg011w1:
	cmp d, 1
	jne ne0111
	mov operandas1, "BX"
		jmp operandai2
ne0111:
	mov operandas2, "BX"
	jmp operandai2
	
reg100w1:
	cmp d, 1
	jne ne1001
	mov operandas1, "PS"
		jmp operandai2
ne1001:
	mov operandas2, "PS"
	jmp operandai2
	
reg101w1:
	cmp d, 1
	jne ne1011
	mov operandas1, "BP"
		jmp operandai2
ne1011:
	mov operandas2, "BP"
	jmp operandai2
	
reg110w1:
	cmp d, 1
	jne ne1101
	mov operandas1, "IS"
		jmp operandai2
ne1101:
	mov operandas2, "IS"
	jmp operandai2
	
reg111w1:
	cmp d, 1
	jne ne1111
	mov operandas1, "DI"
		jmp operandai2
ne1111:
	mov operandas2, "DI"
	jmp operandai2


operandai2: ;--------------------------------SURADO VIENA, IESKO KITO------------------------------
	cmp modd, 00000000b
	jne persokamod1
	jmp mod00
persokamod1:
	cmp modd, 01000000b
	jne persokamod2
	jmp mod01
persokamod2:
	cmp modd, 10000000b
	jne persokamod3
	jmp mod10
persokamod3:
	cmp modd, 11000000b
	jne persokamod4
	jmp mod11
persokamod4:
	
mod00:
	cmp rm, 00000000b
	jne persoka21
	jmp rm000mod00
persoka21:
	cmp rm, 00000001b
	jne persoka22
	jmp rm001mod00
persoka22:
	cmp rm, 00000010b
	jne persoka23
	jmp rm010mod00
persoka23:
	cmp rm, 00000011b
	jne persoka24
	jmp rm011mod00
persoka24:
	cmp rm, 00000100b
	jne persoka25
	jmp rm100mod00
persoka25:
	cmp rm, 00000101b
	jne persoka26
	jmp rm101mod00
persoka26:
	cmp rm, 00000110b
	jne persoka27
	jmp rm110mod00
persoka27:
	cmp rm, 00000111b
	jne persoka28
	jmp rm111mod00
persoka28:
;---------------------------------------------------- mod = 01 -----------------------------------
mod01:
	cmp rm, 00000000b
	jne persoka31
	jmp rm000mod01
persoka31:
	cmp rm, 00000001b
	jne persoka32
	jmp rm001mod01
persoka32:
	cmp rm, 00000010b
	jne persoka33
	jmp rm010mod01
persoka33:
	cmp rm, 00000011b
	jne persoka34
	jmp rm011mod01
persoka34:
	cmp rm, 00000100b
	jne persoka35
	jmp rm100mod01
persoka35:
	cmp rm, 00000101b
	jne persoka36
	jmp rm101mod01
persoka36:
	cmp rm, 00000110b
	jne persoka37
	jmp rm110mod01
persoka37:
	cmp rm, 00000111b
	jne persoka38
	jmp rm111mod01
persoka38:
;-------------------------------------------------- mod = 10 ---------------------------------------
mod10:
	cmp rm, 00000000b
	jne persoka41
	jmp rm000mod10
persoka41:
	cmp rm, 00000001b
	jne persoka42
	jmp rm001mod10
persoka42:
	cmp rm, 00000010b
	jne persoka43
	jmp rm010mod10
persoka43:
	cmp rm, 00000011b
	jne persoka44
	jmp rm011mod10
persoka44:
	cmp rm, 00000100b
	jne persoka45
	jmp rm100mod10
persoka45:
	cmp rm, 00000101b
	jne persoka46
	jmp rm101mod10
persoka46:
	cmp rm, 00000110b
	jne persoka47
	jmp rm110mod10
persoka47:
	cmp rm, 00000111b
	jne persoka48
	jmp rm111mod10
persoka48:
;--------------------------------------------- mod = 11, w = 0  -------------------------------------
mod11:
	cmp w, 1
	je mod11w1

	cmp rm, 00000000b
	jne persoka51
	jmp rm000mod11
persoka51:
	cmp rm, 00000001b
	jne persoka52
	jmp rm001mod11
persoka52:
	cmp rm, 00000010b
	jne persoka53
	jmp rm010mod11
persoka53:
	cmp rm, 00000011b
	jne persoka54
	jmp rm011mod11
persoka54:
	cmp rm, 00000100b
	jne persoka55
	jmp rm100mod11
persoka55:
	cmp rm, 00000101b
	jne persoka56
	jmp rm101mod11
persoka56:
	cmp rm, 00000110b
	jne persoka57
	jmp rm110mod11
persoka57:
	cmp rm, 00000111b
	jne persoka58
	jmp rm111mod11
persoka58:
;----------------------------------------------- mod = 11, w = 1 --------------------------------
mod11w1:
	cmp rm, 00000000b
	jne persoka61
	jmp rm000mod11w1
persoka61:
	cmp rm, 00000001b
	jne persoka62
	jmp rm001mod11w1
persoka62:
	cmp rm, 00000010b
	jne persoka63
	jmp rm010mod11w1
persoka63:
	cmp rm, 00000011b
	jne persoka64
	jmp rm011mod11w1
persoka64:
	cmp rm, 00000100b
	jne persoka65
	jmp rm100mod11w1
persoka65:
	cmp rm, 00000101b
	jne persoka66
	jmp rm101mod11w1
persoka66:
	cmp rm, 00000110b
	jne persoka67
	jmp rm110mod11w1
persoka67:
	cmp rm, 00000111b
	jne persoka68
	jmp rm111mod11w1
persoka68:
	
;--------------------------------------------------------------------------------------
	
rm000mod00: ;--------------------------------------------- MOD=00 --------------------
	cmp d, 0
	jne ne000
	mov operandas1, "XB"
	jmp beposlinkio
ne000:
	mov operandas2, "XB"
	jmp beposlinkio

rm001mod00:
	cmp d, 0
	jne ne001
	mov operandas1, "XB"
	jmp beposlinkio
ne001:
	mov operandas2, "XB"
	jmp beposlinkio

rm010mod00:
	cmp d, 0
	jne ne002
	mov operandas1, "PB"
	jmp beposlinkio
ne002:
	mov operandas2, "PB"
	jmp beposlinkio
	
rm011mod00:
	cmp d, 0
	jne ne003
	mov operandas1, "PB"
	jmp beposlinkio
ne003:
	mov operandas2, "PB"
	jmp beposlinkio
	
rm100mod00:
	cmp d, 0
	jne ne004
	mov operandas1, "IS"
	jmp beposlinkio
ne004:
	mov operandas2, "IS"
	jmp beposlinkio
	
rm101mod00:
	cmp d, 0
	jne ne005
	mov operandas1, "ID"
	jmp beposlinkio
ne005:
	mov operandas2, "ID"
	jmp beposlinkio
	
rm110mod00:
	cmp d, 0
	jne ne006
	mov operandas1, "!!"
	jmp beposlinkio
ne006:
	mov operandas2, "!!"
	jmp beposlinkio
	
rm111mod00:
	cmp d, 0
	jne ne007
	mov operandas1, "XB"
	jmp beposlinkio
ne007:
	mov operandas2, "XB"
	jmp beposlinkio
	
rm000mod01: ;--------------------------------------------- MOD=01 --------------------
	cmp d, 0
	jne ne010
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne010:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu

rm001mod01:
	cmp d, 0
	jne ne011
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne011:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu

rm010mod01:
	cmp d, 0
	jne ne012
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne012:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
	
rm011mod01:
	cmp d, 0
	jne ne013
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne013:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
	
rm100mod01:
	cmp d, 0
	jne ne014
	mov operandas1, "IS"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne014:
	mov operandas2, "IS"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
	
rm101mod01:
	cmp d, 0
	jne ne015
	mov operandas1, "ID"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne015:
	mov operandas2, "ID"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
	
rm110mod01:
	cmp d, 0
	jne ne016
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne016:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
	
rm111mod01:
	cmp d, 0
	jne ne017
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu
ne017:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis1, ah
	
;	jmp suposlinkiu

rm000mod10: ;--------------------------------------------- MOD=10 --------------------
	cmp d, 0
	jne ne100
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne100:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2

rm001mod10:
	cmp d, 0
	jne ne101
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne101:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2

rm010mod10:
	cmp d, 0
	jne ne102
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne102:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
	
rm011mod10:
	cmp d, 0
	jne ne103
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne103:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
	
rm100mod10:
	cmp d, 0
	jne ne104
	mov operandas1, "IS"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne104:
	mov operandas2, "IS"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
	
rm101mod10:
	cmp d, 0
	jne ne105
	mov operandas1, "ID"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne105:
	mov operandas2, "ID"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
	
rm110mod10:
	cmp d, 0
	jne ne106
	mov operandas1, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne106:
	mov operandas2, "PB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
	
rm111mod10:
	cmp d, 0
	jne ne107
	mov operandas1, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah
	
;	jmp suposlinkiu2
ne107:
	mov operandas2, "XB"
	
;	inc bx
;	mov ah, [bx]
;	mov poslinkis21, ah
;	inc bx
;	mov ah, [bx]
;	mov poslinkis22, ah

;	jmp suposlinkiu2
	
rm000mod11: ;--------------------------------------------- MOD=11 w=0 --------------------
	cmp d, 0
	jne ne110
	mov operandas1, "LA"
	jmp beposlinkio
ne110:
	mov operandas2, "LA"
	jmp beposlinkio

rm001mod11:
	cmp d, 0
	jne ne111
	mov operandas1, "LC"
	jmp beposlinkio
ne111:
	mov operandas2, "LC"
	jmp beposlinkio

rm010mod11:
	cmp d, 0
	jne ne112
	mov operandas1, "LD"
	jmp beposlinkio
ne112:
	mov operandas2, "LD"
	jmp beposlinkio
	
rm011mod11:
	cmp d, 0
	jne ne113
	mov operandas1, "LB"
	jmp beposlinkio
ne113:
	mov operandas2, "LB"
	jmp beposlinkio
	
rm100mod11:
	cmp d, 0
	jne ne114
	mov operandas1, "HA"
	jmp beposlinkio
ne114:
	mov operandas2, "HA"
	jmp beposlinkio
	
rm101mod11:
	cmp d, 0
	jne ne115
	mov operandas1, "HC"
	jmp beposlinkio
ne115:
	mov operandas2, "HC"
	jmp beposlinkio
	
rm110mod11:
	cmp d, 0
	jne ne116
	mov operandas1, "HD"
	jmp beposlinkio
ne116:
	mov operandas2, "HD"
	jmp beposlinkio
	
rm111mod11:
	cmp d, 0
	jne ne117
	mov operandas1, "HB"
	jmp beposlinkio
ne117:
	mov operandas2, "HB"
	jmp beposlinkio	
	
rm000mod11w1: ;--------------------------------------------- MOD=11 w=1 --------------------
	cmp d, 0
	jne ne110w1
	mov operandas1, "XA"
	jmp beposlinkio
ne110w1:
	mov operandas2, "XA"
	jmp beposlinkio

rm001mod11w1:
	cmp d, 0
	jne ne111w1
	mov operandas1, "XC"
	jmp beposlinkio
ne111w1:
	mov operandas2, "XC"
	jmp beposlinkio

rm010mod11w1:
	cmp d, 0
	jne ne112w1
	mov operandas1, "XD"
	jmp beposlinkio
ne112w1:
	mov operandas2, "XD"
	jmp beposlinkio
	
rm011mod11w1:
	cmp d, 0
	jne ne113w1
	mov operandas1, "XB"
	jmp beposlinkio
ne113w1:
	mov operandas2, "XB"
	jmp beposlinkio
	
rm100mod11w1:
	cmp d, 0
	jne ne114w1
	mov operandas1, "SP"
	jmp beposlinkio
ne114w1:
	mov operandas2, "SP"
	jmp beposlinkio
	
rm101mod11w1:
	cmp d, 0
	jne ne115w1
	mov operandas1, "PB"
	jmp beposlinkio
ne115w1:
	mov operandas2, "PB"
	jmp beposlinkio
	
rm110mod11w1:
	cmp d, 0
	jne ne116w1
	mov operandas1, "IS"
	jmp beposlinkio
ne116w1:
	mov operandas2, "IS"
	jmp beposlinkio
	
rm111mod11w1:
	cmp d, 0
	jne ne117w1
	mov operandas1, "ID"
	jmp beposlinkio
ne117w1:
	mov operandas2, "ID"
	jmp beposlinkio	

beposlinkio: ;--------------------------- spausdina, poslinkio nera --------------------------------------------
	push bx
	
	mov cx, 2h
	mov dx, offset operandas1
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	cmp komanda, 2
	je viskas
	
	mov cx, 2h
	mov dx, offset tarpas
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	cmp komanda, 4
	jne nercr0	
	mov cx, 2h
	mov dx, offset rcr1
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	jmp viskas
	
nercr0:
	mov cx, 2h
	mov dx, offset operandas2
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	cmp modd, 11000000b
	je viskas
	
	mov cx, 1h
	mov dx, offset pliusas
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	cmp rm, 00000001b
	je busdi
	cmp rm, 00000011b
	je busdi
	
	mov cx, 2h
	mov dx, offset siop
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	jmp viskas
	
busdi:	

	mov cx, 2h
	mov dx, offset diop
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
viskas:
	mov cx, 2h
	mov dx, offset endl
	mov ah, 40h                    ;RASYMAS I FAILA
	mov bx, out_fh
	int 21h
	
	xor cl, cl
	mov komanda, cl
	pop bx
	
	jmp nemano

printhex:

	push ax
	push bx
	push cx
	push dx
	mov cx, 2
ciklas:
    mov al, [bx]   ; al'e išsisaugau savo baitą
    push ax    ;issaugau simbolio kopija stack'e
pirmas_simbolis:
      shr al, 04h
      cmp al, 10  ; tikrinu ar 10
    jb skaicius
        ;raide
        add al, 37h    ;jeigu raide
        jmp antras_simbolis
    skaicius:
      add al, 30h
      mov [output + di], al
      inc di
antras_simbolis:
      pop ax
      and al, 0Fh   ; "izoliuoju" antra simboli
      cmp al, 10
    jb skaicius2
      add al, 37h   ;jeigu raide
      mov [output + di], al
      inc di
      mov dl, 32
      mov [output + di], dl
      inc di
      jmp pabaiga1
    skaicius2:       ;jeigu skaitmuo
      add al, 30h
      mov [output + di], al
      inc di
      mov dl, 32
      mov [output + di], dl
      inc di

pabaiga1:
inc bx

loop ciklas

    mov ah, 40h
    mov bx, out_fh
    mov cx, 2h
    mov dx, offset output
    int 21h
	
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret 
	
end start	
	
	
	
	
	
	
	
	
	
	