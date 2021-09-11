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
    sub al,30h
    mov a,al
    
    mov ah,9
    lea dx,d
    int 21h
    
    
    mov ah,1            ; input 2nd number
    int 21h
    sub al,30h
    mov b,al
    
    
    mov ah,9
    lea dx,e
    int 21h
    
    
    mov al,a
    mul b               ; ax = a*b                             
    
    
    mov dl,al
    add dl,30h
    
    mov ah,2
    int 21h
                                  
exit:                   ; jump label
    
    mov ah,4ch
    int 21h  
   
   main endp
end main