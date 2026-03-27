DATA SEGMENT
STR     DB 50 DUP(?)
REV     DB 50 DUP(?)
N       DB ?
MSG1    DB 0DH,0AH,'Enter a string: $'
MSG2    DB 0DH,0AH,'String is Palindrome $'
MSG3    DB 0DH,0AH,'String is not Palindrome $'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX

    ; Display message
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H

    ; Read string
    LEA SI, STR
    CALL READSTRING

    ; Length of string in CL
    MOV N, CL

    ; Reverse string
    DEC SI              ; Point to last character
    LEA DI, REV
    MOV CH, 00
    MOV CL, N

REVERSE:
    CMP CL, 0
    JZ CHECK

    MOV AL, [SI]
    MOV [DI], AL
    DEC SI
    INC DI
    DEC CL
    JMP REVERSE

CHECK:
    LEA SI, STR
    LEA DI, REV
    MOV CL, N
    SHR CL, 1           ; Compare half length

COMPARE:
    CMP CL, 0
    JZ EQUAL

    MOV AL, [SI]
    MOV BL, [DI]
    CMP AL, BL
    JNE NOTEQUAL

    INC SI
    INC DI
    DEC CL
    JMP COMPARE

EQUAL:
    MOV AH, 09H
    LEA DX, MSG2
    INT 21H
    JMP EXIT

NOTEQUAL:
    MOV AH, 09H
    LEA DX, MSG3
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

; -------------------------
; READSTRING PROCEDURE
; -------------------------
READSTRING PROC
    MOV CL, 0

READ:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH         ; Enter key?
    JE DONE

    MOV [SI], AL
    INC SI
    INC CL
    JMP READ

DONE:
    RET
READSTRING ENDP

CODE ENDS
END START
