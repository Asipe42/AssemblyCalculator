INCLUDE Irvine32.inc
.data
    msg_num BYTE "Enter a number: ",0
    msg_oper BYTE "Enter an operator (+, -, *, /, %, ^): ",0
    msg_result BYTE "Result: ",0
    msg_zero_div BYTE "Error: Division by zero is not allowed.",0

    str_space BYTE " ",0
    str_equal BYTE " = ",0

    num1 DWORD ?
    num2 DWORD ?
    operator BYTE ?
    result DWORD ?

.code

main PROC
    call clrscr

main_loop:
    call read_number
    mov [num1], eax

    call read_operator
    mov [operator], al

    call read_number
    mov [num2], eax

    call calculate_result

    mov edx, OFFSET msg_result
    call WriteString
    call print_expression
    call Crlf

    jmp main_loop
    exit

main ENDP

; 숫자 입력
read_number PROC
    mov edx, OFFSET msg_num
    call WriteString
    call ReadInt
    ret

read_number ENDP

; 연산자 입력
read_operator PROC
    mov edx, OFFSET msg_oper
    call WriteString
    call ReadChar
    call Crlf
    ret

read_operator ENDP

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

    cmp al, '%'
    je do_mod

    cmp al, '^'
    je do_pow

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
    mov eax, [num2]
    cmp eax, 0
    je divide_by_zero_error
    
    mov eax, [num1]
    cdq
    idiv dword ptr [num2]
    mov [result], eax
    ret

divide_by_zero_error:
    mov edx, OFFSET msg_zero_div
    call WriteString
    call Crlf

    mov eax, 0
    mov [result], eax
    ret

do_mod:
    mov eax, [num2]
    cmp eax, 0
    je divide_by_zero_error

    mov eax, [num1]
    cdq
    idiv dword ptr [num2]
    mov [result], edx
    ret

do_pow:
    mov ecx, [num2] ; 지수
    cmp ecx, 0  
    jl pow_negative

    mov eax, 1      ; 결과
    mov ebx, [num1] ; 밑
    jmp pow_loop

pow_negative:
    mov eax, 1
    mov [result], eax
    ret

pow_loop:
    cmp ecx, 0
    je pow_done
    imul eax, ebx
    dec ecx
    jmp pow_loop

pow_done:
    mov [result], eax
    ret

calculate_result ENDP

; 수식 출력
print_expression PROC
    mov eax, [num1]
    call WriteInt

    mov edx, OFFSET str_space
    call WriteString

    mov al, [operator]
    mov ah, 0
    mov dl, al
    call WriteChar

    mov edx, OFFSET str_space
    call WriteString

    mov eax, [num2]
    call WriteInt

    mov edx, OFFSET str_equal
    call WriteString

    mov eax, [result]
    call WriteInt
    call Crlf
    ret

print_expression ENDP
;---------------------------------------

END main