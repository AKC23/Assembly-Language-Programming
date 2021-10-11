.model small
.stack 100h
.data
 

B equ 5  ;B = 5  
C db 2   ;c = 2
A db ?
msg db 'The value of A is  $'
    
.code

main proc 
    
    mov ax,@data
    mov ds,ax
    
    mov al,70
    add al,B
    sub C,al        ;c = al
    
    mov bl,C
        
    
    mov ah,9       ; 9-> character string output
    lea dx,msg 
    int 21h
    

    sub bl,48
    mov A,bl        ;value saved in A
    
    
    mov ah,2 
    mov dl,A
    int 21h
     

exit:
    mov ah,4ch
    int 21h
    main endp
end main       