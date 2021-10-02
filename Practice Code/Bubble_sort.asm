.MODEL SMALL
 .STACK 100H

 .DATA
    PROMPT_1  DB  ,'The contents of the array before sorting : $'
    PROMPT_2  DB  0DH,0AH,'The contents of the array after sorting : $\'

    ARRAY   DB  5,3,9,0,2,6,1,7,8,4   

 .CODE
   MAIN PROC
     MOV AX, @DATA               
     MOV DS, AX

     MOV BX, 10                   ; set BX=10

     LEA DX, PROMPT_1         
     MOV AH, 9
     INT 21H

     LEA SI, ARRAY               

     CALL ARRAY_PRINT             

     LEA SI, ARRAY                ; set SI=offset address of the ARRAY

     CALL BUBBLE_SORT             ; call the procedure BUBBLE_SORT

     LEA DX, PROMPT_2            
     MOV AH, 9
     INT 21H

     LEA SI, ARRAY                ; set SI=offset address of ARRAY

     CALL ARRAY_PRINT            

     MOV AH, 4CH                 
     INT 21H
   MAIN ENDP



 ARRAY_PRINT PROC
   ; this procedure will print the elements of a given array
   ; input : SI=offset address of the array
   ;       : BX=size of the array
   ; output : none

   PUSH AX                          
   PUSH CX                       
   PUSH DX                       

   MOV CX, BX                     

   PRINT_ARRAY:                  
     XOR AH, AH                  
     MOV AL, [SI]                

     CALL OUTPUT_DECIMAL                  

     MOV AH, 2                  
     MOV DL, 20H                  ; set DL=20H
     INT 21H                     

     INC SI                       ; set SI=SI+1
   LOOP PRINT_ARRAY              ; jump to label PRINT_ARRAY while CX!=0

   POP DX                        
   POP CX                        
   POP AX                       

   RET                           
 ARRAY_PRINT ENDP



 BUBBLE_SORT PROC
   ; this procedure will sort the array in ascending order
   ; input : SI=offset address of the array
   ;       : BX=array size
   ; output : none

   PUSH AX                        
   PUSH BX                       
   PUSH CX                      
   PUSH DX                        
   PUSH DI                       

   MOV AX, SI                     ; set AX=SI
   MOV CX, BX                     
   DEC CX                         

   OUTER_LOOP:                   ; loop label
     MOV BX, CX                   ; set BX=CX

     MOV SI, AX                   ; set SI=AX
     MOV DI, AX                   ; set DI=AX
     INC DI                       ; set DI=DI+1

     INNER_LOOP:                 
       MOV DL, [SI]               ; set DL=[SI]

       CMP DL, [DI]               ; compare DL with [DI]  DI contains next element of array
       JNG SWAP_VALUES         ; jump to label SWAP_VALUES if DL<[DI]

       XCHG DL, [DI]              ; set DL=[DI], [DI]=DL    Swapping values
       MOV [SI], DL               ; set [SI]=DL

       SWAP_VALUES:            ; jump label
       INC SI                     ; set SI=SI+1
       INC DI                     ; set DI=DI+1

       DEC BX                     ; set BX=BX-1
     JNZ INNER_LOOP              ; jump to label @INNER_LOOP if BX!=0
   LOOP OUTER_LOOP               ; jump to label @OUTER_LOOP while CX!=0

   POP DI                         ; pop a value from STACK into DI
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX
   POP AX                         ; pop a value from STACK into AX

   RET                            ; return control to the calling procedure
 BUBBLE_SORT ENDP



 OUTPUT_DECIMAL PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        
   PUSH CX                      
   PUSH DX                        

   XOR CX, CX                    
   MOV BX, 10                     ; set BX=10

   SHOW_OUTPUT:                       
     XOR DX, DX                  
     DIV BX                       ; divide AX by BX
     PUSH DX                      
     INC CX                       
     OR AX, AX                   
   JNE SHOW_OUTPUT                    ; jump to label SHOW_OUTPUT if ZF=0

   MOV AH, 2                      

   DISPLAY:                      
     POP DX                      
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      
   LOOP DISPLAY                  ; jump to label DISPLAY if CX!=0

   POP DX                         
   POP CX                         
   POP BX                         

   RET                            
 OUTPUT_DECIMAL ENDP





 END MAIN