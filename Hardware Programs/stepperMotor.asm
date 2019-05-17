    ;@Author: Raghav Maheshwari
    ;@Date: 17th May, 2019
    ;@Topic: Stepper Motor (For 180 degrees)
assume cs:code,ds:data

data segment

    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h

data ends

code segment
start:

    mov ax,data
    mov ds,ax

    mov dx,cr
    mov al,80h
    out dx,al

    mov cx,64h ;please note here that for 180 degrees wwe have 64h, that is basically 100d in decimal
                ; for 90 degrees it will be 32h, that is 50d in decimal
    mov al,77h ;This value decides which coils of motor should be activated.
    mov dx,pa


    rot:
        out dx,al
        rol al,1 ;rotate left each time
        call delay
        loop rot

;This ends the program
mov ah,4ch
int 21h 


delay proc

    mov si,02fffh
    l1: mov di,0fffh
    l2: dec di
    jnz l2
    dec si
    jnz l1
    ret 

delay endp

code ends
end start
