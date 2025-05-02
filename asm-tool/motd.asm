section .text
    global motd                             ; Point d'entrée du programme

motd:
    ; Étape 1 : Affiche le message d'invite sur la sortie standard (stdout)
    mov rax, 1                                ; Appel système : write (code 1)
    mov rdi, 1                                ; Descripteur de fichier : stdout (1)
    mov rsi, motdfile                        ; Adresse du message d'invite à afficher
    mov rdx, motdfile_len                    ; Longueur du message d'invite
    syscall                                   ; Appel du noyau pour exécuter l'écriture

    ; Étape 2 : Lit la saisie utilisateur depuis l'entrée standard (stdin)
    mov rax, 0                                ; Appel système : read (code 0)
    mov rdi, 0                                ; Descripteur de fichier : stdin (0)
    mov rsi, input                            ; Adresse du tampon où stocker la saisie utilisateur
    mov rdx, buffer_size                      ; Nombre maximal d'octets à lire (128)
    syscall                                   ; Appel du noyau pour exécuter la lecture

section .data
    motdfile db "ASM multi tool !", 10, "Author: Axel (angle-droit)", 10, "version: 1.0", 10
    motdfile_len equ $ - motdfile              ; Longueur du message d'invite
    buffer_size equ 128                       ; Taille maximale du tampon d'entrée (128 octets)
    input resb buffer_size                    ; Réserve de l'espace pour stocker la saisie utilisateur