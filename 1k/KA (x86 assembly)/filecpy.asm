.model small
.stack 100h

.data
    endl db 0Dh,0Ah, 24h
    src db "text.txt",0h
    dst db "textcpy.txt",0h

    in_fh dw 0000h
    out_fh dw 0000h
    
    buff db 256 dup(?)


.code

start:
    mov dx,@data
    mov ds,dx
    
    mov ax, 3d00h
    lea dx, src
    int 21h
    mov in_fh,ax

    mov ax, 3c00h
    xor cx,cx
    lea dx, dst
    int 21h
    mov out_fh,ax
    

    lea dx,buff
l:
    mov ax,3f00h
    mov bx,in_fh
    mov cx,0100h
    int 21h

    mov cx,ax
    mov ax,4000h
    mov bx,out_fh
    int 21h

    cmp ax,0
    jnz l

    mov ax,3e00h
    mov bx, out_fh
    int 21h

    mov ax,3e00h
    mov bx, in_fh
    int 21h

exit:
    mov dx, offset endl
    mov ah, 09h
    int 21h


    mov ah, 4ch
    mov al, 0
    int 21h

end start
