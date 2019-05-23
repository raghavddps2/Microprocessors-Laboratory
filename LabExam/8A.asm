;This is giving a delay of 13 minutes from the system time.

;This is the program to display the system time.
;Following is the approach, to display the system time.
   ; 1.  Use the function 2ch in the interrupt int 21h, it returns the time in cx.
   ; 2.  It gives hours in ch and seconds in cl.
   ; 3.  We then convert the contents to BCD
   ; 4. Then we unpack the bcd and display the time.
assume cs:code
code segment
start:
    mov ah,2ch ;This is the function call that gives the time in hours and seconds.(ch and cl).
    int 21h

    ;Move the hours part to al, then call hex_bcd conv proc and then call the disp.
    mov al,ch
    call hex_bcd
    call disp

    ;After we are doing doing stuff for the hours we need to do for the minutes.

    mov dl,':'
    mov ah,02h
    int 21h

    ;Now we move the seconds part to al, and then call the two functions again
    mov al,cl
    call hex_bcd
    call disp

    ;These return to the dos.
    mov ah,4ch  
    int 21h


hex_bcd proc

    push cx ;we need the stack segment
    mov cl,al ;we ov mal to cl (al contains minutes and hours respectively)
    mov ch,0 ;put 0 in ch (necessary as cx will be used.)
    mov al,0 ;put 0 in al, to count till cl.

next:
    add al,1
    daa ;needed to convert to particular decimal after addition if a hex like A,B,C etc.
    loop next ;will run cl times only.
    pop cx

ret 
hex_bcd endp

disp proc

        push cx
        mov ah,00h
        mov cl,04h ;THis is required for b bit unpacked BCD conversion.
        shl ax,cl ;unpacked BCD
        shr al,cl 
        add ax,3030h ;add 3030h to convert ascii back.(Probably)
        
        push ax
        ;display the first digit
        mov dl,ah ;here ah 
        mov ah,02h
        int 21h
        pop ax

        ;display the second digit
        mov dl,al ;here al
        mov ah,02h
        int 21h
        
        pop cx
        ret
disp endp


;Now, we have the procedure for displaying the same.
code ends
end start
