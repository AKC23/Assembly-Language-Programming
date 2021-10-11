                     
.model small
.stack 100h
.data
   msg1 db 'Input a hex digit character: $'
   msg2 db 'Decimal of this hex character: $'
   msg3 db 'Do you want to input again? (Print Y/N): $'
   msg4 db 'Program terminated '
   msg5 db 'Please try again '

.code  

main proc
    mov ax,@data    ;initializing data segment
    mov ds,ax
    
    mov ah,1
    int 21h
    cmp al,'Y'
    je then
    cmp al,'y'
    je then
    ;je terminate_
    jmp else_

then:
    mov ah,2
    mov dl,al
    int 21h
    jmp end_if

else_:
    mov ah,4ch
    int 21h

;terminate_:
;    mov ah,4ch
;    int 21h

end_if:
    
exit:
    mov ah,4ch
    int 21h
    main endp
end main      
    
    