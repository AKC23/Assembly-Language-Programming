.model small
.stack 100h
.data
 

box equ 10       ;10 balls      
green db 3
red db 2
white db ?

msg1 db 'Green $'
msg2 db ' balls $'
msg3 db 'Red $'
msg4 db ' balls $'
msg5 db 'White $'
msg6 db ' balls$'

    
.code

main proc 
    
    mov ax,@data
    mov ds,ax

    mov ah,9       ; 9-> character string output
    lea dx,msg1 
    int 21h        
    add green,48
    
    mov ah,2 
    mov dl,green
    int 21h
    
    mov ah,9 
    lea dx,msg2
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
    add red,48
    
    
    mov ah,2 
    mov dl,red
    int 21h
    
    
    mov ah,9 
    lea dx,msg4
    int 21h
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg5 
    int 21h
    
    mov ah,1
    int 21h
    mov white,al
    
    
    
    
exit:
    mov ah,4ch
    int 21h
    main endp
end main       