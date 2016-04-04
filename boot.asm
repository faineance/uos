bits 16
org 0x07C00
cli 

call clear



mov si, hello_world
call puts

call getc
call putc

hlt
halt: jmp halt

puts:   ; DS:SI -> string to print 
        lodsb   ; assume: DF = 0 
        test    al,al 
        jz      putc.ret 
        push    puts 
putc:   ; al -> char to print
        mov     ah,0eh 
        xor     bh,bh 
        int     10h ; int 29h ? (http://www.fysnet.net/undoc.htm)
  .ret: ret 

gets:
        call getc
        cmp al, 0x0D ;enter
        je getc.ret
        push gets
getc:
        xor ah, ah          
        int  0x16
        call putc           
  .ret: ret 

reboot:
  db 0x0ea
  dw 0x0000
  dw 0xffff

clear:
  mov ax,0003h
  int 10h 
  ret
; 10 -> new line ascii
; 13 -> carriage return
%define NEWLINE 13, 10

hello_world db NEWLINE, 'Hello World', NEWLINE, 0

; fill remaining with 0, add magic
TIMES 512-2 - ($ - $$) db 0
DW 0xAA55