include 'emu8086.inc'
.model small
.stack 100h
.data

msg db 'Elements of array: $' 
numb db 1,2,3,4,5,6,7,8,9,10
numb2 dw 65,66,67,68,69

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx, msg
    int 21h
    
    lea si,numb  
    ;lea si,numb2
                              ;for numb cx = 10, for numb2 cx = 5
    mov cx,10    
    mov ah,2
    
    for:
       mov dl,[si] 
       ;add dl,30h            ;use for numb array
       int 21h
       inc si
       ;add si,1              ;use for numb array cause it's byte(add 1)
                              
       ;add si,2               ;use for numb2 array cause it's word(add 2)
        
       loop for
        
    mov ah,4ch
    int 21h
    main endp
end main