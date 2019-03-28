assume cs:code,ds:data

data segment

    n db 5 ;Assigning the value of n as 5
    res db ? ;factorial result will be stored here.

data ends


code segment
start:

    mov ax,data
    mov ds,ax 

    ; Why didn't we directly sent data to ds, because in case of segment registers only , general purpose registers are allowed
    ; to set the values.

    mov al,n
    call fact ;call is a keyword used to call a procedure (proc)


    mov ah,4ch ;exit interrupt.
    int 21h

    fact proc 
        cmp al,00 ;compare if the value if 0
        je cal ;the jump to cal, and assign 1 to result
        push ax ;push the value of ax to stack
        dec al ;decrement al
        call fact ;call favtorial again
        pop ax ;pop the value
        mul res ;gets multiplied with res
        mov res,al ;put the value in res
        ret

    cal:
        mov res,01h ;assign 01
        ret
        fact endp


code ends
end start


