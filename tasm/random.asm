.model small
.stack 100h
.data
	input db 40 dup(?)
.code
START:                           
   mov ax,seg input
   mov ds,ax
   mov dx,offset input
   mov di, dx 

   mov si, 82h
   mov cl,es:[80h]    


word1:   
      mov al,es:[si]
      mov ds:[di],al   
      inc si   
      inc di   

      cmp al,0Dh   ;out of arguments? (if YES goto finish)
      jz finish

      cmp al,20h   ;end of word? (if NO goto word)
      jnz word1

   mov al, '$'  ;line terminate
   mov ds:[di], al

   mov ah,09h      ;write string
   int 21h 

   xor di,di    ;prepare registry for new word

   call new_line


   loop word1

finish: 


   mov al, '$'
   mov ds:[di], al

   mov ah,09h      ;write last argument
   int 21h  


   mov ax,4ch   ;end program
   int 21h


new_line:
   push ax
   push bp
   mov ax,0e0ah ;ah=0e-write char,al=0a-go to new line
   int 10h
   mov al,13     ;carriage return
   int 10h 
   pop bp
   pop ax
ret
  	
	mov ax, 4c00h
	int 21h

end START