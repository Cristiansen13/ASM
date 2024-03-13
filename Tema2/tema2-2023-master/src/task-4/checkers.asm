
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    mov edi, eax
    mov eax, ebx
    mov ebx, edi

    mov esi, eax
    mov eax, 8
    mov edx, 0
    mul ebx
    add eax, esi
    mov edx, eax
    mov eax, esi
    

    cmp eax, 7
    je cont 
    cmp ebx, 7
    je cont
    mov byte[ecx + edx + 9], 1

cont:
    cmp eax, 0
    je conti
    cmp ebx, 7
    je conti
    mov byte[ecx + edx + 7], 1

conti:
    cmp eax, 0
    je contin
    cmp ebx, 0
    je contin
    mov byte[ecx + edx - 9], 1
    
contin:
    cmp eax, 7
    je exit 
    cmp ebx, 0
    je exit
    mov byte[ecx + edx - 7], 1
exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY