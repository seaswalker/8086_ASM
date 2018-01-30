assume cs:code

data segment

  db 'Welcome to masm!',0

data ends

code segment

start:    mov dh, 8
          mov dl, 3
          mov cl, 2
          mov ax, data
          mov ds, ax
          mov si, 0
          call show_str

          mov ax, 4c00h
          int 21h

show_str: push cx
          push ax
          push es
          push bx
          push di

          mov ax, 0b800h
          mov es, ax
          
          ;address = (dh - 1) * 160 + dl * 2
          mov al, dh
          mov bl, 160
          mul bl

          mov bl, dl
          add bl, bl
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
          ret

code ends
end start
