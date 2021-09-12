;code 2   

.model small
.stack 100h

.data
  
msg1 db 'Value of m = $'
msg2 db 0dh,0ah,'Value of n = $'
msg3 db 0dh,0ah,'The GCD of m and n = $'
 
.code

main proc
    mov ax, @data               
    mov ds, ax

    lea dx, msg1             
    mov ah, 9
    int 21h

    call indecimal                   ; call the procedure indecimal

    push ax                      ; push ax onto the stack

    lea dx, msg2             ; load and display the string msg2
    mov ah, 9
    int 21h

    call indecimal           

    mov bx, ax                   ; set bx=ax

    pop ax                       ; pop a value from stack into ax
     
@repeat:                     ; repeat untill dx = 0
    xor dx, dx                 ; clear dx
    div bx                     ; set ax=dx:ax\bx ,  ax=dx:ax%bx

    cmp dx, 0                  ; compare dx with 0
    je @end_loop               ; jump to label @end_loop if dx=0
                               
                             ; exchange M(AX) and N(BX), N(BX) and R(DX)
    mov ax, bx                 ; set ax=bx
    mov bx, dx                 ; set bx=dx
    jmp @repeat                    ; jump to label @repeat 

@end_loop:                   ; jump label

    lea dx, msg3             ; load and display the string msg3
    mov ah, 9
    int 21h

    mov ax, bx                   ; set ax=bx

    call outdecimal                  ; call the procedure outdecimal

    mov ah, 4ch                  ; return control to dos
    int 21h

main endp


indecimal proc
    
   ; this procedure will read a number in decimal form    
   ; input : none
   ; output : store binary number in ax
   ; uses : main

    push bx                        ; push bx onto the stack
    push cx                        ; push cx onto the stack
    push dx                        ; push dx onto the stack

    jmp @read                      ; jump to label @read

@skip_backspace:               
    mov ah, 2                      ; set output function
    mov dl, 20h                    ; set dl=' '
    int 21h                        ; print a character

@read:                         
    xor bx, bx                     ; clear bx
    xor cx, cx                     ; clear cx
    xor dx, dx                     ; clear dx

    mov ah, 1                      ; set input function
    int 21h                        ; read a character

    jmp @skip_input                ; jump to label @skip_input


@input:                        ; jump label
    mov ah, 1                    ; set input function
    int 21h                      ; read a character

@skip_input:                 ; jump label

    cmp al, 0dh                  ; compare al with cr
    je @end_input                ; jump to label @end_input

    cmp al, 8h                   ; compare al with 8h
    jne @not_backspace           ; jump to label @not_backspace if al!=8

    cmp cl, 0                    ; compare cl with 0
    je @skip_backspace           ; jump to label @skip_backspace if cl=0
    jmp @move_back               ; jump to label @move_back

                                  
@move_back:                  ; jump label

    mov ax, bx                   ; set ax=bx
    mov bx, 10                   ; set bx=10
    div bx                       ; set ax=ax/bx

    mov bx, ax                   ; set bx=ax

    mov ah, 2                    ; set output function
    mov dl, 20h                  ; set dl=' '
    int 21h                      ; print a character

    mov dl, 8h                   ; set dl=8h
    int 21h                      ; print a character

    xor dx, dx                   ; clear dx
    dec cl                       ; set cl=cl-1

    jmp @input                   ; jump to label @input

@not_backspace:              ; jump label

    inc cl                       ; set cl=cl+1

    cmp al, 30h                  ; compare al with 0
    jl @error                    ; jump to label @error if al<0

    cmp al, 39h                  ; compare al with 9
    jg @error                    ; jump to label @error if al>9

    and ax, 000fh                ; convert ascii to decimal code

    push ax                      ; push ax onto the stack

    mov ax, 10                   ; set ax=10
    mul bx                       ; set ax=ax*bx
    mov bx, ax                   ; set bx=ax

    pop ax                       ; pop a value from stack into ax

    add bx, ax                   ; set bx=ax+bx
    js @error                    ; jump to label @error if sf=1
    jmp @input                     ; jump to label @input

@error:                        ; jump label

    mov ah, 2                      ; set output function
    mov dl, 7h                     ; set dl=7h
    int 21h                        ; print a character

@clear:                        ; jump label
    mov dl, 8h                   ; set dl=8h
    int 21h                      ; print a character

    mov dl, 20h                  ; set dl=' '
    int 21h                      ; print a character

    mov dl, 8h                   ; set dl=8h
    int 21h                      ; print a character
    loop @clear                    ; jump to label @clear if cx!=0

    jmp @read                      ; jump to label @read

@end_input:                    ; jump label

    cmp ch, 1                      ; compare ch with 1   
    jne @exit                      ; jump to label @exit if ch!=1
    neg bx                         ; negate bx

@exit:                         ; jump label

    mov ax, bx                     ; set ax=bx

    pop dx                         ; pop a value from stack into dx
    pop cx                         ; pop a value from stack into cx
    pop bx                         ; pop a value from stack into bx

    ret                            ; return control to the calling procedure
 
indecimal endp
                                  

outdecimal proc
    
   ; this procedure will display a decimal number
   ; input : ax
   ; output : none
   ; uses : main

    push bx                        ; push bx onto the stack
    push cx                        ; push cx onto the stack
    push dx                        ; push dx onto the stack

    cmp ax, 0                      ; compare ax with 0
    jge @start                     ; jump to label @start if ax>=0

    push ax                        ; push ax onto the stack

    mov ah, 2                      ; set output function
    mov dl, "-"                    ; set dl='-'
    int 21h                        ; print the character

    pop ax                         ; pop a value from stack into ax

    neg ax                         ; take 2's complement of ax

@start:                             ; jump label

    xor cx, cx                     ; clear cx
    mov bx, 10                     ; set bx=10

@output:                            ; loop label
    xor dx, dx                   ; clear dx
    div bx                       ; divide ax by bx
    push dx                      ; push dx onto the stack
    inc cx                       ; increment cx
    or ax, ax                    ; take or of ax with ax
    jne @output                    ; jump to label @output if zf=0

    mov ah, 2                      ; set output function

@display:                      ; loop label
    pop dx                       ; pop a value from stack to dx
    or dl, 30h                   ; convert decimal to ascii code
    int 21h                      ; print a character
    loop @display                  ; jump to label @display if cx!=0

    pop dx                         ; pop a value from stack into dx
    pop cx                         ; pop a value from stack into cx
    pop bx                         ; pop a value from stack into bx

    ret                            ; return control to the calling procedure

outdecimal endp


end main
                         
                         