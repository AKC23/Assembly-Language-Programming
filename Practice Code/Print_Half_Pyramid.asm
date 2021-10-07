;Print a pattern
;Z
;X  V
;T  R P
;N  L J H


.MODEL SMALL
.STACK 100H

.DATA

str db 80 dup ('$')
cnt DB 0
;TOT DB 0
NEWL DB 010,013,"$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    mov es,ax
    
    MOV BL,'Z'
    MOV CNT,0
    
    XOR CL,CL
    
    FOR1:
    MOV CNT,0
    ;INC TOT
    INC CL
    
    FOR2:
    MOV AH,2
    MOV DL,BL
    INT 21H
    MOV AH,2
    MOV DL,' '
    INT 21H
    INC CNT
    SUB BL,2
    CMP CNT,CL
    JNE FOR2
    
    MOV AH,9
    LEA DX,NEWL
    INT 21H
    
    CMP CL,4
    JNE FOR1
    
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

END MAIN