    ;@Author: Raghav Maheshwari
    ;@Date: 17th May, 2019
    ;@Topic: Rolling Message (Fire help here)
assume cs:code, ds:data

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
    mov al,82h
    out dx,al

    mov cx,15h ;This 15h is in hexadecimal, convert it to decimal, it will imply to count 21 
                ; matlab 0 to 20
    mov dx,pa
    mov al,00h

next:
    out dx,al ;display the current number
    call delay
    add al,01
    daa ;This is decimal adjust after addition, which basically converts it to proper BCD form
    loop next

    ;now once we reach 20, we again start counting back from it.
    mov cx,15h

next1:
    sub al,01
    das ;decimal adjust after subtraction, which converts to proper BCD format after subtraction
    out dx,al ;output this now.
    call delay
    loop next1

mov ah,4ch
int 21h

delay proc

    mov si,06fffh
    l1: mov di,0ffffh 
    l2: dec di
    jnz l2
    dec si
    jnz l1
    ret

delay endp

code ends
end start
