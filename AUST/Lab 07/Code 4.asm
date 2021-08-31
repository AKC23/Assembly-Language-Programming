.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'Enter a string of decimal digit: $'
RESULT DB 0DH,0AH,'Sum in hex: $'
WRONG_MSG DB 0DH,0AH,'Illegal input, try again : $'
         
.CODE
MAIN PROC

    
    MOV AX,@DATA     ;DATA SEGMENT INITIALIZE
    MOV DS,AX        ;CONVERTING DATA SEGMENT INTO CODE SEGMENT
      
    LEA DX,MSG1     ;PRINTING THE MSG1 STRING     
    MOV AH, 9
    INT 21H

    JMP BEGIN                  

WRONG:                   
    LEA DX, WRONG_MSG  
    MOV AH, 9
    INT 21H

    XOR BX, BX                   ; CLEARING BX
    XOR CX, CX                   ; CLEARING CX

BEGIN:                   
    MOV AH, 1
    INT 21H

    INC CX                     

    CMP AL, 0DH                ; COMPARE AL WITH CARRIAGE RETURN
    JNE NO_ENTER               ; IF AL!=CR

    CMP CX, 1                 
    JB WRONG                     ; IF CX<1
    JMP END_MSG1             

NO_ENTER:                  

    CMP AL, 30H                ; COMPARE AL WITH 0
    JB WRONG                     ; IF AL<0

    CMP AL, 39H                ; COMPARE AL WITH 1
    JA WRONG                     ; IF AL>9

    AND AL, 0FH                ; ASCII TO DECIMAL 
       
       
    XOR AH, AH                 ; CLEARING AH
    ADD BX, AX                 

    JMP BEGIN               

END_MSG1:                
     
;PRINTING THE RESULT STRING
    LEA DX, RESULT           
    MOV AH, 9
    INT 21H

    MOV CX, 4                    
    MOV AH, 2                    

LOOP_1:                    
      
    XOR DX, DX                 ; CLEARING DX

LOOP_2:                     
    SHL BX, 1                  ; BX SINGLE LEFT SHIFT
    RCL DL, 1                  ; DL ROTATE BY 1 THROUGH CARRY
    INC DH                  
    CMP DH, 4                  ; COMPARE DH WITH 4
    JNE  LOOP_2                ; IF DH!=4

    CMP DL, 9                  ; COMPARE DL WITH 9
    JBE NUMBER               ; IF DL<=9
    SUB DL, 9                  ; CONVERT TO NUMBER
    OR DL, 40H                 ; CONVERT NUMBER TO LETTER
    JMP DISPLAY               
                                   
NUMBER:            
    OR DL, 30H                 ; CONVERTING DECIMAL TO ASCII

DISPLAY:                 
    INT 21H                 
    LOOP LOOP_1                ; UNTIL  CX=0

EXIT:     
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN 