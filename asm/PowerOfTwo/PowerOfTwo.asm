bits 64
default rel

extern printf

section .data
    header db "Вычисление степеней двойки (Big Integer на Assembly)", 10, 0
    separator db "========================================", 10, 0
    format_power db "2^%d = %llu", 10, 0
    format_error db 10, "Ошибка: переполнение на степени 2^%d", 10, 0

section .text
global main

main:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    sub rsp, 40
    
    lea rcx, [header]
    call printf
    
    lea rcx, [separator]
    call printf
    
    mov rax, 1
    mov r12, 0
    
loop_iterate:
    cmp r12, 63
    jge loop_overflow
    
    mov rbx, rax
    
    lea rcx, [format_power]
    mov rdx, r12
    mov r8, rbx
    call printf
    
    mov rax, rbx
    shl rax, 1
    jc loop_overflow
    
    inc r12
    jmp loop_iterate
    
loop_overflow:
    lea rcx, [format_error]
    mov rdx, r12
    call printf
    
    xor rax, rax
    
    add rsp, 40
    pop r12
    pop rbx
    pop rbp
    ret
