    ;@Author: Raghav Maheshwari
    ;@Date: 17th May, 2019
    ;@Topic: Rolling Message (Fire help here)
assume cs:code, ds:data
data segment

    pa equ 20a0h ;Address for port A
    pb equ 20a1h ;Address for port B
    pc equ 20a2h ;Address for port C
    cr equ 20a3h ;Address for the control register.

data ends

code segment
start:

    mov ax,data
    mov ds,ax

    mov dx,cr
    mov al,82h ;82h because we have input and output port, port B as the input port
    out dx,al

    mov al,01 ;initially we want the counter to be in state 1 00000001

repeat: 
    mov dx,pa ;we change this every time because this is changed later
    out dx,al ;output the binary sequence to port A

    call delay
    ;after the dealy, we call the rotate instruction
    ror al,1 ; 00000001 becomes 10000000, and 01000000 and so on and on..

    ;the next to block is to check if there is a user input to break the infinite loop
    push ax
    mov ah,06h
    mov dl,0ffh ;if an input is there, zero flag is cleared else set.
    int 21h
    pop ax
    
    jz repeat ;jump on zero to repeat

;defining the delay proc here:
delay proc

    mov si,0ffffh
    l2: mov di,0ffffh
    l1: dec di
    jnz l1
    dec si
    jnz l2
    ret

delay endp

code ends
end start