;@Author: Raghav Maheshwari
;@Date: 28th March, 2019
;@Topic: Display X on the screen.
assume cs:code ;defining the assume model and initializing only the code segment, we don't require data segment here.

code segment
start:

    mov ah,00h ;This is to set the video mode.
    mov al,03h ;80X25 grayscale ;if 12h, then 40X25
    int 10h ;BIOS(Basic input output system interrupt)

    mov ah,02h ;This is to set the cursor
    mov dh,12d ;This sets the row
    mov dl,40d ;This sets the character in the row.
    int 10h ;BIOS interrupt.

    mov al,'X'
    mov bl, 12ch ;This is used to set up the color
    mov cl,1 ;No of times character to be printed.
    mov ah,09 ;This writes the character and attribute at cursor position
    int 10h ;This is again fr the BIOS interrupt.

    mov ah,07 ;reading next command without echo.
    int 21h

    mov ah,4ch ;exit 
    int 21h

code ends
end start