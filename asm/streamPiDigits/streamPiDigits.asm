; Assembly implementation of Pi Spigot Algorithm (x86-64 Windows)
; Uses Gibbons' algorithm for correctness

bits 64
default rel

extern printf
extern malloc
extern free

section .data
    header db "Computing Pi Decimal Digits (Spigot Algorithm)", 10, 0
    separator db "================================================", 10, 0
    pi_start db "3.", 0
    format_digit db "%d", 0
    format_newline db 10, 0

section .text
global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    push rbx
    push r12
    push r13
    push r14
    push r15
    
    ; Print header
    lea rcx, [rel header]
    call printf
    
    lea rcx, [rel separator]
    call printf
    
    ; Calculate array size: len = (10 * maxDigits) / 3
    mov r12, 10000          ; maxDigits
    mov rax, r12
    imul rax, 10
    mov rdx, 0
    mov rcx, 3
    div rcx
    mov r13, rax            ; r13 = len
    
    ; Allocate array: malloc((len + 1) * 8)
    mov rcx, r13
    inc rcx
    shl rcx, 3
    call malloc
    mov r14, rax            ; r14 = pointer to array
    
    ; Initialize array with 2s
    xor r12, r12
init_loop:
    cmp r12, r13
    jg init_done
    mov qword [r14 + r12*8], 2
    inc r12
    jmp init_loop
    
init_done:
    ; Print "3."
    lea rcx, [rel pi_start]
    call printf
    
    xor r15, r15            ; r15 = nines
    xor rbx, rbx            ; rbx = predigit
    xor r12, r12            ; r12 = j (digit counter)
    
digit_loop:
    cmp r12, 10000
    jge output_done
    
    xor rdx, rdx            ; q = 0
    
    ; Inner loop: work backwards through array
    mov r11, r13
    
inner_loop:
    cmp r11, 0
    jl inner_done
    
    ; x = 10 * a[i] + q * i
    mov rax, [r14 + r11*8]
    imul rax, 10
    mov rcx, rdx
    imul rcx, r11
    add rax, rcx
    
    ; a[i] = x % (2*i - 1)
    mov rcx, r11
    add rcx, r11
    dec rcx
    mov rdx, 0
    div rcx
    mov rcx, r11
    add rcx, r11
    dec rcx
    mov [r14 + r11*8], rdx
    
    ; q = x / (2*i - 1)
    mov rdx, 0
    
    dec r11
    jmp inner_loop
    
inner_done:
    ; a[1] = q % 10
    mov rax, rdx
    mov rdx, 0
    mov rcx, 10
    div rcx
    mov [r14 + 8], rdx
    mov rdx, rax
    
    ; q = q / 10
    mov rax, rdx
    xor rdx, rdx
    mov rcx, 10
    div rcx
    mov rdx, rax
    
    ; Check conditions
    cmp rdx, 9
    je handle_nine
    
    cmp rdx, 10
    je handle_ten
    
    ; else: output predigit and q
    mov rcx, rbx
    mov r8, rdx
    lea r9, [rel format_digit]
    call printf
    
    mov rbx, r8
    xor r15, r15
    jmp next_digit
    
handle_nine:
    inc r15
    jmp next_digit
    
handle_ten:
    mov rax, rbx
    inc rax
    mov rcx, rax
    lea r8, [rel format_digit]
    call printf
    
    xor r12b, r12b
print_zeros:
    cmp r12b, r15b
    jge zeros_done
    
    mov rcx, '0'
    call printf
    inc r12b
    jmp print_zeros
    
zeros_done:
    xor rbx, rbx
    xor r15, r15
    
next_digit:
    inc r12
    jmp digit_loop
    
output_done:
    mov rcx, rbx
    lea r8, [rel format_digit]
    call printf
    
    lea rcx, [rel format_newline]
    call printf
    
    mov rcx, r14
    call free
    
    add rsp, 64
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    xor rax, rax
    ret
