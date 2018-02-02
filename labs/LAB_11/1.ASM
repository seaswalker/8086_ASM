assume cs:code

data segment

  db "Beginner's All-purpose Symbolic Instruction Code.",0

data ends

stack segment

  dw 5 dup (0)

stack ends

code segment

  begin: mov ax, data
         mov ds, ax
         mov si, 0

         mov ax, stack
         mov ss, ax
         mov sp, 10

         call letterc

         mov ax, 4c00h
         int 21h

letterc: push cx 
         mov ch, 0

 repeat: mov cl, ds:[si]
         jcxz ok

         cmp cl, 'a'
         jb skip

         cmp cl, 'z'
         ja skip

         and cl, 11011111b
         mov ds:[si], cl

   skip: inc si
         jmp short repeat

     ok: mov si, 0
         pop cx

         ret

code ends
end begin