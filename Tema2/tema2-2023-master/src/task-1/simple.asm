%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov ebx, ecx
loop:
    add byte[esi], dl
    cmp byte[esi], 90
    jle continue
    sub byte[esi], 26
    continue:
    mov al, byte[esi]
    mov byte[edi], al
    add edi, 1
    add esi, 1
    sub ecx, 1
    cmp ecx, 0
    jnz loop

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
