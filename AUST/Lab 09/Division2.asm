;div -> unsigned
;idiv -> signed


.model small
.stack 100h

.data  

.code

main proc
    mov ax, @data       ; initialize ds
    mov ds, ax    
    
    ;1st part
    mov ax, 0080h
    mov bl, 2h
    
    div bl
          
    mov ah, 2
    add ax, 30h      
    mov dx, ax
    int 21h
    
    ;2nd part
    mov dx,0h
    
    mov ax, 0083h
    mov bx, 2
    
    div bx
          
    mov ah, 2
    ;add ax, 30h      
    mov dx, ax
    int 21h
    
                                 
end main