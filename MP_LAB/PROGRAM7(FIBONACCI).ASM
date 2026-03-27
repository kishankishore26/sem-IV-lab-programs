data segment
f1 db 00h
f2 db 01h
f3 db ?
n db 10
msg db 'The fibonacci series is : ',10,13,'$'
data ends

code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea dx,msg
mov ah,09h
int 21h
mov bl,f1
call disphexa
mov dl,' '
mov ah,02h
int 21h
mov bl,f2
call disphexa
mov dl,' '
mov ah,02h
int 21h
mov cl,00
sub n,02h
up:
cmp cl,n
jz exit
mov al,f1
add al,f2
mov f3,al
mov bl,f3
call disphexa
mov dl,' '
mov ah,02h
int 21h
mov al,f2
mov f1,al
mov al,f3
mov f2,al
inc cl
jmp up

exit:
mov ah,4ch
int 21h

disphexa proc
push cx
mov dl,bl
mov cl,04
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
pop cx
ret

disphexa endp
code ends
end start
