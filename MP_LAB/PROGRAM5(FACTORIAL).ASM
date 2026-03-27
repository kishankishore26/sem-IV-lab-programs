data segment
num db 06h
fact dw ?
msg db 0dh,0ah,'Factorial(06)=$'
data ends
code segment
assume cs:code,ds:data
start:mov ax,data
      mov ds,ax
      mov ah,09h
      lea dx,msg
      int 21h
      mov bl,num
      mov bh,00h
      mov ax,0001h
      call factorial
      mov fact,ax
      mov bl,ah
      call hexadisplay
      mov bx,fact
      call hexadisplay
      mov ah,4ch
      int 21h
      factorial proc Near
      cmp bl,01h
      je exit
      push bx
      dec bx
      call factorial
      pop bx
      mul bx
      exit:RET
      factorial endp
      hexadisplay proc Near
      mov dl,bl
      mov cl,04
      shr dl,cl
      cmp dl,09h
      jbe down
      add dl,07h
      down:add dl,30h
      mov ah,02h
      int 21h
      mov dl,bl
      and dl,0fh
      cmp dl,09h
      jbe down1
      add dl,07h
      down1:add dl,30h
      mov ah,02h
      int 21h
      RET
      hexadisplay endp
      code ends
      end start
