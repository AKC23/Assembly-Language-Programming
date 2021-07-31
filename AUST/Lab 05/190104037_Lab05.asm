.model small
.stack 100h
.data 
.code  

main proc
    
    ;1.1
    MOV AX,7FFFH
    MOV BX, 0001H
    ADD AX,BX 
    
    ;1.2
    MOV AX,00H
    DEC AL
    
    ;1.3
    mov al,7FH
    NEG AL
    
    ;1.4
    mov ax,1abh
    mov bx,712ah
    xchg ax,bx
    
    
EXIT:    
MOV AH,4CH
INT 21H
END MAIN