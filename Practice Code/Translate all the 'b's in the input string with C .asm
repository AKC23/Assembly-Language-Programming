;translate all the 'b's in the input string with C 

.MODEL SMALL
.STACK 100H

.DATA

STR db 80 dup ('$')
CNT dw 0
NEWL DB 010,013,"$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    mov ES,AX
    
    CALL READ_STR
    
    MOV AH,9
    LEA DX,NEWL
    INT 21H
    
    MOV AH,9
    LEA DX,STR
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

READ_STR PROC
    XOR CX,CX
    LEA SI,STR
    XOR BX,BX
    
    FOR:
    MOV AH,1
    INT 21H
    
    CMP AL,0DH
    JE EXIT
    
    MOV [SI],AL
    INC SI
    
    CMP AL,'b'
    JNE FOR
    
    DEC SI
    MOV [SI],'C'
    INC SI
    
    JMP FOR
    EXIT:
    
    RET
    
    READ_STR ENDP

END MAIN