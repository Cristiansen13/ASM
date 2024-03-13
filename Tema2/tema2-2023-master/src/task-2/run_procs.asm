%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;
struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    push eax

    mov edi, 1
for:
    mov edx, 0
for_t:
    xor eax, eax
    lea esi, [proc_size * edx]
    mov al, byte [ecx + esi + proc.prio]
    cmp eax, edi
    jne cont
    lea esi, [proc_size * edx]
    mov ax, word [ecx + esi + proc.time]
    add dword [prio_result + 4 * edi - 4], 1
    add dword [time_result + 4 * edi - 4], eax
cont:
    add edx, 1
    cmp edx, ebx
    jne for_t
    add edi, 1
    cmp edi, 6
    jne for

    pop eax

    mov edi, 0
for_f:
    push eax
    xor eax, eax
    xor edx, edx
    mov eax, dword [time_result + 4 * edi]
    mov ecx, dword [prio_result + 4 * edi]
    cmp ecx, 0
    je conti
    div ecx
conti:
    mov ecx, eax
    pop eax
    lea esi, [avg_size * edi]
    mov word [eax + esi + avg.quo], cx
    mov word [eax + esi + avg.remain], dx
    add edi, 1
    cmp edi, 5
    jne for_f
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY