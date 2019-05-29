    ;@Author: Raghav Maheshwari
    ;@Date: 18th May, 2019
    ;@Topic: Elevator program

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
    mov al,82h
    out dx,al

    ;This one is for setting up port a (Output port)
    mov dx,pa   
    mov al,00h
    out dx,al

    ;This one is for getting input (Port B input port)
    mov al,0f0h
    out dx,al
    mov dx,pb

    scan:
        in al,dx ;we get the input in al, consider no input is given, when it is masked
        and al,0fh ;here, masking is done,with al, it comes as zero on comaprision
        cmp al,0fh ;here. so scans again. If consider we get 0011, then we mov to al,01
        je scan
        mov cl,01

    rotate:  ;here we roatate right and if we get a carry, we go to next and add 03 and jump to rotatae
        ror al,1 ;if we dont get the carry, we mov 00h in ax and start moving.    
        jc next
        jmp startmov

    next:
        add cl,03
        jmp rotate

    startmov:
        mov ax,0f0h
        mov dx,pa


    ;Here, we output in tthe first line
    ;call the delay, then inc al, because we will need it later and ec dl, to go to the req
    ; numbet of led's and till non zero, we keep on calling.
    next_led:
        out dx,al
        call delay
        inc al
        dec cl
        jnz next_led
        ;from here we call delay twice
        ;then we decrement the al
        ; and then mask again
        call delay
        call delay
        dec al
        and al,0fh

    come_down:
        ;This is the procedure to come down.
        out dx,al
        call delay
        dec al
        cmp al,00h
        jge come_down ;jump if greater than or equal.

mov ah,04ch
int 21h


delay proc

    mov bx,02fffh
    l1:mov di,0ffffh
    l2:dec di
    jnz l2
    dec bx
    jnz l1
    ret

delay endp

code ends
end start
