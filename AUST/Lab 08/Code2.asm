.model small
.stack 100h

.data

prompt              db "Enter an algebraic expression : $"
correct_msg         db 0dh,0ah,"Expression is correct. $"
left_bracket_error  db 0dh,0ah,"too many left brackets $"
right_bracket_error db 0dh,0ah,"too many right brackets $"
mismatch_msg        db 0dh,0ah,"bracket mismatch. Try again. $"
continue_msg            db 0dh,0ah,"Type Y if you want to continue: $"
exit_msg            db 0dh,0ah,"Program terminated. $"
              
.code

main proc
    mov ax, @data       ; initialize ds
    mov ds, ax

start:                 ; jump label   
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov ah, 9
    lea dx, prompt      ; load and print the string prompt
    int 21h

    xor cx, cx          ; clear cx

    mov ah, 1           ; set input function

take_input:                 ; jump label
    int 21h             ; read a character

    cmp al, 0dh         ; compare al with cr
    je end_input       ; jump to label end_input if al=cr

    cmp al, "["         ; compare al with "["
    je push_bracket    ; jump to label push_bracket if al="["

    cmp al, "{"         ; compare al with "{"
    je push_bracket    ; jump to label push_bracket if al="{"

    cmp al, "("         ; compare al with "("
    je push_bracket    ; jump to label push_bracket if al="("

    cmp al, ")"         ; compare al with ")"
    je round_bracket   ; jump to label round_bracket if al=")"
                                   
    cmp al, "}"         ; compare al with "}"
    je curly_bracket   ; jump to label curly_bracket if al="}"

    cmp al, "]"         ; compare al with "]"
    je square_bracket  ; jump to label square_bracket if al="]"

    jmp take_input          ; jump to label take_input

push_bracket:          ; jump label

    push ax             ; push ax onto the stack
    inc cx              ; set cx=cx+1
    jmp take_input          ; jump to label take_input

round_bracket:         ; jump label

    pop dx              ; pop a value from stack into dx
    dec cx              ; set cx=cx-1

    cmp cx, 0           ; compare cx with 0
    jl right_bracket  ; jump to label right_bracket if cx<0

    cmp dl, "("         ; compare dl with "("
    jne mismatch       ; jump to label mismatch if dl!="("
    jmp take_input          ; jump to label take_input
       
curly_bracket:         ; jump label

    pop dx              ; pop a value from stack into dx
    dec cx              ; set cx=cx-1

    cmp cx, 0           ; compare cx with 0
    jl right_bracket  ; jump to label right_bracket if cx<0

    cmp dl, "{"         ; compare dl with "{"
    jne mismatch       ; jump to label mismatch if dl!="{"
    jmp take_input          ; jump to label take_input

square_bracket:        ; jump label
                                   
    pop dx              ; pop a value from stack into dx
    dec cx              ; set cx=cx-1

    cmp cx, 0           ; compare cx with 0
    jl right_bracket  ; jump to label right_bracket if cx<0

    cmp dl, "["         ; compare dl with "["
    jne mismatch       ; jump to label mismatch if dl!="["
    jmp take_input          ; jump to label take_input

end_input:             ; jump label

    cmp cx, 0           ; compare cx with 0
    jne left_bracket  ; jump to label left_bracket if cx!=0

    mov ah, 9           ; set string output function

    lea dx, correct_msg     ; load and print the string correct_msg
    int 21h                      

    lea dx, continue_msg    ; load and print the string continue
    int 21h                       

    mov ah, 1           ; set input function
    int 21h             ; read a character

    cmp al, "Y"         ; compare al with "y"
    jne exit           ; jump to label exit if al!="Y"
    jmp start          ; jump to label start

mismatch:              ; jump label
    
    mov ah, 9
    lea dx, mismatch_msg    ; load and display the string mismatch            
    int 21h

    jmp start          ; jump to label start

left_bracket:         ; jump label

    lea dx, left_bracket_error; load and display the string left_bracket
    mov ah, 9
    int 21h

    jmp start          ; jump to label start

right_bracket:        ; jump label

    lea dx, right_bracket_error; load and display the string right_bracket
    mov ah, 9
    int 21h

    jmp start          ; jump to label start

exit:                  ; jump label
    
    lea dx, exit_msg    ; display the string exit_msg
    mov ah, 9
    int 21h
    mov ah, 4ch         ; return control to dos
    int 21h
   
   main endp
end main