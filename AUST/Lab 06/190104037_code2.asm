;Lab 06 Code 2
.model small
.stack 100h
.data
   
msg1 db 'Input 1st capital letter: $'
msg2 db 0dh,0ah,'Input 2nd capital letter: $'
msg3 db 0dh,0ah,'Alphabetical Order of the characters: $'

.code  

main proc
    mov ax,@data    ;initializing data segment
    mov ds,ax                   
                   
    mov ah,9        ;show msg1 
    lea dx,msg1
    int 21h

    mov ah,1        ;Input 1st character
    int 21h
    mov bl,al       
     
    mov ah,9        ;show msg2
    lea dx,msg2
    int 21h
    
    mov ah,1        ;Input 2nd character
    int 21h 
    mov cl,al        
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,9        ;show msg3
    lea dx,msg3
    int 21h
    
    mov ah,2
    cmp bl,cl
    jnbe else_
    mov dl,bl       ;when bl<cl
    jmp display1
    
else_:              ;when bl => cl
    mov ah,2
    mov dl,cl
    jmp display2
    
display1:           ;when bl<cl
    int 21h
    mov dl,cl
    int 21h
    
    mov ah,4ch
    int 21h 
    
display2:           ;when bl => cl
    int 21h
    mov dl,bl
    int 21h
    
    mov ah,4ch
    int 21h 

end main  