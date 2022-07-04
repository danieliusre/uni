;5 Parašykite programą, kuri įvestoje eilutėje visus tarpo simbolius pakeičia prieš juos esančiais simboliais
;(jei tarpas pradžioje – paliekamas tarpas). Pvz.: įvedus ab 12 oi8 turi atspausdinti abb122oi8
.model small
.stack 100h
.data
	zinute1 db "Iveskite simboliu eilute:$"
	zinute2 db 13, 10, "Ivesta eilute be tarpu:$"
	buff db 255, 0, 255 dup(?)
.code

start:
	mov dx, @data	; data registrai
	mov ds, dx

	mov ah, 09h
	mov dx, offset zinute1 ; spausdina 1 zinute
	int 21h

	mov ah, 0ah
	mov dx, offset buff 	; duomenu irasymas i buff
	int 21h

	mov bx, offset buff + 2
	xor cx, cx 		; cx nulinimas
	mov cl, [buff + 1] 	; ivesties ilgis (loopui)

	dec cl
	inc bx

ciklas:
	mov ah, [bx]
	cmp ah, ' '
	jne tinka

	mov ah, [bx - 1]
	mov [bx], ah

tinka:
	inc bx			; bx+=1 kad eitu per ivestus simbolius

	loop ciklas

	mov ah, 09h
	mov dx, offset zinute2 			; spausdina 2 zinute
	int 21h

	mov ah, 40h 				; 40h raso duomenis i ekrana
	mov bx, 1 				; rodo rasyt i ekrana
	xor cx, cx 				; cx nulinimas 
	mov cl, [buff + 1] 		; i cl registra kelia ivestos eilutes dydi
	mov dx, offset buff + 2 	; nurodo ka spaudinti
	int 21h

	mov ax, 4c00h	 ; iseina is programos
	int 21h

end start
