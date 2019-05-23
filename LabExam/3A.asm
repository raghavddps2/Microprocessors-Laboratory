assume cs:code,ds:data

;now, we define a macro, that we will use to display conetnts on the screen.
disp macro mesg  ;So, this is format for defining a macro, we write the name, keyword macro and the parameter

lea dx,mesg ;load the mesg in the dx register
mov ah,09h ;use the function call 09h to display and the interrupt 09h
int 21h

endm ;This ends the macro here.


data segment

    pwd1 db 'raghav123' ;We define our own password here.
    len1 db len1-pwd1 ;SO, as after allocating space for pwd1, it will point to next, so we write the length as len1-pwd1
    pwd2 db 10 dup(?) ;here, where we will tmesg1 db ake the data from the user
    len2 db ? ;This we don't know as it depends on the user.

    ;Now we define the messages we will want to show to the user in different cases.
    mesg1 db 0ah,0dh,"Password Matched$"
    mesg2 db 0ah,0dh,"Password did not match$"
    mesg3 db 0ah,0dh,"Enter password$"
    mesg4 db 0ah,0dh,"Exceeded 3 attempts.$"

data ends


code segment
start:

    mov ax,data
    mov ds,ax 
    ;The reason is simple, we don't pass to segment registers just like that, we need a register to do that.
    mov es,ax ;We pass that to extra segment as well

    mov bl,0 ;This is used to keep track of the number of attempts by the user.


rpt:
    call readpwd ;This will call the proc to read the input from the user.
    call match ;TH=his will match whether the data entered by the user is correct or not.
    inc bl
    cmp bl,3
    jb rpt ;If less than 3, then take again

    disp mesg4 ;We call the macro disp with the mesg4 argument to display.

    ;This is used to end the program
    mov ah,4ch
    int 21h

;Start the procedure
readpwd proc near

    disp mesg3
    mov bh,0 ;label to keep track of number of characters entered.
    lea si,pwd2

again:
    mov ah,8 ;we use this interrupt to accept the value without printing on to the console.
    int 21h

    cmp al,0dh ;Carriage return
    je next
    mov [si],al ;move the character scanned to first location of pwd2
    inc si ;increment the si
    inc bh ;increment the bh

    mov dl,'*' ;mov * to dl, to print that instead of the scanned charcater
    mov ah,02h ;to print to the console.
    int 21h 

    jmp again ;jump again to the label to accept the furthur characters of the password.


next:   
    mov len2,bh ;move the bh which has password length to len2
    ret  ;return to the place from where func was called.

readpwd endp
;end the procedure.

;This procedure is used to match the password if correct, we use the cmpsb instruction directly.
match proc near

    mov cl,len1 ;mov length1 to cl
    cmp cl,len2 ;compare cl and len2
    je matchstr ;if qual then match the string
    jmp mismatch ;if not equal, jump to mismatch

matchstr:
    lea si,pwd1 ;put pwd1 in si
    lea di,pwd2 ;put pwd2 in di
    cld ;this is uded to clear the direction flag.When the direction flag is set to zero, string operations
        ;increment the index registers, si and di.
    mov ch,0 ;we do that but no such specific need.
    rep cmpsb ;compare charcter by character.
    jnz mismatch ;jump on  mismatch if it is non zero. It gives zero if strings are same.
    disp mesg1 ;display the message 1.
    mov ah,4ch ;end the program if the match occurs.
    int 21h


mismatch:
    disp mesg2
    ret ;return the control back.

match endp



code ends
end start
