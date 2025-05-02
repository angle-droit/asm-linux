section .data
    input db "Quel est ton age ? ", 0
    input_len equ $ - input
    buffer db 0
    buffer_size equ 128
    minor db "Tu es mineur !", 10, 0
    minor_len equ $ - minor
    major db "Tu es majeur !", 10, 0
    major_len equ $ - major

section .bss
    age resb buffer_size                    

section .text
    global ages
    
ages:
    ; Display the prompt message
    mov rax, 1
    mov rdi, 1
    mov rsi, input
    mov rdx, input_len
    syscall                            

    ; Read user input
    mov rax, 0                                
    mov rdi, 0                  ; File descriptor: stdin (0)              
    mov rsi, age                ; Address of the buffer to store user input                            
    mov rdx, buffer_size        ; Maximum number of bytes to read                      
    syscall

    ; Check if the input is empty
    xor rbx, rbx                ; Clear rbx to store the parsed number
    xor rcx, rcx                ; Clear rcx to use as a multiplier
    mov rsi, age                ; Point to the input buffer

parse_loop:
    mov al, byte [rsi]          ; Load the current character
    cmp al, 10                  ; Check for newline (end of input)
    je parse_done               ; If newline, parsing is done
    sub al, '0'                 ; Convert ASCII to integer
    imul rbx, rbx, 10           ; Multiply current number by 10
    add rbx, rax                ; Add the new digit
    inc rsi                     ; Move to the next character
    jmp parse_loop              ; Repeat the loop

parse_done:
    mov eax, ebx                ; Store the parsed number in eax
    cmp eax, 18               
    jge ifequal18

ifnotequal18:
    mov rax, 1
    mov rdi, 1
    mov rsi, minor
    mov rdx, minor_len
    syscall
    ret

ifequal18:
    mov rax, 1
    mov rdi, 1
    mov rsi, major
    mov rdx, major_len
    syscall
    ret