;@Author: Raghav Maheshwari
;@Date: 28th March, 2019
;@Topic: Fibonacci Series .
assume cs:code, ds:data
data segment

    fibo db 15 dup(?) ;Getting 10 locations for storing fibonacci numbers
    n db 10h ;Telling the number of numbers to be calculated.
data ends


code segment
start:

    mov ax,data
    mov ds,ax

    lea si,fibo ;put the fibo starting address in si. 

    mov al,00h ;move 00h in ah (fib(n-2))
    mov [si],al ;Move al in the first location
    inc si ;inc si to point to next location.

    mov bl,01h ;put 01h in bl (fib(n-1))
    mov [si],bl ;put in 2nd location bl
    inc si ;increment the value of si

    ;now we already got two locations, so we need more n-2 locations.
    mov cl,n ;total numbers required
    sub cl,2 ;we need n-2 locations now
    mov ch,00 ;So that the loop instruction can be used.

nextNumber:

    add al,bl ;This will add fib(n-1) and fib(n-2)
    mov [si],al ;The obtained al is moved to fibo[si]
    inc si ;si is incremented now.
     xchg al,bl ;al is supposed to be fib(n-2), so we will xchnage it 
    loop nextNumber

    mov ah,4ch ;exit interrupt.
    int 21h

code ends
end start