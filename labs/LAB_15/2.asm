assume cs:code, ss:stack

stack segment

    db 128 dup(0)

stack ends

code segment

        start: mov ax, stack
               mov ss, ax
               mov sp, 128
               
               push cs
               pop ds
               
               mov ax, 0
               mov es, ax
               
               mov si, offset int9
               mov di, 204h
               mov cx, offset int9_end - offset int9
               cld
               rep movsb
               
               ;save the origin int9 interrupt procedure address
               push es:[9 * 4]
               pop es:[200h]
               push es:[9 * 4 + 2]
               pop es:[202h]
               
               ;set the new int9 interrupt address
               cli
               mov word ptr es:[9 * 4], 204h
               mov word ptr es:[9 * 4 + 2], 0
               sti
               
               mov ax, 4c00h
               int 21h
               
         int9: push ax
               push bx
               push es
               push cx
               
               in al, 60h
               
               ;call the origin int9 interrupt procedure
               pushf
               call dword ptr cs:[200h]
               
               cmp al, 9eh
               jne int9_ok
               
               ;display 'A' all over the screen
               mov cx, 25 * 80
               mov ax, 0b800h
               mov es, ax
               mov bx, 0
               
            s: mov byte ptr es:[bx], 'A'
               inc bx
               mov byte ptr es:[bx], 7
               inc bx
               
               loop s
               
      int9_ok: pop cx
               pop es
               pop bx
               pop ax
               iret
               
     int9_end: nop

code ends
end start