clrscr macro
mov ah,00h
mov al,02h
int 10h
endm

setcursor macro  row,col
mov dl,col
mov dh,row
mov bh,00h
mov ah,02h
int 10h
endm

data segment
n db ?
msg1 db 10,13,'enter the character :$'
data ends

code segment
assume cs: code ,ds:data

start:
      mov ax,data
      mov ds,ax
      lea dx,msg1
      mov ah,09h
      int 21h
      mov ah,01h
      int 21h
      mov n,al 
      clrscr
      setcursor 12,40
      mov bl,n
      call disphexa
      mov ah,01h
      int 21h
      mov ah,4ch
      int 21h
      disphexa proc near
      mov dl,bl
      mov cl,04h
      shr dl,cl
      cmp dl,09h
      jbe l1
      add dl,07h
l1:
    add dl,30h
    mov ah,02h
    int 21h
    mov dl,bl
    and dl,0fh
    cmp dl,09h
    jbe l2
    add dl,07h
l2:
   add dl,30h
   mov ah,02h
   int 21h
   ret
disphexa endp
code ends
end start
