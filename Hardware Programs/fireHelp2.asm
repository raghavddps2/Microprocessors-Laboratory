assume cs:code,ds:data
data segment

    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    fire db 71h,9fh,0f5h,61h
    help db 0d1h,61h,0e3h,31h

data ends


code segment
start:

    mov ax,data
    mov ds,ax

    mov dx,cr
    mov al,80h
    out dx,al

repeat:
    mov cx,04
    lea si,fire

    loop1:
        mov al,[si]
        call display
        inc si
        loop loop1

    call delay

    mov cx,04
    lea si,help

    loop2:
        mov al,[si]
        call display
        inc si
        loop loop2
    
    mov ah,06h
    mov dl,0ffh
    int 21h
    jz repeat

mov ah,04ch
int 21h

display proc

    push cx
    mov cx,08

    nextbit:
        mov dx,pb
        out dx,al

        push ax
            mov al,0ffh
            mov dx,pc
            out dx,al
            mov al,00h
            out dx,al
        pop ax
        ror al,1
        loop nextbit
    pop cx
    ret
    
display endp

delay proc

    mov bx,0ffffh
    l1: mov di,0ffffh
    l2: dec di
        jnz l2
        dec bx
        jnz l1
        ret 

delay endp


code ends
end start






