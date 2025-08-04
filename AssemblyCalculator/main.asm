INCLUDE Irvine32.inc
.data
    msg_num BYTE "Enter a number: ",0
    msg_oper BYTE "Enter an operator (+, -, *, /): ",0
    msg_result BYTE "Result: ",0

    num1 DWORD ?
    num2 DWORD ?
    operator BYTE ?
    result DWORD ?

.code

main PROC
    call clrscr

main_loop:
    call read_validated_number
    mov [num1], eax

    call read_validated_operator
    mov [operator], al

    call read_validated_number
    mov [num2], eax

    call calculate_result

    mov edx, OFFSET msg_result
    call WriteString
    mov eax, [result]
    call WriteInt
    call Crlf

    jmp main_loop
    exit

main ENDP

; 숫자 입력, 검증, 변환
read_validated_number PROC
    mov edx, OFFSET msg_num
    call WriteString
    call ReadInt
    ret

read_validated_number ENDP

; 연산자 입력, 검증
read_validated_operator PROC
    mov edx, OFFSET msg_oper
    call WriteString
    call ReadChar
    call Crlf
    ret

read_validated_operator ENDP

; 계산
calculate_result PROC
    mov al, [operator]
    cmp al, '+'
    je do_add

    cmp al, '-'
    je do_sub

    cmp al, '*'
    je do_mul

    cmp al, '/'
    je do_div

do_add:
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax
    ret

do_sub:
    mov eax, [num1]
    sub eax, [num2]
    mov [result], eax
    ret

do_mul:
    mov eax, [num1]
    imul eax, [num2]
    mov [result], eax
    ret

do_div:
    mov eax, [num1]
    cdq
    idiv dword ptr [num2]
    mov [result], eax
    ret

calculate_result ENDP

END main