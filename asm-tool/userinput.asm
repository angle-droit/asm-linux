; userinput.asm - Un programme simple pour démontrer la saisie utilisateur en assembleur Linux x86-64
; Ce programme lit une chaîne de caractères saisie par l'utilisateur et la renvoie à la console.

section .data
    prompt db "Welcome !", 10, " ", 10, "1. Tool info", 10, "2. comparaison d'ages", 10, "99. quit", 10, "[>] "; Message d'invite à afficher
    prompt_len equ $ - prompt                 ; Longueur du message d'invite calculée automatiquement
    buffer db 0                               ; Tampon pour stocker la saisie utilisateur (non utilisé ici)
    buffer_size equ 128                       ; Taille maximale du tampon d'entrée (128 octets)

extern motd
extern ages            

section .bss
    input resb buffer_size                    ; Réserve de l'espace pour stocker la saisie utilisateur

section .text
    global _start                             ; Point d'entrée du programme

_start:
    ; Étape 1 : Affiche le message d'invite sur la sortie standard (stdout)
    mov rax, 1                                ; Appel système : write (code 1)
    mov rdi, 1
    mov rsi, prompt                           ; Adresse du message d'invite à afficher
    mov rdx, prompt_len                       ; Longueur du message d'invite
    syscall                                   ; Appel du noyau pour exécuter l'écriture

    ; Étape 2 : Lit la saisie utilisateur depuis l'entrée standard (stdin)
    mov rax, 0                                ; Appel système : read (code 0)
    mov rdi, 0                                ; Descripteur de fichier : stdin (0)
    mov rsi, input                            ; Adresse du tampon où stocker la saisie utilisateur
    mov rdx, buffer_size                      ; Nombre maximal d'octets à lire (128)
    syscall                                   ; Appel du noyau pour exécuter la lecture

    ; comparer la saisie utilisateur
    cmp byte [input], '1'                    ; Compare le premier caractère de la saisie avec '1'
    je tool1
    cmp byte [input], '2'                    ; Compare le premier caractère de la saisie avec '2'
    je tool2
    cmp byte [input], '99'                    ; Compare le premier caractère de la saisie avec '2'
    je fin

tool1:
    call motd
    jmp _start

tool2:
    call ages
    jmp _start

fin:
    ; Étape 4 : Quitte le programme proprement
    mov rax, 60                               ; Appel système : exit (code 60)
    xor rdi, rdi                              ; Code de retour : 0
    syscall                                   ; Appel du noyau pour quitter

