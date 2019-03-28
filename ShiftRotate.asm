;@Author: Raghav Maheshwari
;@Date: 28th March, 2019
;@Topic: Using shift and rotate instruction in assembly

assume cs:code, ds:data
;This tells the assembler that we are using the small model and the code segment register points to segment named code and the 
;data segment register points to segment named data
data segment
    num1 db 64h ;num1 stores 23h
    num2 db 50h;num2 stores 34h


    num3 db ?
    num4 db ? 
    ;We create these two variables to store final values obtained after rotating in these instead of changing num1 and num2
data ends

code segment
start:

    mov ax,data
    mov ds,ax 

    ;Again reason for not directly moving is, it is to be done using some general purpose register.

    mov al,num1
    mov bl,num2

    shr al,1 ;Shift one bit to right
    shr al,1 ;shift one bit to right 

    ;What this does is basically divides by 2

    ror bl,1 ;Rotates right once
    ror bl,1
    ror bl,1

    ;Now we will ove the modified values back to num1 and num2

    mov num3,al  ;19 will be stored in this after two shr operations
    mov num4,bl ;0A will be stored after 3 ROR operations.

    mov ax,04ch
    int 21h

code ends
end start
