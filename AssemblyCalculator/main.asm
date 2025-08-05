INCLUDE Irvine32.inc
.data
    box_calc01 BYTE "╔══════════════════════════╗",0dh,0ah,0
    box_calc02 BYTE "║        Calculator        ║",0dh,0ah,0
    box_calc03 BYTE "╠══════════════════════════╣",0dh,0ah,0
    box_calc04 BYTE "║ 1) Addition (+)          ║",0dh,0ah,0
    box_calc05 BYTE "║ 2) Subtraction (-)       ║",0dh,0ah,0
    box_calc06 BYTE "║ 3) Multiplication (*)    ║",0dh,0ah,0
    box_calc07 BYTE "║ 4) Division (/)          ║",0dh,0ah,0
    box_calc08 BYTE "║ 5) Modulo (%)            ║",0dh,0ah,0
    box_calc09 BYTE "║ 6) Power (^)             ║",0dh,0ah,0
    box_calc10 BYTE "╚══════════════════════════╝",0dh,0ah,0

    msg_num1 BYTE "Step 1. Enter first number:",0
    msg_oper BYTE "Step 2. Choose operation:",0
    msg_num2 BYTE "Step 3. Enter second number:",0
    
    msg_expression BYTE "Expression: ",0
    
    msg_zero_div BYTE "Error: Division by zero is not allowed.",0

    str_space BYTE " ",0
    str_equal BYTE " = ",0

    num1 DWORD ?
    num2 DWORD ?
    operator DWORD ?
    result DWORD ?

.code

main PROC
    call clrscr

main_loop:
    mov edx, OFFSET box_calc01
    call WriteString

    mov edx, OFFSET box_calc02
    call WriteString

    mov edx, OFFSET box_calc03
    call WriteString

    mov edx, OFFSET box_calc04
    call WriteString

    mov edx, OFFSET box_calc05
    call WriteString

    mov edx, OFFSET box_calc06
    call WriteString

    mov edx, OFFSET box_calc07
    call WriteString

    mov edx, OFFSET box_calc08
    call WriteString

    mov edx, OFFSET box_calc09
    call WriteString

    mov edx, OFFSET box_calc10
    call WriteString

    call read_first_number
    mov [num1], eax

    call read_operator
    mov [operator], eax

    call read_second_number
    mov [num2], eax

    call calculate_result
    mov edx, OFFSET msg_expression
    call WriteString
    call print_expression
    call Crlf

    jmp main_loop
    exit

main ENDP

; 숫자 입력
read_first_number PROC
    mov edx, OFFSET msg_num1
    call WriteString
    call ReadInt
    ret

read_first_number ENDP

read_second_number PROC
    mov edx, OFFSET msg_num2
    call WriteString
    call ReadInt
    ret

read_second_number ENDP

; 연산자 입력
read_operator PROC
    mov edx, OFFSET msg_oper
    call WriteString
    call ReadInt
    ret

read_operator ENDP

; 계산
calculate_result PROC
    mov eax, [operator]
    cmp eax, 1
    je do_add

    cmp eax, 2
    je do_sub

    cmp eax, 3
    je do_mul

    cmp eax, 4
    je do_div

    cmp eax, 5
    je do_mod

    cmp eax, 6
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
    mov al, '('
    call WriteChar

    mov eax, [num1]
    call WriteInt

    mov al, ')'
    call WriteChar

    mov edx, OFFSET str_space
    call WriteString

    mov eax, [operator]
    cmp eax, 1
    je print_plus

    cmp eax, 2
    je print_sub

    cmp eax, 3
    je print_mul

    cmp eax, 4
    je print_div

    cmp eax, 5
    je print_mod

    cmp eax, 6
    je print_pow

print_plus:
    mov al, '+'
    jmp print_op

print_sub:
    mov al, '-'
    jmp print_op

print_mul:
    mov al, '*'
    jmp print_op

print_div:
    mov al, '/'
    jmp print_op

print_mod:
    mov al, '%'
    jmp print_op

print_pow:
    mov al, '^'
    jmp print_op

print_op:
    call WriteChar

    mov edx, OFFSET str_space
    call WriteString

    mov al, '('
    call WriteChar

    mov eax, [num2]
    call WriteInt

    mov al, ')'
    call WriteChar

    mov edx, OFFSET str_equal
    call WriteString

    mov eax, [result]
    call WriteInt
    call Crlf
    ret

print_expression ENDP

END main