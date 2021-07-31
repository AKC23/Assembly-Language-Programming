.model small
.stack 100h
.data

msg1 db 3
msg2 db ?  
msg3 db 'I love BD $'
    
.code

main proc                           
    
    ;initializing data segment(.data)
    mov ax,@data       
    mov ds,ax                 
    
    mov ah,2       ;for printing output
    add msg1,48
    mov dl,msg1
    int 21h
                   
    mov ah,1       ;for taking single key  input
    int 21h
    mov msg2,al    ;by default data is saved in al register
    
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,2 
    mov dl,msg2
    int 21h
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg3 
    int 21h
               
    exit:
    mov ah,4ch
    int 21h
    main endp
end main     


; 1-> single key input
; 2-> single character/integer output
; 9-> character string output