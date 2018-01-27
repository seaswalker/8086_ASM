assume cs:code

a segment

  dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh

a ends

b segment

  dw 0,0,0,0,0,0,0,0

b ends

code segment

start:mov ax,a 
      mov ds,ax

      mov ax,b
      mov ss,ax
      mov sp,16

      push ds:[0]
      push ds:[2]
      push ds:[4]
      push ds:[6]
      push ds:[8]
      push ds:[10]
      push ds:[12]
      push ds:[14]

      mov ax,4c00h
      int 21h

code ends

end start
