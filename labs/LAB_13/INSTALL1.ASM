assume cs:code

code segment

         start: mov ax, cs
                mov ds, ax
                mov si, offset show_str
                
                mov ax, 0
                mov es, ax
                mov di, 200h
                
                mov cx, offset show_str_end - offset show_str
                
                cld
                rep movsb

                ;set the interrupt table, number 0x7ch
                mov word ptr es:[496], 200h
                mov word ptr es:[498], 0
                
                mov ax, 4c00h
                int 21h
                    
      show_str: push cx
                push ax
                push es
                push bx
                push di
                
                mov ax, 0b800h
                mov es, ax
                
                ;address = (dh - 1) * 160 + dl * 2 - 2
                mov al, dh
                mov bl, 160
                mul bl
                
                mov bl, dl
                add bl, bl
                sub bl, 2
                mov bh, 0
                add ax, bx
                mov di, ax
                
                mov bl, cl
                
          copy: mov cl, ds:[si]
                jcxz ok
                mov es:[di], cl
                inc di
                mov es:[di], bl
                inc di
                inc si
                jmp short copy 
                
            ok: pop di
                pop bx
                pop es
                pop ax
                pop cx
                iret
            
  show_str_end: nop

code ends
end start