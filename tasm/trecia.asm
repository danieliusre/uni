;Apdoroti MOV,OUT, NOT, RCR, XLAT

.model small
.stack 100h

.data
	;regout
	Isvedimo_buff db 100 dup (30h)
	count dw 0
	;Isvedimas
	failasout dw 0
	;Nuskaitymas
	failasin dw 0
	;
	duomenys db 100 dup (0h) 	;Duomenu failo pavad
	rezultatai db 100 dup (0h)	;Rezultatu failo pavad
	newEil db 0Dh, 0Ah
	space db 20h
	dvitaskis db 3ah, 20h
	kablelis db ',', 20h
	h db 'h'
	
	i dw 0		;loopui
	ip dw 0		;vieta kode
	buff db 110h dup (0h)	;bufferis i kuri skaito faila
	n dw 0h		;vieta bufferyje

	komandos db "mov out not rcr xlat "
	registrai db "alaxclcxdldxblbxahspchbpdhsibhdi"
	sr db "escsssds"
	rmai db "[bx+si] [bx+di] [bp+si] [bp+di] [si]    [di]    [bp]    [bx]    "
	rmaiposl db "[bx+si+[bx+di+[bp+si+[bp+di+[si  + [di  + [bp  + [bx  + "
	rcrbuff db "1 cl"
	opk db 0
	w db 0
	d db 0
	ab db 0
	modas db 0
	reg db 0
	rm db 0
	posl db 0
	posl2 dw 0
	
	help db "Iveskite parametrus", 0dh, 0ah, "Pirmasis parametras - Duomenu failo pavadinimas", 0dh, 0ah, "Antrasis parametras - Rezultatu failo pavadinimas", 24h
	neatpazinta db "Neatpazinta", 0dh, 0ah

.code



start:
	mov dx, @data
	mov ds, dx
	
	
	xor cx, cx
	mov cl, es:[80h]
	cmp cl, 0h
	je exit2
	dec cx
	mov si, 82h
	xor di, di
	xor dx, dx
Duomenys_nuskaitymas:
	mov dl, es:[si]
	inc si
	cmp dx, 20h
	je Rezultatu_nuskaitymass
	mov [duomenys+di], dl
	inc di
	loop Duomenys_nuskaitymas
						;tikrinam del /?
	cmp [duomenys], 2fh
	jne toliau59
	cmp [duomenys+1], 3fh
	jne toliau59
	lea dx, help
	mov ah, 09h
	int 21h
	jmp exit2
	toliau59:
Rezultatu_nuskaitymass:
	xor di, di
	dec cx
Rezultatu_nuskaitymas:
	mov dl, es:[si]
	inc si
	mov [rezultatai+di], dl
	inc di
	loop Rezultatu_nuskaitymas

						;atidaromas duomenu failas
	mov ah, 3dh
	xor al, al
	xor cx, cx
	mov dx, offset duomenys
	int 21h
	jc exit2
	mov failasin, ax
						;atidaromas rezultatu failas
	mov ah, 3ch
	xor cx, cx
	mov dx, offset rezultatai
	int 21h
	mov failasout, ax
	
Skaitom:
	mov cx, 100h
	mov dx, offset buff
	call Nuskaitymas
	mov n, 0h
	mov i, cx
	cmp cx, 0h
	je exit2
	
															jmp toliau6
															exit2:
															jmp exit1
															toliau6:
loopas:
	mov si, n
	mov al, [buff + si]
	inc n
	xor ah, ah
	call Tikrinimas
	
	cmp si, 1h
	jne toliau13
	call mov1
	toliau13:

	cmp si, 2h
	jne toliau27
	call mov2
	toliau27:
	
	cmp si, 3h
	jne toliau30
	call mov3
	toliau30:
	
	cmp si, 4h
	jne toliau31
	call mov4
	toliau31:
	
	cmp si, 5h
	jne toliau3
	call mov5
	toliau3:
		
	cmp si, 6h
	jne toliau32
	call mov6
	toliau32:
	
	cmp si, 7h
	jne toliau37
	call out1
	toliau37:
		
	cmp si, 8h
	jne toliau38
	call out2
	toliau38:
	
													jmp toliau4
													exit1:
													jmp exit
													loopas2:
													jmp loopas
													toliau4:

	cmp si, 9h
	jne toliau45
	call not1
	toliau45:
	
	cmp si, 0ah
	jne toliau56
	call rcr1
	toliau56:
	
	cmp si, 0bh
	jne toliau58
	call xlat1
	toliau58:
	
	cmp si, 0ffffh
	jne toliau46
	call neatpazintas
	toliau46:
	
	inc ip
	mov cx, i
	dec i
	loop loopas2
	jmp Skaitom
