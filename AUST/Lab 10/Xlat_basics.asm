include 'emu8086.inc'
.model small
.stack 100h
.data 

table db 030h,031h,032h, 033h,034h,035h, 036h,037h,038h, 039h
      db 041h, 042h,043h, 044h, 045h, 046h

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov al,0Ch
    lea bx,table
    xlat          ;table + C = table + 12
    
    mov ah,2
    mov dl,al
    int 21h
        
    mov ah,4ch
    int 21h
    main endp
end main