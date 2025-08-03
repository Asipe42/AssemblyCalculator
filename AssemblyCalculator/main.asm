INCLUDE Irvine32.inc
.data
    prompt0 BYTE "Enter the first number: ",0
    prompt1 BYTE "Enter the operator (+, -, *, /): ",0
    prompt2 BYTE "Enter the second number: ",0

.code
main PROC
    call Clrscr
    mov edx, OFFSET prompt0
    call WriteString
    call ReadInt

    mov edx, OFFSET prompt1
    call WriteString
    call ReadChar

    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt

    call Crlf
    exit
main ENDP
END main