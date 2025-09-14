.MODEL SMALL


STACK SEGMENT
    DB 200 DUP(?)
STACK ENDS 


DATA SEGMENT
    NUMQ DW ?  
    MSG1 DB 'ENTER THE QUESTION$'   
    MSG2 DB 'ENTER  NUMBER OF QUESTIONS$'
    MSG3 DB 'ENTER NUMBER OF CHOICES$'
    MSG4 DB 'ENTER THE CHOICE$'
    MSG6 DB 'THE CORRECT ANSWER$'
    MSG7 DB 'THE TIME IN MINUTES$'
    LF DB ?
    QT DB 10
    TIME DW ? 
    COUNTER DB 31H  
    CHT DB 05
    NUMCH DW ?
    COUNTERCH DB 30H
    STARTA DW 0 
    X DW 0
    Y DW 0
    STARTANS DW ?
    BUTTON DW ?
    STARTQ DB ?
    
DATA ENDS

SAVER MACRO 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
SAVER ENDM
SHOWSPACE MACRO
    SAVER
    MOV AH,09
MOV BH,00
MOV AL,20H
MOV CX,1H
MOV BL,0F0H
INT 10H
    LOADR
SHOWSPACE ENDM    

LOADR MACRO
    POP DX
    POP CX
    POP BX
    POP AX
LOAD ENDM    

SHOW MACRO MSG
    SAVER
    MOV AH,09H
    MOV DX, MSG
    INT 21H
    LOADR
ENDM

MOUSECV MACRO
    SAVER
    MOV AX,01
    INT 33H 
    LOADR 
MOUSECV ENDM  

MOUSECI MACRO
    SAVER
    MOV AX,01
    INT 33H 
    LOADR 
MOUSECI ENDM 

SETTINGMB MACRO
    SAVER 
    MOV AX,07
    MOV CX,0
    MOV DX,1
    INT 33H
    MOV AX,08
    MOV CX,0
    MOV DX,1
    INT 33H
    
    
    LOADR
SETTINGMB ENDM



GETCM MACRO
    SAVER
    MOV AX,03
    INT 33H
    MOV X,CX
    MOV Y,DX
    MOV BUTTON,BX
    AND BUTTON,01H
    
    
    LOADR
GETCM ENDM


RESERVECH MACRO OFF
    LOCAL BACK
    SAVER
    MOV AL,CHT 
    MOV [OFF],AL 
    MOV AL,LF
    INC OFF
    MOV [OFF],AL
    MOV AL,CHT
    MOV AH,0 
    MOV CX,AX 
    MOV AL,LF
    INC OFF
    BACK:
        MOV [OFF],AL
        INC OFF
        LOOP BACK
    
    
    
    
    LOADR
RESERVECH ENDM    

GETNUMQ MACRO
    SAVER 
    MOV AH,07H
    INT 21H
    MOV AH,0
    MOV NUMQ,AX 
    AND NUMQ,0FF0FH
    LOADR        
GETNUMQ ENDM

GETNUMCH MACRO
    SAVER 
    MOV AH,07H
    INT 21H
    MOV AH,0
    MOV NUMCH,AX 
    AND NUMCH,0FF0FH
    LOADR        
GETNUMCH ENDM 
    


RESERVE MACRO OFF 
    LOCAL BACK
    SAVER
    MOV AL,QT 
    MOV [OFF],AL 
    MOV AL,LF
    INC OFF
    MOV [OFF],AL
    MOV AL,QT
    MOV AH,0 
    MOV CX,AX 
    MOV AL,LF
    INC OFF
    BACK:
        MOV [OFF],AL
        INC OFF
        LOOP BACK
    
    
    LOADR
    
RESERVE ENDM

CLEARS MACRO
    
    SAVER 
    MOV AX,0600H
    MOV BH,07H
    MOV CX,0000
    MOV DX,184FH
    INT 10H
    LOADR 
CLEARS ENDM
SETC MACRO PARM1,PARM2
    SAVER 
    MOV AH,02H
    MOV BH,00
    MOV DL,PARM1
    MOV DH,PARM2
    INT 10H 
    LOADR
SETC   ENDM

INPUT_S MACRO MSG
    SAVER
    MOV AH,0AH
    MOV DX, MSG
    INT 21H
    LOADR
INPUT_S ENDM

GETCH MACRO
    LOCAL BACK 
    SAVER
    
    CLEARS
    SETC 0,0
    MOV DI,OFFSET MSG3
    SHOW DI
    GETNUMCH
    
    MOV CX,NUMCH 
    MOV [SI],CL 
    INC SI
    BACK:
        PUSH SI
        RESERVECH SI
        POP SI
        CLEARS
        SETC 0,0
        MOV DI,OFFSET MSG4
        SHOW DI
        SETC 0,1 
        INPUT_S SI
        INC SI
        MOV AL,[SI] 
        MOV AH,0
        ADD SI,AX
        INC SI
        MOV [SI],'$'
        INC SI
        LOOP BACK
    
    
    
    
    LOADR
GETCH ENDM

GETQ MACRO
    LOCAL BACK
    SAVER 
    MOV CX,NUMQ
    MOV SI,OFFSET STARTQ
    BACK:
        PUSH SI
        RESERVE SI
        POP SI
        CLEARS
        SETC 0,0
        MOV DI,OFFSET MSG1
        SHOW DI
        SETC 0,1 
        INPUT_S SI
        INC SI
        MOV AL,[SI] 
        MOV AH,0
        ADD SI,AX
        INC SI
        MOV [SI],'$'
        INC SI
        
        GETCH 
        
        
        
        LOOP BACK 
        INC SI
        MOV STARTA,SI
    
    LOADR
