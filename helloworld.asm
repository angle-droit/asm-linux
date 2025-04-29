section .data
    ; Section des données (stocke les données statiques utilisées par le programme)
    msg db 'Hello, World!', 0  
    
    ; Déclare une chaîne de caractères terminée par un octet nul, par exemple "msg" correspond à l'adresse de la chaîne
    ; db signifie "define byte", et 0 est le caractère nul (terminateur de chaîne)
    ; "Hello, World!" est la chaîne de caractères à afficher
    ; msg est l'étiquette qui représente l'adresse de la chaîne

    msg_len equ $ - msg  

    ; Calcule la longueur de la chaîne (adresse actuelle - adresse de msg)
    ; msg_len est une constante qui représente la longueur de la chaîne
    ; equ signifie "équivalent à" et est utilisé pour définir des constantes
    ; $ représente l'adresse actuelle dans la section .data
    ; msg est l'étiquette qui représente l'adresse de la chaîne

section .text
    ; Section du code (contient les instructions exécutables)
    global _start              
    ; Rend l'étiquette _start accessible au linker comme point d'entrée
    ; global signifie que l'étiquette est accessible à partir d'autres fichiers
    ; _start est le point d'entrée du programme, où l'exécution commence

_start:
    ; Écrire le message sur la sortie standard (stdout)

    mov rax, 1         

    ; Place le numéro de l'appel système pour sys_write (1) dans rax
    ; mov est une instruction qui déplace une valeur dans un registre
    ; rax est le registre qui contient le numéro de l'appel système
    ; 1 est le numéro de l'appel système pour écrire sur la sortie standard
    ; syscall est une instruction qui effectue un appel système

    mov rdi, 1

    ; Place le descripteur de fichier pour stdout (1) dans rdi
    ; rdi est le registre qui contient le descripteur de fichier
    ; 1 est le descripteur de fichier pour la sortie standard (stdout)
    ; stdout est le flux de sortie standard, généralement la console

    mov rsi, msg

    ; Place l'adresse du message (msg) dans rsi
    ; rsi est le registre qui contient l'adresse du message
    ; msg est l'étiquette qui représente l'adresse de la chaîne

    mov rdx, msg_len           
    
    ; Place la longueur du message (msg_len) dans rdx
    ; rdx est le registre qui contient la longueur du message
    ; msg_len est une constante qui représente la longueur de la chaîne

    syscall 

    ; Effectue l'appel système pour écrire le message

    ; Quitter le programme
    mov rax, 60

    ; Place le numéro de l'appel système pour sys_exit (60) dans rax
    ; 60 est le numéro de l'appel système pour quitter le programme

    xor rdi, rdi
                   
    ; Définit le code de sortie à 0 en mettant rdi à 0
    ; xor est une instruction qui effectue une opération XOR entre deux registres
    ; rdi est le registre qui contient le code de sortie
    ; 0 est le code de sortie (succès)
    ; xor rdi, rdi met rdi à 0 (code de sortie 0)

    syscall                    ; Effectue l'appel système pour quitter le programme
