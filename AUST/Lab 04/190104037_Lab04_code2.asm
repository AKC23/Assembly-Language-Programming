include 'emu8086.inc'
.model small
.stack 100h
.data
   msg1 db 'Input 1: $'
   msg2 db 'Input 2: $'
   msg3 db 'Sum is: $'
    
.code
main proc
    mov ax,@data
    mov ds,ax                   
                   
    mov ah,9
    lea dx,msg1
    int 21h

    mov ah,1
    int 21h
    mov bl,al   
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,9
    lea dx,msg2
    int 21h
    
    mov ah,1
    int 21h 
    mov cl,al    
    
    add bl,cl
    
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah,2
    sub bl,48
    mov dl,bl         
             
    mov al,58               ;initialize al = 10
    cmp al,dl               ;comparing 10 with the answer
                
    jle show                ;value is less than 10
        
        mov ah,9
        lea dx,msg3
        int 21h
        
        mov ah,2
        mov dl,bl
        int 21h
        
        mov ah,2
        mov dl,10
        int 21h
        mov dl,13
        int 21h
        
        printn 'This value is less than 10'
        mov ah,4ch
        int 21h        
                
        show:
            printn 'This value is not less than 10' 
            mov ah,4ch
            int 21h         
             
             
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    
    
    