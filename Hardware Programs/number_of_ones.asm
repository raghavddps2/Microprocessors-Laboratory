assume cs:code,ds:data

;Anything in the assume model has a code segment and a data segment. 
;The following is the code segment.
data segment

    pa equ 20a0h ;setting address for port A 
    pb equ 20a1h ;setting address for port B
    pc equ 20a2h ;setting address for port C
    cr equ 20a3h ;setting address for control register
    msg equ "No. of 1's is:"  ;seeting the message to be displayed
    ones db ?,"$" ;variable for the number of ones.

data ends


;The following is the code segment
code segment
start:

    mov ax,data ;moves the data to the ax regsiter.
    mov ds,ax ;moves ax to ds. (For the segment register, can't do directly.)

    mov dx,cr ;putting control register in dx
    mov al,82h ;Define tthe cintrol word(A--output and B--input)
    out dx,al ;finally initilaizes the o/p port.
     
    mov dx,pb ;putting address of port b in dx
    in al,dx ;getting the input in the bit form in al.

    mov cx,8 ;(This is because as we have 8 bits.)
    mov ah,00 ;we make ah as 00, we have data in al

rot_again:
    ror al,1 ;To get the carry by rotating
    ;if carry is generated matlab one hai, so inc ah,otherwise jump to next, which tell to come back to rot_again
    jnc next
    inc ah

next:

    loop rot_again ;again calling rot_again
    mov bl,ah ;moving whatever we got finally into bl, 
    add ah,30h ;we want in decimal so adding 30
    mov ones,ah ;move ah to onees variable

    lea dx,msg ;we load the msg variable to dx register.
    mov ax,09h
    int 21h ;the interrupt is used to write to the standard output.

    mov al,00h
    ror bl,1 ;to check if odd or even, if carry genearted then odd.
    jc disp ; (Matlab if odd)
    mov al,0ffh ; if no carry, put this in al

disp:
    mov ax,pa
    out dx,al ;output found in A

;this exits the program
mov ah,4ch
int 21h

code ends
end start