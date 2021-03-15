#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF   
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
;variables para el contador:
i equ 0x30
j equ 0x31
k equ 0x32
x equ 0x33
y equ 0x34
z equ 0x35
a equ 0x36
c equ 0x37
d equ 0x38
cont equ 0x39
 ;inicio del programa:
START
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    BCF STATUS, RP1 ;Cambiar al banco 1
    BSF STATUS, RP0
    MOVLW b'00000010' ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB
    BCF STATUS, RP0 ;Regresar al banco 0
    NOP
inicio:
   ; BTFSC PORTB,1
   ; GOTO $+6
    bcf PORTB,0
    call tiempo3
    nop
    bsf PORTB,0
    call tiempo3
;    BTFSS PORTB,1
 ;   GOTO inicio   
    bcf PORTB,0  ;poner el puerto B0 (bit 0 del puerto B) en 0
    call tiempo1 ;llamar a la rutina de tiempo
    call tiempo2
    movlw d'3'
    movwf cont
    DECFSZ cont,f
    goto $-1
    bsf PORTB,0  ;poner el puerto B0 (bit 0 del puerto B) en 1
    call tiempo1 ;llamar a la rutina de tiempo
    call tiempo2
    movlw d'2'
    movwf cont
    DECFSZ cont,f
    goto $-1
    nop
    goto inicio  ;regresar y repetir
 
tiempo3:
movlw d'27' ;establecer valor de la variable i
movwf a
aloop:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
nop
nop
movlw d'50' ;establecer valor de la variable j
movwf c
cloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable k
movwf d
dloop:
decfsz d,f
goto dloop
decfsz c,f
goto cloop
decfsz a,f
goto aloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa
   
tiempo2:
nop ;NOPs de relleno (ajuste de tiempo)
nop
movlw d'54' ;establecer valor de la variable i
movwf x
xloop:
nop ;NOPs de relleno (ajuste de tiempo)
nop
nop
nop
nop
movlw d'50' ;establecer valor de la variable j
movwf y
yloop:
nop ;NOPs de relleno (ajuste de tiempo)
movlw d'60' ;establecer valor de la variable k
movwf z
zloop:
decfsz z,f
goto zloop
decfsz y,f
goto yloop
decfsz x,f
goto xloop
return ;salir de la rutina de tiempo y regresar al
;valor de contador de programa

;rutina de tiempo
tiempo1:
    movlw d'100' ;establecer valor de la variable i
    movwf i
iloop:
    nop
    nop
    nop
    nop
    nop
    movlw d'54' ;establecer valor de la variable j
    movwf j
jloop:
    nop
    nop
    nop
    nop
    movlw d'59' ;establecer valor de la variable k
    movwf k
kloop:   
    decfsz k,f
    goto kloop
    decfsz j,f
    goto jloop
    decfsz i,f
    goto iloop
    movlw d'30'
    movwf j
    decfsz j,f
    goto $-1
    return    ;salir de la rutina de tiempo y regresar al
        ;valor de contador de programa
    END
