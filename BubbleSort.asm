;@Author: Raghav Maheshwari
;@Date: 28th March, 2019
;@Topic: BubbleSort.

assume cs:code, ds:data
data segment
    a db 05h,04h,03h,02h,01h ;sets the values into arrray a
    n dw n-a ;n = 5
data ends
    
code segment
start:
    mov ax,data
    mov ds,ax

    mov bx,n
    dec bx ;total number of passes one less than n
    NEXTPASS:
        mov cx,bx ;setting it in cx
        mov si,0 ;setting as 0 (for comparision)

    NEXTCOMP:
        mov al,a[si] ;setting tthe value of A[si] to al
        inc si ;incrementing si to check with next element
        cmp al,a[si] ;if al<a[si], no need to exchange, go to NO_EXg
        jb NO_EXG 

        xchg al,a[si] ;if not, exchnage but at a time, there can be max one memory, other has to be register, memory to memory
                        ;is not possible. So, we put al in a[si]  and a[si] in al; this gets changed in register al, have to change it in si-1 also

        mov a[si-1],al ;so what we do is basically, a[si-1] we put al the actual value that should be there.(In memory we do here, register
                        ;its already done with xchg)
    NO_EXG:
        loop NEXTCOMP ;loop again to NEXTCOMP
        dec bx ;decrease the value of bx
        jnz NEXTPASS ;Go to next value of i (logically upto it is not zero (bx)) (jump on no zero)

    mov ah,04ch ;exit 
    int 21h
code ends
end start