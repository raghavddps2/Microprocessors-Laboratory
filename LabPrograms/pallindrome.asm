;@Author: Raghav Maheshwari
;@Date: 29th March, 2019
;@Topic: Pallindrome.
assume cs:code,ds:data
data segment

    str1 db 'madam'
    n dw n-str1 ;getting the characters in str1
    str2 db 5 dup(?) ;making a string for n
    msg1 db "It is a pallindrome$" ;defining success message
    msg2 db "It is not a pallindrome$" ;defining not success

data ends


code segment
start:

    mov ax,data
    mov ds,ax

    mov es,ax

    mov cx,n ;storing the number of characters in cx

    lea si,n ;Stroing the n as the si
    dec si ;decrementing it.

    lea di,str2 ;setting offset as di

nextchar:
    mov al,[si] ;storing character by charcter from the start in reverse order in str2 using this line and the next line
    mov [di],al
    dec si ;decrementing for str1 
    inc di ;incrementing for str2
    loop nextchar ;looping the smae

    lea si,str1
    lea di,str2

    cld  ;Both si and di will be incremented using this instruction (Clears direction flag), set to zero, increments 
        ;extra segment
    mov cx,n
    rep cmpsb ;Compares byte at address DS:(E)SI with byte at address ES:(E)DI and sets the status flags accordingly(Zero for dsi 
                ; si and di to be incremented). Extra segment
    jnz unsuccess ;(Jump on non zero)
    lea dx,msg1 ;If success load msg 1
    jmp display ;Jump to display:

unsuccess:
    lea dx,msg2  ;load msg2 in dx
display: 
    mov ah,9h ;print it 
    int 21h

    mov ah,4ch ;exit interrupt
    int 21h

code ends
end start