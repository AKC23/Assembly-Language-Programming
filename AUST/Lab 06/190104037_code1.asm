;Lab 06 Code 1
.model small
.stack 100h
.data

msg1 db 0dh,0ah,'Input a hex digit character: $'
msg2 db 0dh,0ah,'Do you want to give input again? (Input Y/N): $'
msg3 db 0dh,0ah,'Decimal of this hex character: $'  
msg4 db 0dh,0ah,'Invalid input, try again $'
msg5 db 0dh,0ah,"Program terminated $"

.code

main proc
    mov ax,@data        ;initializing data segment
    mov ds,ax

again_input:
    mov ah,9            ;show msg1 
    lea dx,msg1
    int 21h
     
    mov ah,1            ;Input 1st character
    int 21h
    mov bl,al
    cmp bl,'F'          ;Compare input with F
    
    jg invalid_input
    cmp bl,'9'
    
    jle number_hexa     ;jump if less than or equal 9
    jg hexa_digit       ;jump if greater than 9
    
number_hexa:
    
    mov ah,9            ;show msg3
    lea dx,msg3         
    int 21h
     
    mov ah,2
    mov dl,bl
    int 21h
    jmp again_yes_no    ;jump to take input again
     
hexa_digit:
     
    lea dx,msg3         ;show msg3
    mov ah,9
    int 21h
    mov ah,2
    mov dl,31h          ;31h = 1 in hexa
    int 21h
    
    mov ah,2
    sub bl,11h          ;41h - 11h = 30h = 0d
    mov dl,bl
    int 21h
    
    jmp again_yes_no    ;jump to take input again
     
again_yes_no:
    
    mov ah,9
    lea dx,msg2         ;show msg2
    int 21h
    
    mov ah,1
    int 21h
    cmp al,'Y'  
    je again_input      ;jump to take input again
    cmp al,'N'
    je end              ;jump to end if input is N
    
    jmp again_yes_no:   ;jump if input is not y/n
     
invalid_input:
     
    mov ah,9
    lea dx,msg4         ;show msg4
    int 21h
    
    jmp again_input
     
end:                    
    mov ah,9            ;show msg5
    lea dx,msg5
    int 21h
    
exit:
    mov ah,4ch
    int 21h
    main endp
end main
    