GETQ ENDM 

SHOWC MACRO PARAM1 
    SAVER
    MOV AH,02
    
    MOV DL,PARAM1
    INT 21H
    
    LOADR
SHOWC ENDM    

SHOWCH MACRO 
    LOCAL BACK
    SAVER
        
       
        
        
        MOV CL,[DI]
        MOV CH,0 
        
        INC DI
        INC DI
        MOV COUNTERCH,0 
        MOV COUNTER,31H 
        INC BL
        BACK: 
        
        MOV AL,[DI] 
        INC DI
        SETC COUNTERCH,BL
        SHOWC COUNTER  
        INC COUNTERCH
        SETC COUNTERCH,BL
        INC COUNTERCH
        SHOWC '_'
        SETC COUNTERCH,BL
        INC COUNTERCH
        SHOWSPACE
           
        SETC COUNTERCH,BL
        INC COUNTERCH
        SHOW DI
         
        MOV AH,0
        ADD DI,AX
        INC DI
        INC DI 
        
        INC COUNTER 
        ADD COUNTERCH,5
        LOOP BACK
    LOADR
SHOWCH ENDM

GETCA MACRO 
    LOCAL BACK
    SAVER 
    
    MOV SI,STARTA
    MOV CX,NUMQ
    BACK: 
    CLEARS
    SETC 0,0
    MOV DI,OFFSET MSG6
    SHOW DI
    SETC 0,1 
    SHOWC COUNTER
    SETC 1,1
    SHOWC '_'
    SETC 2,1
    SHOWC 20H 
    MOV AH,07H
    INT 21H 
    MOV [SI],AL
    INC SI
    INC COUNTER
    LOOP BACK
    
    
     
    
    
    
    
    MOV COUNTER,31H
    LOADR
GETCA ENDM

GETT MACRO
    LOCAL BACK
    SAVER
    CLEARS
    SETC 0,0
    MOV DI,OFFSET MSG7
    SHOW DI
    SETC 1,1
    INC SI
    MOV [SI],5
    INC SI
    MOV AL,LF
    MOV [SI],AL
    
    DEC SI
    
    INPUT_S SI
    INC SI
    MOV CL,[SI]
    MOV CH,0
    INC SI
    MOV BX,0
    BACK:
    MOV AL,[SI]
    MOV AH,0 
    AND AL,0FH
    
    
    CMP CL,5
    JNZ NEXT
    MOV DX,10000
    MUL DX
    NEXT:
    CMP CL,4
    JNZ NEXT1
    MOV DX,1000
    MUL DX 
    NEXT1:
    CMP CL,3
    JNZ NEXT2
    MOV DX,100
    MUL DX
    NEXT2:
    CMP CL,2
    JNZ NEXT3
    MOV DX,10
    MUL DX
    NEXT3:
    CMP CL,1
    JNZ NEXT4
    MOV DX,1
    MUL DX
    NEXT4:
    ADD BX,AX 
    INC SI
    LOOP BACK
    MOV TIME,BX
    MOV AX,TIME 
    MOV BX,6
    MUL BX
    MOV TIME,AX
    LOADR
GETT ENDM   

DELAY MACRO
    SAVER
    LOCAL BACK
    MOV CX,TIME  
    MOUSECV
    ADD SI,5
    MOV STARTANS,SI
    BACK:
    MOV SI,STARTANS
    GETCM
    CMP BUTTON,1
    JNZ NEXT9
    SUB Y,0013H
    ADD SI,0
    CMP X,0012H
    JNZ NEXT99
    MOV [SI],1
    NEXT99:
    CMP X,8
    JNZ NEXT999
    MOV [SI],2
    NEXT999:
    CMP X,000EH
    JNZ NEXT9999
    MOV [SI],3
    NEXT9999:
    NEXT9:
    LOOP BACK 
    MOUSECI
    SETTINGMB
    LOADR
DELAY ENDM    

PEP MACRO
    LOCAL BACK
    SAVER
    MOV CX,5
    BACK:
    MOV AH,02
    MOV DL,07
    INT 21H
    LOOP BACK   
    LOADR
PEP ENDM    

RESERVECA MACRO
      SAVER
      
      
      LOADR
RESERVECA ENDM
CODE SEGMENT
    MAIN PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX
        MOV DI,OFFSET MSG2
        SHOW DI 
        GETNUMQ
        GETQ
        CLEARS
        GETCA
        GETT
        
        
        MOV BL,1 
        MOV BH,3
        CLEARS
        MOV DI,OFFSET STARTQ
        INC DI
        
        MOV CX,NUMQ
        BACK: 
        
        MOV AL,[DI] 
        INC DI
        SETC 0,BL
        SHOWC COUNTER
        SETC 1,BL
        SHOWC '_'
        SETC 2,BL
        SHOWC 20H   
        SETC 3,BL
        SHOW DI
         
        MOV AH,0
        ADD DI,AX
        INC DI
        PUSH AX
        MOV AL,COUNTER
        PUSH AX
        SHOWCH
        POP AX
        MOV COUNTER,AL
        POP AX
        
        INC BL
        INC BL
        INC COUNTER
        
        
        LOOP BACK
        
        DELAY
        
        PEP 
        CLEARS
        
        
        
        
        
        
        MOV AH,4CH
        INT 21H
        
        
        
     MAIN ENDP
    
    END MAIN 
CODE ENDS    
