%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    xor ebx, ebx
    sub eax, 1
    xor edi, edi
    
f_loop1:
    mov edi, ebx
f_loop2:
    lea esi, [proc_size * ebx]
    mov cl, byte [edx + esi + proc.prio]
    push ecx
    lea esi, [proc_size * edi]
    mov cl, byte [edx + esi + proc.prio]
    pop esi
    
    cmp ecx, esi
    ja cont
    push eax
    mov eax, esi
    lea esi, [proc_size * ebx]
    mov byte [edx + esi + proc.prio], cl
    lea esi, [proc_size * edi]
    mov byte [edx + esi + proc.prio], al
    
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.pid]
    push ecx

    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.pid]
    pop eax
    lea esi, [proc_size * ebx]
    mov word [edx + esi + proc.pid], cx
    lea esi, [proc_size * edi]
    mov word [edx + esi + proc.pid], ax
    
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.time]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.time]
    pop eax
    lea esi, [proc_size * ebx]
    mov word [edx + esi + proc.time], cx
    lea esi, [proc_size * edi]
    mov word [edx + esi + proc.time], ax
    pop eax
cont:
    add edi, 1
    cmp edi, eax
    jle f_loop2
    add ebx, 1
    cmp ebx, eax
    jle f_loop1
    
    xor ebx, ebx
    xor edi, edi
    
for_loop1:
    mov edi, ebx
for_loop2:
    lea esi, [proc_size * ebx]
    mov cl, byte [edx + esi + proc.prio]
    push ecx
    lea esi, [proc_size * edi]
    mov cl, byte [edx + esi + proc.prio]
    pop esi
    
    cmp ecx, esi
    jne conti
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.time]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.time]
    pop esi
    cmp ecx, esi
    ja conti
    push eax
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.pid]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.pid]
    pop eax
    lea esi, [proc_size * ebx]
    mov word [edx + esi + proc.pid], cx
    lea esi, [proc_size * edi]
    mov word [edx + esi + proc.pid], ax
    
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.time]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.time]
    pop eax
    lea esi, [proc_size * ebx]
    mov word [edx + esi + proc.time], cx
    lea esi, [proc_size * edi]
    mov word [edx + esi + proc.time], ax
    pop eax
conti:
    add edi, 1
    cmp edi, eax
    jle for_loop2
    add ebx, 1
    cmp ebx, eax
    jle for_loop1

    xor ebx, ebx
    xor edi, edi
    
fo_loop1:
    mov edi, ebx
fo_loop2:
    lea esi, [proc_size * ebx]
    mov cl, byte [edx + esi + proc.prio]
    push ecx
    lea esi, [proc_size * edi]
    mov cl, byte [edx + esi + proc.prio]
    pop esi
    
    cmp ecx, esi
    jne contin
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.time]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.time]
    pop esi
    
    cmp ecx, esi
    jne contin
    lea esi, [proc_size * ebx]
    mov cx, word [edx + esi + proc.pid]
    push ecx
    lea esi, [proc_size * edi]
    mov cx, word [edx + esi + proc.pid]
    pop esi
    cmp ecx, esi
    ja contin
    push eax
    mov eax, esi
    lea esi, [proc_size * ebx]
    mov word [edx + esi + proc.pid], cx
    lea esi, [proc_size * edi]
    mov word [edx + esi + proc.pid], ax
    
    pop eax
contin:
    add edi, 1
    cmp edi, eax
    jle fo_loop2
    add ebx, 1
    cmp ebx, eax
    jle fo_loop1

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY