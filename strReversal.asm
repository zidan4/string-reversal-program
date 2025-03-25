section .data
    msg db "Enter a string: ", 0
    output_msg db "Reversed string: ", 0
    newline db 10, 0

section .bss
    input resb 100  ; Reserve 100 bytes for input
    reversed resb 100  ; Reserve 100 bytes for reversed string

section .text
    global _start
    extern printf, scanf, puts

_start:
    ; Prompt user
    push msg
    call printf
    add esp, 4

    ; Read input
    push input
    push format
    call scanf
    add esp, 8

    ; Reverse the string
    mov esi, input  ; Source index
    mov edi, reversed  ; Destination index

find_end:
    cmp byte [esi], 0
    je reverse_str
    inc esi
    jmp find_end

reverse_str:
    dec esi  ; Move back to last valid character

reverse_loop:
    cmp esi, input
    jl print_reversed
    mov al, [esi]
    mov [edi], al
    inc edi
    dec esi
    jmp reverse_loop

print_reversed:
    mov byte [edi], 0  ; Null-terminate reversed string
    push output_msg
    call printf
    add esp, 4
    push reversed
    call puts
    add esp, 4

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
