;mul -> unsigned
;imul -> signed


.model small
.stack 100h

.data  

a db ?
b db ?
c db 10,13,'Input 1st number: $'
d db 10,13,'Input 2nd number: $'
e db 10,13,'Result $'

.code

main proc
    mov ax, @data       ; initialize ds
    mov ds, ax    
    
    mov al, 3h
    mov bl, 2h
    
    mul bl
          
    mov ah,2
    add ax, 30h      
    mov dx,ax
    int 21h
    
    
    mov ax, 2000h
    mov bx, 100h
    
    mul bx
          
    mov ah,2
    add ax, 30h      
    mov dx,ax
    int 21h
    
                                 
end main