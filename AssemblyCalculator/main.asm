INCLUDE Irvine32.inc
.data
    promptNum1 BYTE "Enter the first number: ",0
    promptOper BYTE "Enter the operator (+, -, *, /): ",0
    promptNum2 BYTE "Enter the second number: ",0
    resultMsg BYTE "Result: ",0

    num1 DWORD ?
    num2 DWORD ?
    oper BYTE ?
    result DWORD ?

.code
main PROC
    call Clrscr

    ; 첫 번째 숫자 입력
    mov edx, OFFSET promptNum1
    call WriteString
    call ReadInt
    mov [num1], eax
  
    ; 연산자 입력
    mov edx, OFFSET promptOper
    call WriteString
    call ReadChar
    mov [oper], al

    ; 두 번째 숫자 입력
    call Crlf
    mov edx, OFFSET promptNum2
    call WriteString
    call ReadInt
    mov [num2], eax

    mov al, [oper]
    cmp al, '+'
    je DoAdd

    cmp al, '-'
    je DoSub

    cmp al, '*'
    je DoMul

    cmp al, '/'
    je DoDiv

DoAdd:
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax
    jmp PrintResult

DoSub:
    mov eax, [num1]
    sub eax, [num2]
    mov [result], eax
    jmp PrintResult

DoMul:
    jmp PrintResult

DoDiv:
    jmp PrintResult

PrintResult:
    mov edx, OFFSET resultMsg
    call WriteString

    mov eax, [result]
    call WriteInt

    call Crlf
    
    exit
main ENDP
END main