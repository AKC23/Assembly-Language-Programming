.model small
.model small
.stack 100h
.data

t equ 10 ;total money = 10 tk
A db 3  ;A = 3  
X db ?  ;X for Book B
Y db ?  ;Y for Book C
D db 5  ;D = 5 tk for chocolate
E db 8  ;E = A + D
msg  db 'Extra money needed: $'
msg2 db ' tk $'

.code

main proc 
    mov ax,@data       
    mov ds,ax 
    
    
    ;input for X
    mov ah,1
    int 21h
    mov X,al     ;initialize X
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    ;input for X
    mov ah,1
    int 21h
    mov Y,al     ;initialize Y
    
    mov bl,X
    mov cl,Y
    add cl,bl    ;cl = X + Y
    
    ;for a new line(Line feed and carriage return)
    mov ah,2
    mov dl,10      ;line feed
    int 21h
    mov dl,13      ;carriage return
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg 
    int 21h
    
    mov ah,2
    mov bl,E       ;bl = E = A+D = 8
    add bl,cl      ;bl = bl - cl(X + Y)
    sub bl,t       ;bl = bl - total money(10)
    sub bl,48      ;bl = bl + 48
    mov dl,bl
    int 21h
    
    mov ah,9       ; 9-> character string output
    lea dx,msg2 
    int 21h
    
exit:    
mov ah,4ch
int 21h
end main    