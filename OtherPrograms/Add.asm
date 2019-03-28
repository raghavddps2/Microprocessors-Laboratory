;@Author: Raghav Maheshwari
;@Date: 28th March, 2019
;@Topic: Addition in Assembly


assume cs:code, ds:data
; This tells the assembler that the code segment register points to segment namd code and the data segment register points 
; to the segment named data

data segment ; The data segment register points to this segment. Segment is a keyword and data is the name of the segment.

    num1 db 23h ; We define a variable named num1 with type as db or databyte and value as 23H (Hexadecimal)
    num2 db 22h; We again deine a variable named num2 with type as databyte and value as 43h

    sum db ? ; This creates a variable called sum and the ? represents empty value.
data ends ;The data segment ends here, with the keyword ends.


code segment ; The cs register points to this segment.
start:       ;This is the entry point of the program, (Basically the code segment.)

    mov ax,data ;Moves address of the data to ax
    mov ds,ax   ; moves the address in ax to the data segment (ds)

    ; We directly don't do, mov ds,data because ds is the segment register and only general purpose registers can give
    ; values to segment registers.


    mov al,num1 ; This moves the value in num1 to al (last two nibbles of ax)
    mov bl,num2 ;This moves value in mum2 to bl (last two nibbles (low))

    add al,bl ; This adds values in al and bl and stores it in al
    mov sum,al ;Moves the value of al in the sum

    
    ;mov ah,9 ;This is the service number for displaying the sum
    ;int 21h ;This is the interrupt

    mov ah,4ch ;service number for exit
    int 21h  ;This is the interrupt

code ends ;code segment ends here
end start ;The program ends here if we dont provide the exit interrupt.