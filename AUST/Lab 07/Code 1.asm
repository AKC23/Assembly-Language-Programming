.MODEL SMALL
.STACK 100H

.DATA

MSG1  DB  'Enter a character: $'
BINARY DB  0DH,0AH,'ASCII code in binary: $'
ONE_BIT DB  0DH,0AH,'The number of 1 bit in its ASCII code: $'

.CODE    

MAIN PROC
     
    MOV AX,@DATA        ;DATA SEGMENT INITIALIZE
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MSG1        ;PRINTING MSG1 MESSAGE    
    INT 21H
    
    MOV AH,1            ;TAKING USER INPUT        
    INT 21H

    XOR BX,BX           ;CLEARING BX
    MOV BL,AL                  
    
    MOV AH,9            ;PRINTING BINARY MESSAGE
    LEA DX,BINARY           
    INT 21H

    XOR BH,BH           ;CLEARING BH
    MOV CX,8            ;LOOP COUNTER, CX = 8        
   
   
    MOV AH,2
                      
BINARY_PRINT:
    SHL BL,1            ;LEFT SHIFT 1 BIT

    JNC ZERO            ;IF CF=0
    INC BH              ;COUNTING BIT '1' BY BH      
    MOV DL,31H          ;PRINT 1
    JMP PRINT              

ZERO:                     
    MOV DL, 30H         ;PRINT 0

PRINT:                  
    INT 21H             ;UNTIL CL=0
    LOOP BINARY_PRINT   ;LOOP WILL RUN FOR 8 TIMES              

    LEA DX,ONE_BIT      ;PRINTING THE STRING     
    MOV AH, 9
    INT 21H

    ADD BH,30H          ;ADD 30H WITH BL FOR DIGIT         

    MOV AH, 2                   
    MOV DL, BH
    INT 21H

EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN  