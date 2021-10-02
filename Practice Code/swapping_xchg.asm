.model small
.stack 100H
.data

msg1 db 10,13,'Input bl,bh,cl: $'
msg2 db 10,13,'After reverse output of cl,bh,bl,: $'
msg3 db 10,13,'Output of bl and cl after exchange: $'

.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9       ; 9-> character string input
    lea dx,msg1 
    int 21h
    
    ;Input bl,bh,cl
    mov ah,1
    int 21h
    mov bl,al
    int 21h
    mov bh,al
    int 21h
    mov cl,al
    
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    
    mov ah,9       ; 9-> character string input
    lea dx,msg2 
    int 21h
    
    
    ;reverse print
    mov ah,2
    mov dl,cl
    int 21h
    mov ah,2
    mov dl,bh
    int 21h
    mov ah,2
    mov dl,bl
    int 21h
    
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,9       ; 9-> character string input
    lea dx,msg3 
    int 21h
    
    
    ;exchange cl and bl
    xchg cl,bl
    
    ;cl -> prevoius bl, bl -> previous cl
    mov ah,2
    mov dl,cl
    int 21h
    mov dl,bl
    int 21h
    

    exit:
    mov ah,4ch
    int 21h
    main endp
end main     
    