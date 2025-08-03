INCLUDE Irvine32.inc
.data
    prompt BYTE "Enter number: ",0
.code
main PROC
    call Clrscr
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    call WriteInt
    call Crlf
    exit
main ENDP
END main