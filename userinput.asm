; userinput.asm - Un programme simple pour démontrer la saisie utilisateur en assembleur Linux x86-64
; Ce programme lit une chaîne de caractères saisie par l'utilisateur et la renvoie à la console.

section .data
    prompt db "Entrez une chaîne : ", 10, "1. Imprimer un premier texte" 0       ; Message d'invite affiché à l'utilisateur
    prompt_len equ $ - prompt                 ; Longueur du message d'invite calculée automatiquement
    buffer db 0                               ; Tampon pour stocker la saisie utilisateur (non utilisé ici)
    buffer_size equ 128                       ; Taille maximale du tampon d'entrée (128 octets)

section .bss
    input resb buffer_size                    ; Réserve de l'espace pour stocker la saisie utilisateur

section .text
    global _start                             ; Point d'entrée du programme

_start:
    ; Étape 1 : Affiche le message d'invite sur la sortie standard (stdout)
    mov rax, 1                                ; Appel système : write (code 1)
    mov rdi, 1                                ; Descripteur de fichier : stdout (1)
    mov rsi, prompt                           ; Adresse du message d'invite à afficher
    mov rdx, prompt_len                       ; Longueur du message d'invite
    syscall                                   ; Appel du noyau pour exécuter l'écriture

    ; Étape 2 : Lit la saisie utilisateur depuis l'entrée standard (stdin)
    mov rax, 0                                ; Appel système : read (code 0)
    mov rdi, 0                                ; Descripteur de fichier : stdin (0)
    mov rsi, input                            ; Adresse du tampon où stocker la saisie utilisateur
    mov rdx, buffer_size                      ; Nombre maximal d'octets à lire (128)
    syscall                                   ; Appel du noyau pour exécuter la lecture

    ; Étape 3 : Vérifie le premier caractère de la saisie utilisateur pour un choix
    mov al, byte [input]                      ; Charge le premier caractère de la saisie utilisateur
    cmp al, '1'                               ; Compare avec '1'
    je choix_1                                ; Si égal à '1', va à choix_1
    cmp al, '2'                               ; Compare avec '2'
    je choix_2                                ; Si égal à '2', va à choix_2
    jmp fin                                   ; Sinon, termine le programme

choix_1:
    ; Code pour le choix 1
    mov rax, 1                                ; Appel système : write (code 1)
    mov rdi, 1                                ; Descripteur de fichier : stdout (1)
    lea rsi, [msg_choix_1]                    ; Adresse du message pour le choix 1
    mov rdx, msg_choix_1_len                  ; Longueur du message
    syscall                                   ; Appel du noyau pour afficher le message
    jmp _start                                ; retourne a _start pour recommencer

choix_2:
    ; Code pour le choix 2
    mov rax, 1                                ; Appel système : write (code 1)
    mov rdi, 1                                ; Descripteur de fichier : stdout (1)
    lea rsi, [msg_choix_2]                    ; Adresse du message pour le choix 2
    mov rdx, msg_choix_2_len                  ; Longueur du message
    syscall                                   ; Appel du noyau pour afficher le message
    jmp _start                                ; Termine le programme

fin:
    ; Étape 4 : Quitte le programme proprement
    mov rax, 60                               ; Appel système : exit (code 60)
    xor rdi, rdi                              ; Code de retour : 0
    syscall                                   ; Appel du noyau pour quitter

section .data
    msg_choix_1 db "Vous avez choisi l'option 1.", 0xA
    msg_choix_1_len equ $ - msg_choix_1
    msg_choix_2 db "Vous avez choisi l'option 2.", 0xA
    msg_choix_2_len equ $ - msg_choix_2


