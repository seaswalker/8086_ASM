assume cs:code

code segment

              start: mov ax, cs
                     mov ds, ax
                     mov si, offset loop_function
                     
                     mov ax, 0
                     mov es, ax
                     mov di, 200h
                     
                     mov cx, offset loop_function_end - offset loop_function
                     
                     cld
                     rep movsb
               
                     ;set the interrupt table, number 0x7ch
                     mov word ptr es:[496], 200h
                     mov word ptr es:[498], 0
                     
                     mov ax, 4c00h
                     int 21h
                    
      loop_function: push bp
                     mov bp, sp
                     dec cx
                     jcxz ok
                     add [bp + 2], bx
                     
                 ok: pop bp
                     iret
            
  loop_function_end: nop

code ends
end start