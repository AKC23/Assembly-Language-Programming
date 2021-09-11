;div -> unsigned
;idiv -> signed
;div/idiv divisor

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
    
    mov ah,9
    lea dx,c
    int 21h
    
    mov ah, 1           ; input 1st number
    int 21h                               
    sub al,48
    mov a,al
    
    mov ah,9
    lea dx,d
    int 21h
    
    
    mov ah,1            ; input 2nd number
    int 21h
    sub al,48
    mov b,al
    
    
    mov ah,9
    lea dx,e
    int 21h
    
    
    mov al,a
    div b               ; al = a / b                             
    
    mov ah,2
    add al,48
    mov dl,al
    
    int 21h
                                  
exit:                   ; jump label
    
    mov ah,4ch
    int 21h  
   
   main endp
end main