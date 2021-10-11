.model small
.model small
.stack 100h
.data

LETTER  db ?
PREVIOUS_LETTER db ? 
NEXT_LETTER db ?     

msg1 db 'The input letter is $'
msg2 db ' and the previous letter is $'
msg3 db ' and the next letter is is $'

.code
main proc 
    mov ax,@data       
    mov ds,ax 
    
    mov ah,1
    int 21h
    mov LETTER,al
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    
    mov ah,9       ; 9-> character string output
    lea dx,msg1 
    int 21h
    
    mov ah,2       ; 9-> character string output
    mov dl,LETTER 
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg2 
    int 21h
    
    mov ah,2       ; 9-> character string output
    sub LETTER,1
    mov dl,LETTER 
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg3 
    int 21h
    
    mov ah,2       ; 9-> character string output
    add LETTER,1
    add LETTER,1
    mov dl,LETTER 
    int 21h
    
    
exit:    
mov ah,4ch
int 21h
end main    