assume cs:code

data segment

  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
  
  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800

data ends

table segment 
  
  db 21 dup ('year summ ne ?? ')

table ends

stack segment

   dw 8 dup (0)

stack ends 

code segment

start: mov ax,data
       mov ds,ax

       mov bx,0
       mov si,84
       mov di,168

       mov ax,table
       mov es,ax
       mov bp,0

       mov ax,stack
       mov ss,ax
       mov sp,16

       mov cx,21

     s:mov ax,[bx]
       mov es:[bp],ax
       add bx,2
       add bp,2
       mov ax,[bx]
       mov es:[bp],ax
       add bx,2
       add bp,3

       mov byte ptr es:[bp-1],' '
  
       ;now, copy the salary
       mov ax,ds:[si]
       mov es:[bp],ax
       add si,2
       add bp,2
       mov ax,ds:[si]
       mov es:[bp],ax
       add si,2
       add bp,3
       mov byte ptr es:[bp-1],' '

       ;now, copy the numner of employee
       mov ax,ds:[di]
       mov es:[bp],ax
       add di,2
       add bp,3
       mov byte ptr es:[bp-1],' '

       ;calculate the average salary
       mov dx,ds:[si-2]
       mov ax,ds:[si-4]
       push si
       mov si,ds:[di-2]
       div si
       pop si
       mov es:[bp],ax
       add bp,3
       mov byte ptr es:[bp-1],' '

       loop s

       mov ax,4c00h
       int 21h

code ends

end start

 