exit:
	
	mov ah, 3eh
	mov bx, failasout
	int 21h
	mov ax, 4c00h
	int 21h
	
	proc neatpazintas
		push ax
		push cx
		push dx
		push ax
		mov ax, ip
		call regoutip
		mov cx, 2h
		lea dx, dvitaskis
		call Isvedimas
		pop ax
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 0dh
		lea dx, neatpazinta
		call Isvedimas
		pop dx
		pop cx
		pop ax
		ret
	endp neatpazintas
	
	proc Isvedimas  	;paduoti cx, dx
		push ax
		push bx
		mov bx, failasout
		mov ah, 40h
		xor al, al
		int 21h
		pop bx
		pop ax
		ret
	endp Isvedimas

	proc Nuskaitymas		;paduoti cx, dx, pakeicia cx
		push ax
		push bx
		xor al, al
		mov ah, 3fh
		mov bx, failasin
		int 21h
		mov cx, ax
		pop bx
		pop ax
		ret
	endp Nuskaitymas
	
	proc Skaitymas			;i buff ideda naujus baitus resetina n ir i
		push cx
		push dx
		push si
		mov si, n
		cmp si, 100h
		jne toliau10
		mov cx, 100h
		mov dx, offset buff
		call Nuskaitymas
		mov n, 0h
		mov i, cx
		inc i
		;cmp cx, 0h
		;je exit2
		toliau10:
		pop si
		pop dx
		pop cx
		ret
	endp Skaitymas
	

	proc regout16		;paduoti ax
		push si
		push ax
		push cx
		push dx
		mov [Isvedimo_buff + 0], 30h
		mov [Isvedimo_buff + 1], 30h
		mov si, 1h
	back1:
		mov cx, 10h
		xor dx, dx
		div cx
		add dx, 30h
		mov [Isvedimo_buff + si], dl
		dec si
		cmp ax, 0h
		jne back1
		xor si, si
		mov cx, 2h
		loopas1:
		cmp [Isvedimo_buff + si], 39h
		jbe toliau1
		add [Isvedimo_buff + si], 7h
		toliau1:
		inc si
		loop loopas1
		mov dx, offset isvedimo_buff
		mov cx, 2h
		call Isvedimas
		pop dx
		pop cx
		pop ax
		pop si
		ret
	endp regout16
	
	proc regoutip
		push si
		push ax
		push cx
		push dx
		mov [Isvedimo_buff + 0], 30h
		mov [Isvedimo_buff + 1], 30h
		mov [Isvedimo_buff + 2], 30h
		mov [Isvedimo_buff + 3], 30h
		mov si, 3h
	back2:
		mov cx, 10h
		xor dx, dx
		div cx
		add dx, 30h
		mov [Isvedimo_buff + si], dl
		dec si
		cmp ax, 0h
		jne back2
		xor si, si
		mov cx, 4h
		loopas4:
		cmp [Isvedimo_buff + si], 39h
		jbe toliau5
		add [Isvedimo_buff + si], 7h
		toliau5:
		inc si
		loop loopas4
		mov dx, offset isvedimo_buff
		mov cx, 4h
		call Isvedimas
		pop dx
		pop cx
		pop ax
		pop si
		ret
	endp regoutip
	
	proc regout		;i al paduoti reg ir w. isveda registro pavad
		push ax
		push bx
		push cx
		push dx
		push si
		mov cx, 4h
		xor ah, ah
		mul cl
		add al, w
		add al, w
		mov si, ax
		mov cx, 2h
		lea dx, [registrai + si]
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp regout
	
	proc srout		;i al paduoti sr. isveda registro pavad
		push ax
		push bx
		push cx
		push dx
		push si
		mov cx, 2h
		xor ah, ah
		mul cl
		mov si, ax
		mov cx, 2h
		lea dx, [sr + si]
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp srout
	
	proc rmout		;i al paduoti rm. isveda rm pavad
		push ax
		push bx
		push cx
		push dx
		push si
		cmp rm, 110b
		jne toliau48
		mov cx, 1h
		lea dx, rmai
		call Isvedimas
		mov ax, posl2
		call regoutip
		lea dx, h
		call Isvedimas
		lea dx, [rmai+6]
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		toliau48:
		mov cx, 8h
		xor ah, ah
		mul cl
		mov si, ax
		mov cx, 8h
		lea dx, [rmai + si]
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp rmout
		
	proc rmoutposl
		push ax
		push bx
		push cx
		push dx
		push si
		mov cx, 7h
		xor ah, ah
		mul cl
		mov si, ax
		mov cx, 7h
		lea dx, [rmaiposl + si]
		call Isvedimas
		xor ax, ax
		mov al, posl
		call regout16
		lea dx, h
		mov cx, 1h
		call Isvedimas
		lea dx, [rmai + 6]
		mov cx, 1h
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp rmoutposl
		
	proc rmoutposl2
		push ax
		push bx
		push cx
		push dx
		push si
		mov cx, 7h
		xor ah, ah
		mul cl
		mov si, ax
		mov cx, 7h
		lea dx, [rmaiposl + si]
		call Isvedimas
		mov ax, posl2
		call regoutip
		lea dx, h
		mov cx, 1h
		call Isvedimas
		lea dx, [rmai + 6]
		mov cx, 1h
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp rmoutposl2
	
	proc modregrm	;tureti opk
		push ax
		push bx
		push cx
		push dx
		push si
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov ab, al
		xor ah, ah
		mov al, opk
		mov cx, 10b
		div cl
		mov w, ah
		xor ah, ah
		div cl
		mov d, ah
		xor ah, ah
		mov al, ab
		mov cx, 1000b
		div cl
		mov rm, ah
		xor ah, ah
		div cl
		mov reg, ah
		mov modas, al
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp modregrm
	
	
	proc Tikrinimas   ;paduoti ax, atiduoda si
		push bx
		push cx
		push dx
		mov si, 0ffffh
		mov bx, ax
		and al, 11110000b
		cmp al, 10110000b
		jne toliau7
		mov si, 5
		toliau7:
		mov ax, bx
		and al, 11111100b
		cmp al, 10001000b
		jne toliau12
		mov si, 1
		toliau12:
		mov ax, bx
		and al, 11111101b
		cmp al, 10001100b
		jne toliau26
		mov si, 2
		toliau26:
		mov ax, bx
		and al, 11111110b
		cmp al, 10100000b
		jne toliau28
		mov si, 3
		toliau28:
		mov ax, bx
		and al, 11111110b
		cmp al, 10100010b
		jne toliau29
		mov si, 4
		toliau29:
		mov ax, bx
		and al, 11111110b
		cmp al, 11000110b
		jne toliau33
		mov si, 6
		toliau33:
		mov ax, bx
		and al, 11111110b
		cmp al, 11100110b
		jne toliau35
		mov si, 7
		toliau35:
		mov ax, bx
		and al, 11111110b
		cmp al, 11101110b
		jne toliau36
		mov si, 8
		toliau36:
		mov ax, bx
		and al, 11111110b
		cmp al, 11110110b
		jne toliau44
		mov si, 9
		toliau44:
		mov ax, bx
		and al, 11111100b
		cmp al, 11010000b
		jne toliau54
		mov si, 10d
		toliau54:
		mov ax, bx
		cmp al, 11010111b
		jne toliau55
		mov si, 11d
		toliau55:
		mov ax, bx
		pop dx
		pop cx
		pop bx
		ret
	endp Tikrinimas
	
	proc mov1
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		call modregrm
		mov ax, ip
		dec ax
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		mov al, ab
		call regout16
		
		cmp modas, 011b				;mod 11
		jne toliau14
		mov cx, 01h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		cmp d, 0h
		jne toliau15
		mov al, rm
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call regout
		toliau15:
		cmp d, 1h
		jne toliau14
		mov al, reg
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call regout
		toliau14:
		
		cmp modas, 0b				;mod 00
		jne toliau16
		cmp rm, 110b
		jne toliau20
		call Skaitymas
		mov si, n
		mov bl, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bl
		call regout16
		call Skaitymas
		mov si, n
		mov bh, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bh
		call regout16
		mov posl2, bx
		toliau20:
		mov cx, 01h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
																											jmp toliau11
																											toliau16:
																											jmp toliau116
																											toliau11:
		cmp d, 0h
		jne toliau17
		mov al, rm
		call rmout
		toliau18:
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call regout
		toliau17:
		cmp d, 1h
		jne toliau16
		mov al, reg
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmout
		toliau116:
		
		cmp modas, 01b	;mod 01
		jne toliau19
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov posl, al
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		mov dx, offset komandos
		call Isvedimas
		cmp d, 0h
		jne toliau24
		mov al, rm
		call rmoutposl
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call regout
		toliau24:
		cmp d, 1h
		jne toliau19
		mov al, reg
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmoutposl
		
		toliau19:
		
		cmp modas, 10b	;mod 10
		jne toliau23
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
																				jmp toliau111
																				toliau23:
																				jmp toliau223
																				toliau111:
		mov cx, 4h
		mov dx, offset komandos
		call Isvedimas
		cmp d, 0h
		jne toliau25
		mov al, rm
		call rmoutposl2
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call regout
		toliau25:
		cmp d, 1h
		jne toliau223
		mov al, reg
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmoutposl2
		toliau223:
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp mov1
	
	proc mov2
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		call modregrm
		mov ax, ip
		dec ax
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		mov al, ab
		call regout16
		mov w, 1h
		
		cmp modas, 011b				;mod 11
		jne toliau14c
		mov cx, 01h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		cmp d, 0h
		jne toliau15c
		mov al, rm
		call regout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call srout
		toliau15c:
		cmp d, 1h
		jne toliau14c
		mov al, reg
		call srout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call regout
		toliau14c:
		
		cmp modas, 0b				;mod 00
		jne toliau16c
		cmp rm, 110b
		jne toliau20c
		call Skaitymas
		mov si, n
		mov bl, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bl
		call regout16
		call Skaitymas
		mov si, n
		mov bh, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bh
		call regout16
		mov posl2, bx
		toliau20c:
		mov cx, 01h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
																											jmp toliau11c
																											toliau16c:
																											jmp toliau116c
																											toliau11c:
		cmp d, 0h
		jne toliau17c
		mov al, rm
		call rmout
		toliau18c:
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call srout
		toliau17c:
		cmp d, 1h
		jne toliau16c
		mov al, reg
		call srout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmout
		toliau116c:
		
		cmp modas, 01b	;mod 01
		jne toliau19c
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov posl, al
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		mov dx, offset komandos
		call Isvedimas
		cmp d, 0h
		jne toliau24c
		mov al, rm
		call rmoutposl
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call srout
		toliau24c:
		cmp d, 1h
		jne toliau19c
		mov al, reg
		call srout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmoutposl
		
		toliau19c:
		
		cmp modas, 10b	;mod 10
		jne toliau23c
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
																				jmp toliau111c
																				toliau23c:
																				jmp toliau223c
																				toliau111c:
		mov cx, 4h
		mov dx, offset komandos
		call Isvedimas
		cmp d, 0h
		jne toliau25c
		mov al, rm
		call rmoutposl2
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, reg
		call srout
		toliau25c:
		cmp d, 1h
		jne toliau223c
		mov al, reg
		call srout
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, rm
		call rmoutposl2
		toliau223c:
		
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp mov2
	
	proc mov3
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		mov al, opk
		mov ah, 0h
		mov cx, 10b
		div cl
		mov w, ah
		xor ax, ax
		add al, w
		add al, w
		mov si, ax
		lea dx, [registrai + si]
		mov cx, 2h
		call Isvedimas
		lea dx, kablelis
		call Isvedimas
		mov cx, 1h
		lea dx, [rmai]
		call Isvedimas
		mov ax, posl2
		call regoutip
		mov cx, 1h
		lea dx, h
		call Isvedimas
		mov cx, 1h
		lea dx, [rmai+6]
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp mov3
		
	proc mov4
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		mov cx, 1h
		lea dx, [rmai]
		call Isvedimas
		mov ax, posl2
		call regoutip
		mov cx, 1h
		lea dx, h
		call Isvedimas
		mov cx, 1h
		lea dx, [rmai+6]
		call Isvedimas
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, opk
		mov ah, 0h
		mov cx, 10b
		div cl
		mov w, ah
		xor ax, ax
		add al, w
		add al, w
		mov si, ax
		lea dx, [registrai + si]
		mov cx, 2h
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp mov4
	
	proc mov5
		push ax
		push bx
		push cx
		push dx
		push si
		mov w, 0h
		mov bx, ax
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		mov ax, bx
		call regout16
		and ax, 00001000b
		cmp ax, 00001000b
		jne toliau8
		mov w, 1h
		toliau8:
		call Skaitymas
		mov si, n
		mov dl, [buff + si]
		inc n
		inc ip
		dec i
		xor dh, dh
		mov ax, dx
		call regout16
		cmp w, 1h
		jne toliau9
		call Skaitymas
		mov si, n
		mov dh, [buff + si]
		inc n
		inc ip
		dec i
		xor ah, ah
		mov al, dh
		call regout16
		toliau9:
		push dx
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		mov ax, bx
		xor dx, dx
		mov cx, 1000b
		div cx
		mov ax, dx
		mov cx, 4h
		mul cx
		add al, w
		add al, w
		mov si, ax
		lea dx, [registrai + si]
		mov cx, 2h
		call Isvedimas
		mov cx, 02h
		lea dx, kablelis
		call Isvedimas
		pop dx
		xor ax, ax
		cmp w, 0h
		je toliau2
		mov al, dh
		call regout16
		toliau2:
		mov al, dl
		call regout16
		mov cx, 1h
		lea dx, h
		call Isvedimas
		mov cx, 02h
		mov dx, offset newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		;dec cx
		;sub cl, w
		ret
	endp mov5

	proc mov6
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		call modregrm
		mov ax, ip
		dec ax
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		mov al, ab
		call regout16
		
		cmp modas, 00b
		jne toliau95
		cmp rm, 110b
		jne toliau95
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		toliau95:
		
		cmp modas, 01b	;mod 01
		jne toliau19b
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov posl, al
		call regout16		
		toliau19b:
		
		cmp modas, 10b	;mod 10
		jne toliau23b
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		toliau23b:
		
		call Skaitymas
		mov si, n
		mov bl, [buff + si]
		inc n
		inc ip
		dec i
		mov al, bl
		call regout16
		call Skaitymas
		cmp w, 1h
		jne toliau34
		mov si, n
		mov bh, [buff + si]
		inc n
		inc ip
		dec i
		mov al, bh
		call regout16
		toliau34:
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, komandos
		call Isvedimas
		
		mov al, rm
		cmp modas, 00b
		jne toliau99
		call rmout
		toliau99:
		cmp modas, 11b
		jne toliau98
		call regout
		toliau98:
		cmp modas, 01b
		jne toliau97
		call rmoutposl
		toliau97:
		cmp modas, 10b
		jne toliau96
		call rmoutposl2
		toliau96:
		
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov ax, bx
		call regoutip
		mov cx, 1h
		mov dx, offset h
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp mov6
	
	proc out1
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		mov posl, al
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+4]
		call Isvedimas
		mov al, posl
		call regout16
		mov cx, 1h
		lea dx, h
		call Isvedimas
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, opk
		mov ah, 0h
		mov cx, 10b
		div cl
		mov w, ah
		xor ax, ax
		add al, w
		add al, w
		mov si, ax
		lea dx, [registrai + si]
		mov cx, 2h
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp out1
	
	proc out2
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+4]
		call Isvedimas
		mov cx, 2h
		lea dx, [registrai + 10]
		call Isvedimas
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		mov al, opk
		mov ah, 0h
		mov cx, 10b
		div cl
		mov w, ah
		xor ax, ax
		add al, w
		add al, w
		mov si, ax
		lea dx, [registrai + si]
		mov cx, 2h
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp out2
	
	proc not1
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		call modregrm
		cmp reg, 010b
		je toliau39
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		toliau39:
		mov ax, ip
		dec ax
		call regoutip
		mov cx, 2h
		lea dx, dvitaskis
		call Isvedimas
		mov al, opk
		call regout16
		mov al, ab
		call regout16
		cmp modas, 11b	;mod 11
		jne toliau40
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+8]
		call Isvedimas
		mov al, rm
		call regout
		toliau40:
		cmp modas, 00b	;mod 00
		jne toliau41
		cmp rm, 110b
		jne toliau47
		call Skaitymas
		mov si, n
		mov bl, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bl
		call regout16
		call Skaitymas
		mov si, n
		mov bh, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bh
		call regout16
		mov posl2, bx
		toliau47:
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+8]
		call Isvedimas
		mov al, rm
		call rmout
		toliau41:
		cmp modas, 01b	;mod 01
		jne toliau42
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov posl, al
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		mov dx, offset [komandos+8]
		call Isvedimas
		mov al, rm
		call rmoutposl
		toliau42:
		cmp modas, 10b	;mod 10
		jne toliau43
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos + 8]
		call Isvedimas
		mov al, rm
		call rmoutposl2
		toliau43:
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp not1
	
	proc rcr1
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		call modregrm
		cmp reg, 011b
		je toliau49
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		toliau49:
		mov ax, ip
		dec ax
		call regoutip
		mov cx, 2h
		lea dx, dvitaskis
		call Isvedimas
		mov al, opk
		call regout16
		mov al, ab
		call regout16
		cmp modas, 11b	;mod 11
		jne toliau50
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+12]
		call Isvedimas
		mov al, rm
		call regout
		toliau50:
		cmp modas, 00b	;mod 00
		jne toliau51
		cmp rm, 110b
		jne toliau57
		call Skaitymas
		mov si, n
		mov bl, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bl
		call regout16
		call Skaitymas
		mov si, n
		mov bh, [buff+si]
		inc n
		inc ip
		dec i
		mov al, bh
		call regout16
		mov posl2, bx
		toliau57:
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+12]
		call Isvedimas
		mov al, rm
		call rmout
		toliau51:
		cmp modas, 01b	;mod 01
		jne toliau52
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		mov posl, al
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		mov dx, offset [komandos+12]
		call Isvedimas
		mov al, rm
		call rmoutposl
		toliau52:
		cmp modas, 10b	;mod 10
		jne toliau53
		call Skaitymas
		mov si, n
		mov al, [buff + si]
		inc n
		inc ip
		dec i
		call regout16
		call Skaitymas
		mov si, n
		mov ah, [buff + si]
		inc n
		inc ip
		dec i
		mov posl2, ax
		mov al, ah
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos + 12]
		call Isvedimas
		mov al, rm
		call rmoutposl2
		toliau53:
		mov cx, 2h
		lea dx, kablelis
		call Isvedimas
		xor ax, ax
		mov al, opk
		mov cx, 10b
		div cl
		xor ah, ah
		div cl
		mov al, ah
		xor ah, ah
		mul cl
		mov si, ax
		lea dx, [rcrbuff + si]
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp rcr1
	
	proc xlat1
		push ax
		push bx
		push cx
		push dx
		push si
		mov opk, al
		mov ax, ip
		call regoutip
		mov cx, 02h
		mov dx, offset dvitaskis
		call Isvedimas
		xor ax, ax
		mov al, opk
		call regout16
		mov cx, 1h
		lea dx, space
		call Isvedimas
		mov cx, 4h
		lea dx, [komandos+16]
		call Isvedimas
		mov cx, 2h
		lea dx, newEil
		call Isvedimas
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp xlat1
	
	end start
