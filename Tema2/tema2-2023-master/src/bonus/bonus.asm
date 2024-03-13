%include "../include/io.mac"
section .data

section .text
    global bonus
    extern printf
bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    push ecx
    mov dl, 1
    mov cl, bl
    shl dl, cl
    pop ecx
    
    
    cmp eax, 7
    je cont 
    cmp ebx, 7
    je cont
    push eax
    push edx
    shl dl, 1
    add eax, 1

    cmp eax, 4
    jae mai_mare
    jl mai_mic
mai_mare:
    sub eax, 4
    jmp co
mai_mic:
    add eax, 4
    jmp co
co:
    mov byte [ecx + eax], dl
    pop edx
    pop eax
    
cont:
    cmp eax, 0
    je conti
    cmp ebx, 7
    je conti
    push eax
    push edx
    shl dl, 1
    sub eax, 1

    cmp eax, 4
    jae mai_mar
    jl mai_mi
mai_mar:
    sub eax, 4
    jmp c
mai_mi:
    add eax, 4
    jmp c
c:
    mov byte [ecx + eax], dl
    pop edx
    pop eax

    
conti:
    cmp eax, 0
    je contin
    cmp ebx, 0
    je contin
    push eax
    push edx
    shr dl, 1
    sub eax, 1

    cmp eax, 4
    jae mai_ma
    jl mai_m
mai_ma:
    sub eax, 4
    jmp cac
mai_m:
    add eax, 4
    jmp cac
cac:
    add byte [ecx + eax], dl
    pop edx
    pop eax

contin:
    cmp eax, 7
    je exit 
    cmp ebx, 0
    je exit
    shr dl, 1
    add eax, 1

    cmp eax, 4
    jae mai_mac
    jl mai_mc
mai_mac:
    sub eax, 4
    jmp cacc
mai_mc:
    add eax, 4
    jmp cacc
cacc:
    add byte [ecx + eax], dl

exit:
;
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY