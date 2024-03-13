%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE
    push edx
    push eax
    mov eax, ebx
    mov edi, 52
    mul edi
    mov esi, eax
    pop eax
    add ecx, esi
    pop edx
    
    push eax
    cmp edx, 0
    je stg
    cmp edx, 1
    je dr
    
stg:
    cmp eax, 0
    je exit

    mov dl, byte [ecx + 26]

    mov edi, 0
for:
    mov bl, byte [ecx + edi + 27]
    mov byte [ecx + edi + 26], bl
    add edi, 1
    cmp edi, 26
    jne for
    mov byte [ecx + 51], dl

    sub eax, 1
    jmp stg

dr:
    cmp eax, 0
    je alt_exit

    mov dl, byte [ecx + 51]

    mov edi, 25
fo:
    mov bl, byte [ecx + edi + 25]
    mov byte [ecx + edi + 26], bl
    sub edi, 1
    cmp edi, 0
    jne fo
    mov byte [ecx + 26], dl
    
    sub eax, 1
    jmp dr

exit:
    xor edi, edi
    pop eax
while:
    cmp edi, 26
    je exi
    mov bl, byte [ecx + edi]
    add bl, al
    cmp bl, 90
    jle conti
    sub bl, 26
conti:
    mov byte [ecx + edi], bl
    inc edi
    jmp while 

alt_exit:
    xor edi, edi
    pop eax
whil:
    cmp edi, 26
    je exi
    mov bl, byte [ecx + edi]
    sub bl, al
    cmp bl, 65
    jae con
    add bl, 26
con:
    mov byte [ecx + edi], bl
    inc edi
    jmp whil 

exi:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY