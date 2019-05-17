    ;@Author: Raghav Maheshwari
    ;@Date: 17th May, 2019
    ;@Topic: Rolling Message (Fire help here)

assume cs:code, ds:data
data segment
    pa equ 20a0h ;This tells the address for port A
    pb equ 20a1h ;This tells the address for port B
    pc equ 20a2h ;This tells the address for port C
    cr equ 20a3h ;This tells for the control register.

    msg db 0ffh,71h,9fh,0f5h,61h,0ffh,0d1h,61h,0e3h,31h,0ffh,0d1h,61h,0f5h,61h
    ;This defines the characters for the message Fire Help Here.
data ends

;Start the code segment
code segment
start:

    mov ax,data
    mov ds,ax ;We put the data in the data segment, that is to be done using a register.

    mov dx,cr ;move control register var we created to dx
    mov al,80h  ;to initialize all the ports as output ports.
    out dx,al  ;We have to move the value 80h to the dx(for control register)

rpt:

    mov cx,15d ;initializes cx with 15 in decimal
    lea si,msg ;points the source index to the first content of the msg.

nextchar:
    mov al,[si] ;move the content to the al register
    call disp ;To display
    call delay ;for the delay basically to roll
    inc si ;increase the value of si 
    loop nextchar ;loop for the nextcharacter

    mov ah,06h ;This returns the ascii code of the last character in al
    mov dl,0ffh ; Means dont wait for input
    int 21h 
    jz rpt ;if no charcater is there repeat the loop.

    ;Below are the standard lines to terminate a program
    mov ah,4ch
    int 21h


;procedure for display
disp proc
    push cx ;As it has 8 bits (a to h we discussed)
    mov cx,8

    nextbit:
        mov dx,pb ;port B's address goes to this
        out dx,al ;output the content through the port

        mov al,0ffh
        mov dx,pc ;telling for the port c
        out dx,al ;outputting the same

        mov al,00h
        out dx,al

        pop ax ; NOw pop the ax from the stack
        ror al,1 ;for the next bit.
        loop nextbit ;Till whole 8 is covered
        pop cx
        ret ;return the control back

disp endp

;Whole procedure tells about the delay
delay proc
;Thsi behaves like kind of two loops.
    mov bx,02fffh 
    l2: mov di,0ffffh
    l1: dec di
    jnz l1 ;if not zero, jump back 
    dec bx ;decrement bx
    jnz l2 ;if not zero jump back to l1
    ret ;return the control back.

delay endp ;end the procedure.

code ends
end start

