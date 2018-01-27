assume cs:code,ds:data,ss:stack

data segment

  db 'w',2,'e',2,'l',2,'c',2,'o',2,'m',2,'e',2,' ',2,'t',2,'o',2
  db ' ',2,'m',2,'a',2,'s',2,'m',2,'!',2

  db 'w',24h,'e',24h,'l',24h,'c',24h,'o',24h,'m',24h,'e',24h,' ',24h,'t',24h
  db 'o',24h,' ',24h,'m',24h,'a',24h,'s',24h,'m',24h,'!',24h

  db 'w',71h,'e',71h,'l',71h,'c',71h,'o',71h,'m',71h,'e',71h,' ',71h,'t',71h
  db 'o',71h,' ',71h,'m',71h,'a',71h,'s',71h,'m',71h,'!',71h

data ends

stack segment

  dw 0,0,0,0

stack ends

code segment

start: mov ax,data
       mov ds,ax

       mov ax,0b800h
       mov es,ax

       mov bx,0
       mov cx,3

       mov ax,stack
       mov ss,ax
       mov sp,8

       ;11 row, 25 column
       mov bp,680h

outer: push cx
       mov cx,16

inner: mov ax,[bx]
       mov es:[bp],ax
       add bx,2
       add bp,2
       loop inner

       pop cx
       ;next row, 25 column
       add bp,128
       loop outer

       mov ax,4c00h
       int 21h

code ends

end start