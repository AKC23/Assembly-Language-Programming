.model small
.stack 100h
.data

a db 10,13,'Hex digit: $'
b db 10,13,'Decimal digit: $'
    
.code

main proc 
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,a
    int 21h
    
    mov ah,1
    int 21h
    mov bl,al
    sub bl,17     ;C = 67, 67-17 = 50(2)
    
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,9
    lea dx,b
    int 21h
    
    
    mov ah,2
    mov dl,49      ;ASCII 049 = '1' in decimal
    int 21h
    
    mov ah,2
    mov dl,bl
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main   