.model small
.stack 100h

.data
msg1  db ,'Input a string: $'
msg2  db  0dh,0ah,'The string in reverse order: $'

count dw 0

.code

main proc
    mov ax, @data       ; initialize ds 
    mov ds, ax

    lea dx, msg1        ; load and display msg1 
    mov ah, 9
    int 21h

    xor cx, cx          ; clear cx
    mov ah, 1           ; set input function

@input:                 ; loop label
    int 21h             ; read a character

    cmp al, 0dh         ; compare al with cr
    je @end_input       ; if al=cr jump to label @end_input

    push ax             ; push ax onto the stack
    inc cx              ; set cx=cx+1
    jmp @input          ; jump to label @input

@end_input:             ; jump label

    mov bx, 50h         ; set bx=50h

    xchg bx, sp         ; swap bx and sp

    push 0020h          ; push 0020h onto the stack

    xchg bx, sp         ; swap bx and sp
    inc count           ; set count=count+1

@loop_1:                ; loop label
    pop dx              ; pop a value from stack into dx

    xchg bx, sp         ; swap bx and sp

    push dx             ; push dx onto the stack

    xchg bx, sp         ; swap bx and sp
    inc count           ; set count=count+1
    loop @loop_1        ; jump to label @loop_1 if cx!=0

    lea dx, msg2        ; load and display msg2 
    mov ah, 9
    int 21h

    mov cx, count       ; set cx=count
    mov count, 0        ; set count=0

    push 0020h          ; push 0020h onto the stack
    inc count           ; set count=count+1

@output:                ; loop label
    xchg bx, sp         ; swap bx and sp

    pop dx              ; pop a value from stack into dx

    xchg bx, sp         ; swap bx and sp

    cmp dl, 20h         ; compare dl with 20h
    jne @skip_printing  ; jump to label @skip_printing if dl!=20h

    mov ah, 2           ; set output function

@loop_2:                ; loop label
    pop dx              ; pop a value from stack into dx 
    int 21h             ; print a character

    dec count           ; set count=count-1
    jnz @loop_2         ; jump to label @loop_2 if count!=0

    mov dx, 0020h       ; set dx=0020h

@skip_printing:         ; jump label

    push dx             ; push dx onto the stack
    inc count           ; set count=count+1
    loop @output        ; jump to label @output if cx!=0

    mov ah, 4ch         ; return control to dos
    int 21h

    main endp
end main