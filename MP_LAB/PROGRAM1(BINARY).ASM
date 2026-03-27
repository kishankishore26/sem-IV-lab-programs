data segment
arr db 06h,12h,15h,65h,70h,78h
len db $-arr
mid db ?
key db 70h
msg1 db 10,13,'key not found',10,13,'$'
msg2 db 10,13,'key found at position $'
data ends

code segment
assume cs:code,ds:data
start:mov ax,data
        mov ds,ax

        dec len
        mov dl,00h
        mov dh,len
        mov bx,0000
        mov cl,key

up:cmp dl,dh
        jg notfound
        mov bl,dl
        add bl,dh
        shr bl,01h
        mov mid,bl
        cmp cl,arr[bx]
        jz found
        jb firsthalf
        inc mid
        mov dl,mid
        jmp up

firsthalf:dec mid
        mov dh,mid
        jmp up

notfound:lea dx,msg1
        mov ah,09h
        int 21h
        jmp exit

found:lea dx,msg2
        mov ah,09h
        int 21h
        mov bl,mid
        call disphexa

exit:mov ah,4ch
        int 21h

disphexa proc near
        mov dl,bl
        mov cl,04h
        shr dl,cl
        cmp dl,09h
        jbe l1
        add dl,07h

l1:add dl,30h
        mov ah,02h
        int 21h
        mov dl,bl
        and dl,0fh
        cmp dl,09h
        jbe l2
        add dl,07h

l2:add dl,30h
        mov ah,02h
        int 21h

ret
disphexa endp
code ends
end start
