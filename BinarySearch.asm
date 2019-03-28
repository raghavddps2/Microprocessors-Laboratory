assume cs:code,ds:data

data segment

    a db 10h,20h,30h,40h,50h  ;This makes an array with the balues as shown and indexes as 0,1,2,3,4
    n db n-a ;The value of n points to 5, we subtract a from it, 5 gets stored in n (Basically n = 5)
    key db 10h ;This is the key element.
    msg1 db "Search Unsuccessful$" ;Message for unsuccessfull search, and all strings end with $
    msg2 db "Key found at position: " ;This doesn't end with $ as the position still needs to be concatenated.
    pos db ?, "$" ;This will end the string after concatenatinng the position.

data ends

code segment
start:

    mov ax,data 
    mov ds,ax ; We don't do that directly, because assignmnet to data segment can be done from general purpose register only.


    mov al,0 ;low = 0
    mov dl,n ;high = n
    dec dl ;decrement the value of dl (actual last index = n-1);

    again:

        cmp al,dl ;This compares low and high
        ja failed ;if (low>high) jump to failed label.
        mov cl,al ;Mov al to cl, as the value will keep changing.
        add al,dl ;This will add low and high
        shr al,1 ;THis will divide the value in al by 2(Basically this will be the mid.)

        mov ah,00h 
        ;Why do we do this? 
            ;This is because we have to use si as indirect addressing and that is done only with ax,bx,cx,dx and hot with either
            ;ah,al etc, so we move 00h in ah to remove any garbage value already present.
        mov si,ax ;
        mov bl,[si] ;This will be as an offset to the value pointed by al, so will represent the mid value.
        cmp bl,key

        jae loc1 ;(Jump if above or equal to loc 1)
        inc al; (else increment the value of al)
        jmp again ;continue in the same 

    loc1:
        je success ;If equal, its a successfull search
        dec al ;if a[mid]>key
        mov dl,al ;high is al now (in dl)
        mov al,cl ;mov new low to al
        jmp again

    failed:
        lea dx,msg1 ;As the search fails, load msg1 in dx
        jmp display

    success:
        inc al ;As the index is from 0 to  n-1;
        add al,30h ;Ascii value of 0.
        mov pos,al;Store the key position in pos
        lea dx,msg2;Store success message here.
        
            ;This is again a wonderful logic as to why we add 30h here, 
            ;31h, 32h etc represent 1,2,..., and we wanna display the digit and not the BCD form , hence
            ; Hence By adding 30H to BCD will Convert it to ASCII code which will print the digit (number) on screen.
    


    display:
        mov ah,09h ;This is to dislay
        int 21h

        mov ah,04ch ;This is to exit!
        int 21h

code ends
end start
