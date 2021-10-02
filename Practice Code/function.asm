include 'emu8086.inc'
.model small
.stack 100h
.data
.code
main proc 
    
    call hello_world
    
    printn 'main function'
    
    mov ah,4ch
    int 21h 
    main endp

 hello_world proc
    print 'hello '
    printn 'world'
    
    ret
    
    hello_world endp
    