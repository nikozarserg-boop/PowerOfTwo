bits 64
default rel

extern printf

section .data
    format db "%llu", 10, 0

section .text
global main

main:
    mov rax, 2
    mov r12, 64
    
loop_multiply:
    cmp r12, 0
    je exit_loop
    
    mov r13, rax
    
    sub rsp, 40
    lea rcx, [format]
    mov rdx, r13
    call printf
    add rsp, 40
    
    mov rax, r13
    
    shl rax, 1
    jc overflow_detected
    
    dec r12
    jmp loop_multiply
    
overflow_detected:
exit_loop:
    jmp exit_loop
