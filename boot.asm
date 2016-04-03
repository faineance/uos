bits 16
org 0x07C00
cli

; clear screen
mov ax,0003h
int 10h 

mov si, hello_world
call puts

hlt


puts:   ; DS:SI -> string to print 
        lodsb   ; assume: DF = 0 
        test    al,al 
        jz      putc.ret 
        push    puts 
putc:   ; al -> char to print
        mov     ah,0eh 
        xor     bh,bh 
        int     10h 
  .ret: ret 

hello_world   db 'Hello World', 0

; ; fill remaining with 0, add magic
TIMES 512-2 - ($ - $$) db 0
DW 0xAA55