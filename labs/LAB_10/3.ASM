assume cs:code,ss:stack

data segment

  db 10 dup (0)

data ends

stack segment

  dw 8 dup (0)

stack ends

code segment

       start: mov ax, 12666
              mov bx, data
              mov ds, bx
              mov si, 0
              mov bx, stack
              mov ss, bx
              mov sp, 16
        
              call dtoc
        
              mov dh, 8
              mov dl, 3
              mov cl, 2
        
              call show_str
        
              mov ax, 4c00h
              int 21h
        
        dtoc: push ax
              push bx
              push cx
              push dx
              push bp
              
              mov bx, 10
              
    div_loop: mov dx, 0
              div bx
              mov cx, dx
              
              jcxz div_ok
              
              add dl, 30h
              mov ds:[si], dl
              inc si
              jmp short div_loop
        
      div_ok: mov byte ptr ds:[si], 0  
          
              mov bx, si
              shr bx, 1
              
              ;we need to reverse the result, origin: 66621
     reverse: mov al, ds:[bx-1]
              mov bp, si
              sub bp, bx
              mov dl, ds:[bp]
              mov ds:[bx-1], dl
              mov ds:[bp], al
              dec bx
              mov cx, bx
              jcxz reverse_done
              jmp short reverse
        
reverse_done: mov si, 0
              pop bp
              pop dx
              pop cx
              pop bx
              pop ax
              ret
              
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
              jcxz show_str_ok
              mov es:[di], cl
              inc di
              mov es:[di], bl
              inc di
              inc si
              jmp short copy 
        
 show_str_ok: pop di
              pop bx
              pop es
              pop ax
              pop cx
              ret
 
code ends
end start