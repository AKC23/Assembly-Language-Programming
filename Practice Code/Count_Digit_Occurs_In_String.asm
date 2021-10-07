;count digit occurs in STRing

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
    mov es,ax
    
    CALL READ_STR
    
    MOV AH,9
    LEA DX,NEWL
    INT 21H
    
    MOV AX,CX
    CALL OUTDEC
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

READ_STR PROC
    XOR CX,CX
    LEA SI,STR
    
    FOR:
    MOV AH,1
    INT 21H
    
    CMP AL,0DH
    JE EXIT
    
    MOV [SI],AL
    INC SI
    
    CMP AL,'0'
    JB FOR
    
    CMP AL,'9'
    JA FOR
    
    INC CX
    
    JMP FOR
    EXIT:
    
    RET
    
    READ_STR ENDP
    
    
OUTDEC PROC ;WILL OUTPUT AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX,CX
    MOV BX,10
    
    OUTPUT:
    XOR DX,DX
    DIV BX
    PUSH DX
    INC CX
    OR AX,AX
    JNE OUTPUT
    
    MOV AH,2
    
    DISPLAY:
    POP DX
    OR DL,30H
    INT 21H
    LOOP DISPLAY
    
    POP DX
    POP CX
    POP BX
    
    RET
    
    OUTDEC ENDP

END MAIN