    ;@Author: Raghav Maheshwari
    ;@Date: 17th May, 2019
    ;@Topic: Fire help alternatively display

    
assume cs:code,ds:data
data segment

    pa equ 20a0h ;Setting the address for the port A
    pb equ 20a1h ;setting the address for the port B
    pc equ 20a2h ;setting the address for the port C
    cr equ 20a3h ;setting the address for the control register

    fire db 71h,9fh,0f5h,61h ;giving the values for fire
    help db 0d1h,61h,0e3h,31h ;giving the values for help

data ends ;the data segment ends here.

code segment
start:

    ;These are two conventional lines of code, every program is supposed to have. As we cannot
    ;directly write to the ds register, so we do it with the help of ax and put ax in ds.
    mov ax,data
    mov ds,ax 

    ;The following three lines help us to enable and activate the hardware kit.
    mov dx,cr ;this line of code, puts the address of control register in dx
    mov al,80h ;Here, we basically have the control word as 80h, as all are outputs we have
    out dx,al ;this finally enables the hardware kit by passing control word in dx.

rpt:

    mov cx,04h ;For showing file and help four times alternatively
    lea si,fire ;load the contents for the word fire

nextchar:
    mov al,[si] ;we put the value pointed in al
    call disp ;call the display function
    inc si ;increment the value of si
    loop nextchar ;goes to get the next value
    
    ;After all are done, we call the delay and then after some delay next word is shown
    call delay

    mov cx,04h


;This is same as nextchar but for the second word basically.
next:
    mov al,[si]
    call disp

    inc si
    loop next
    call delay

    mov ah,06h ;returns the ASCII value of the last character in al
    mov dl,0ffh
    int 21h

    jz rpt ;if it is non zero, then repeat

    mov ah,4ch ;This terminates the program finally
    int 21h

;Explanation for the following two can be found in the rolling message program
disp proc
    push cx
    mov cx,8

    nextbit:
        ;defines for the port B
        mov dx,pb
        out dx,al

        push ax
        ;defines for the port C
        mov al,0ffh
        mov dx,pc
        out dx,al

        mov al,00h
        out dx,al

        pop ax ;just pop the ax now
        ror al,1 ;shift to next bit
        loop nextbit ;loop over
        pop cx ;pop cx finally when alll 8 are done.
        ret ;return the control back

disp endp

delay proc

    ;basicallly nothing more than two loops.
    mov bx,02fffh
    l2: mov di,0ffffh
    l1: dec di ;dec for loop one
    jnz l1 ;jump if non jero to l1
    dec bx ;dec for loop two
    jnz l2 ;jump if non zero to l2
    ret ;return the control back

delay endp


code ends
end start