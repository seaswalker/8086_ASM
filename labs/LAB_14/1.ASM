;此代码只实现了对年份的展示功能，其它部分均是相同，不再重复
assume cs:code, ds:data, ss:stack

data segment

    db 12 dup(0)
    
data ends

stack segment

    dw 8 dup(0)
    
stack ends

code segment

    start: mov ax, data
           mov ds, ax
           mov si, 0
           
           mov ax, stack
           mov ss, ax
           mov sp, 16
           
           ;read year
           mov al, 9
           out 70h, al
           in al, 71h
           call split
           ;move year to ds:[si]
           mov ds:[si], ah
           inc si
           mov ds:[si], al
           inc si
           mov byte ptr ds:[si], '/'
           inc si
           
           ;call show_str sub procedure here
                      
           mov ax, 4c00h
           int 21h

           ;split the BCD code to two numbers
    split: push cx
      
           mov ah, al
           mov cl, 4
           shr ah, cl
           and al, 00001111b
           add ah, 30h
           add al, 30h
           
           pop cx
           ret

code ends
end start