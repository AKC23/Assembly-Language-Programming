.MODEL SMALL
.STACK 100H
.DATA

INPUTMSG DB 'Enter a digit  : $ '
  
WRONG DB 0AH,0DH,'WRONG INPUT $'   

SUMRESULT  DB  0DH,0AH,'The sum is : $'

SUM DB '?' 
   
PRIME_ARR DB 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 
   

.CODE

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX        
    
    
    MOV AH,9
    LEA DX,INPUTMSG
    INT 21H
    
    CALL DEC_IN

    
    CMP AX,0
    JNL SKIP
    NEG AX
    
    SKIP:
    MOV BX,AX 
    OR BX,30H
    
    
    MOV AH,2 
    MOV DX,BX
    INT 21H   
    
    LEA SI,PRIME_ARR   
    
    XOR CX,CX  
    SUB BX,30H
    MOV CX,BX  
    XOR BX,BX
    
    WHILE:
    ADD BL,[SI]
    INC SI
  
    LOOP WHILE
     
     
     END_WHILE:
     MOV [SI],'$'
     MOV AH,9
     LEA DX,SUMRESULT
     INT 21H
     MOV AX,BX
     CALL DEC_PRINT
          
    JMP ESC
    
    ERROR:
    MOV AH,9
    LEA DX,WRONG
    INT 21H
    

    
    ESC:
     
    MOV AH,4CH
    INT 21H                                                 
    MAIN ENDP     

 DEC_IN PROC
   
    PUSH BX
    PUSH CX
    PUSH DX
   
    START:

    XOR BX,BX
    XOR CX,CX
    MOV AH,1
    INT 21H 
    
    DECIMAL:
    
    CMP AL,'0'
    JNGE NOT_DIGIT
    CMP AL,'9'
    JNLE NOT_DIGIT 
    
    AND AX,000FH                  ;ASCII -> DECIMAL
    
    PUSH AX
    
    MOV AX,10
    MUL BX                        ;FOR  EXACT POSITION VALUE
    
    POP BX
    
    ADD BX,AX
    
    MOV AH,1
    INT 21H
    CMP AL,0DH

    JNE DECIMAL 
    
    
    CMP BX,10
    JG  ERROR
   
    MOV AX,BX
   
    EXIT:
   
    POP DX
    POP CX
    POP BX
    RET
    NOT_DIGIT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP START
    RET 
    
  DEC_IN ENDP    
 
 
 
 
 DEC_PRINT PROC
 

   PUSH BX                        
   PUSH CX                       
   PUSH DX                        

   XOR CX, CX                     
   MOV BX, 10                     ; BX = 10

   OUTPUT:                      
     XOR DX, DX                   
     DIV BX                       ;  AX \ BX
     PUSH DX                      
     INC CX                       
     OR AX, AX                    
   JNE OUTPUT                    ; IF ZF=0

   MOV AH, 2                      

   PRINT:                      
     POP DX                      
     OR DL, 30H                   ; CONVERT DECIMAL TO ASCII
     INT 21H                      
   LOOP PRINT                     ; IF CX!=0

   POP DX                         
   POP CX                         
   POP BX                         
                                  
   RET                            ; RETURN
                               
 DEC_PRINT ENDP




END MAIN