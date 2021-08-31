.MODEL SMALL
.STACK 100H
    
.DATA

MSG1 DB 0DH,0AH,'Enter a maximum 4 digits hex number: $'   ;(A-B OR 0-9):
BINARY DB 0DH,0AH,'Binary form : $'
WRONG DB 0DH,0AH,'Illegal input, please try again : $'
    
FLAG DB ?
     
.CODE

MAIN PROC
    
    MOV AX, @DATA   ;INITIALIZE DS
    MOV DS, AX
         
    MOV AH,9        ;PRINTING THE STRING
    LEA DX,MSG1             
    INT 21H
    
    JMP BEGIN                   
    
WRONG_INPUT:                  
    LEA DX, WRONG   ;PRINTING THE ILLEGAL STRING        
    MOV AH, 9
    INT 21H
    
BEGIN:                      
    XOR BX,BX       ;CLEARING BX
    MOV FLAG, 30H   ;COUNT=0
    
PROCEED:                  
    MOV AH,1                 
    INT 21H                    
    
    CMP AL,0DH      ;COMPARE WITH CARRIAGE RETURN
    JNE SKIP        ;JUMP IF  AL!=CR
    
    CMP FLAG, 30H   ;COMPARE COUNT 
    JBE WRONG_INPUT ;JUMP IF COUNT<=0
    JMP BINARY_PRINT                  
    
SKIP:                     
    CMP AL, "A"     ;COMPARE AL WITH "A"
    JB DECIMAL      ;if AL<65
    
    CMP AL, "F"     ;COMPARE AL WITH "F"
    JA WRONG_INPUT  ;IF AL>70
    ADD AL, 09H     ;IF 65<= AL <=70           
    JMP BINARY_START                    
    
DECIMAL:                  
    CMP AL, 30H              
    JB WRONG_INPUT  ;IF AL<0
    
    CMP AL, 39H              
    JA WRONG_INPUT  ;IF AL>9
    
BINARY_START:                       
    INC FLAG                  
    
    AND AL, 0FH     ;ASCII TO BINARY
    
    MOV CL, 4       ;CL=4
    SHL AL, CL      ;AL SHIFT LEFT 4 POSITIONS
    
    MOV CX, 4       ;CX=4
    
LOOP_1:                   
    SHL AL, 1       ;AL LEFT SHIFT
    RCL BX, 1       ;ROTATE THROUGH CARRY LEFT 1                                
    LOOP LOOP_1     ;UNTIL CX=0
          
    CMP FLAG, 34H              
    JE BINARY_PRINT                    
    JMP PROCEED              
    
BINARY_PRINT:                            
    LEA DX, BINARY             
    MOV AH, 9                    
    INT 21H
    
    MOV CX, 16      ;CX=16
    MOV AH, 2                   
                                                                        
PRINT:                     
    SHL BX, 1       ;BX LEFT SHIFT BY 1
    JC ONE          ;IF CF=1
    MOV DL, 30H     ;IF CF= 0, PRINT 0
    JMP DISPLAY              
    
ONE:                      
    MOV DL, 31H     ;DL=1                     
    
DISPLAY:                  
    INT 21H         
    LOOP PRINT      ;UNTIL CX=0
    
    
EXIT:
    MOV AH, 4CH                  
    INT 21H
    MAIN ENDP
END MAIN