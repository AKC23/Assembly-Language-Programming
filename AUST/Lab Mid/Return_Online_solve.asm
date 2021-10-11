;a = 3
;b = a - 5
;c = a + b
;c = c + roll

.model small
.stack 100h
.data
    a dw 3
    b dw ?
    c dw ?
    r dw 37     
.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov ax,a    ; ax = a
    mov bx,5    ; bx=5
    add bx,ax   ; bx = ax(3) + 5
    mov b,bx    ; b = bx(8)
        
    ;mov ah,2
    ;add b,48    ; b = b + 48
    add ax,b     ; ax = ax + b
    mov c,ax     ; c = ax
    
    mov ax,r     ;ax = r
    
    mov ah,2
    add c,ax
    ;add c,48    ; c = c + 48
    mov dx,c    ; dx = c
    int 21h 
    
    
    ;output = 0
    
    
exit:    
mov ah,4ch
int 21h
end main    
    