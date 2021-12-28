.286
.model huge
.stack 64

.data

;dimensions of the screen
row dw 0
col dw 0


; colors
WHITE EQU 0FH
RED EQU 0CH
YELLOW EQU 0EH
BLACK EQU 0H
GRAY EQU 7H
LBLUE EQU 9H
DBLUE EQU 1H


;data for the char to draw (x,y,char,color)
charToDraw db ?
charToDrawColor db ?
charToDrawx db ?
charToDrawy db ?

myName db 'Zeyad$'
otherName db 'Beshoy$'
;global variable for printing line (x)
linex dw ?

;position of my registers
myAXx db 3h
myAXy db 3h
myBXx db 3h
myBXy db 4h
myCXx db 3h
myCXy db 6h
myDXx db 3h
myDXy db 7h
mySIx db 0Bh
mySIy db 3h
myDIx db 0Bh
myDIy db 4h
mySPx db 0Bh
mySPy db 6h
myBPx db 0Bh
myBPy db 7h
;position of my memory
myMemx db 10h
;other's register positions
otherAXx db 18h
otherAXy db 3h
otherBXx db 18h
otherBXy db 4h
otherCXx db 18h
otherCXy db 6h
otherDXx db 18h
otherDXy db 7h
otherSIx db 20h
otherSIy db 3h
otherDIx db 20h
otherDIy db 4h
otherSPx db 20h
otherSPy db 6h
otherBPx db 20h
otherBPy db 7h
;position of other memory
otherMemx db 24h

;variables for postioning
printX db ?
printY db ?

;my registers data needed
;dummy variable to help printing
RegStringToPrint db 4 dup(?)
MemStringToPring db 2 dup(?)
ASC_TBL DB   '0','1','2','3','4','5','6','7','8','9'
        DB   'A','B','C','D','E','F'

;              AX    , BX   , CX   , DX   , SI   , DI   , BP   , SP
myRegisters dw 0F4FEH, 1034h, 154Fh, 57FEh, 5ADFh, 1254h, 0010h, 1000h
;                 AX   , BX   , CX   , DX   , SI   , DI   , BP    , SP
otherRegisters dw 1034h, 1034h, 1000h, 57FEh, 5ADFh, 0F4FEH, 0010h, 1254h

myMemory db 12h,54h,43h,56h,88h,75h,54h,0FDh,75h,13h,57h,86h,11h,58h,0FFh,5Fh

otherMemory db 13h,66h,43h,56h,88h,0FFh,54h,33h,75h,13h,57h,86h,11h,0FDh,77h,5Fh


;function to draw the background color of the main screen
drawBackGround MACRO
LOCAL rowLoop 
  rowLoop:
  mov ah, 0ch    ;write pixels on screen
  mov bh, 0      ;page
  mov dx, row    ;row
  mov cx, col    ;column
  mov al, GRAY   ;colour
  int 10h
  ;need to mov the row 
  inc col
  mov ax,col
  mov dx,320d
  cmp ax,dx
  jnz rowLoop
  mov col,0
  inc row
  mov ax,row
  mov dx,200d
  cmp ax,dx
  jnz rowLoop
ENDM


;function to draw a given char at given location with given color
drawCharWithGivenVar  MACRO
  ;set the cursur
  mov ah,2
  mov dl,charToDrawx      ;x
  mov dh,charToDrawy      ;y
  mov bh,0
  int 10h
  ;draw the char
  mov  al, charToDraw
  mov  bl, charToDrawColor
  mov  bh, 0                ;Display page
  mov  ah, 0Eh              ;Teletype
  int  10h
ENDM

;function to draw memory lines (called once at the begining)
drawMemoryLines MACRO
  ;draw the memory lines
  mov linex,125d
  drawLine
  mov linex,147d
  drawLine
  mov linex,162d
  drawLine
  mov linex,287d
  drawLine
  mov linex,307d
  drawLine
ENDM
drawLine macro
LOCAL LineLoop
  mov di,0
  LineLoop:
  mov ah, 0ch     ;write pixels on screen
  mov bh, 0       ;page
  mov dx, di      ;row
  mov cx, linex   ;column
  mov al, BLACK   ;colour
  int 10h
  inc di
  mov ax,200d
  cmp di,ax
  jnz LineLoop
endm

;function to draw the register names (AX,BX,..etc)
drawRegNames MACRO
  ;draw my
  mov charToDraw,'A'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myAXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'B'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myBXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'C'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myCXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'D'
  mov charToDrawColor,WHITE
  mov charToDrawx,0
  mov al,myDXy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,15h
  drawCharWithGivenVar
  mov charToDraw,'X'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,1
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'S'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,mySIy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'I'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'D'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,myDIy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'I'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'S'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,mySPy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'P'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar

  ;draw my
  mov charToDraw,'B'
  mov charToDrawColor,WHITE
  mov charToDrawx,8
  mov al,myBPy
  mov charToDrawy,al
  drawCharWithGivenVar
  ;draw other
  mov charToDrawx,1Dh
  drawCharWithGivenVar
  mov charToDraw,'P'
  inc charToDrawx
  drawCharWithGivenVar
  mov charToDrawx,9
  drawCharWithGivenVar
ENDM

;function to draw the memory adresses
drawMemoryAdresses MACRO 
mov charToDraw,'0'
mov charToDrawColor, LBLUE
mov charToDrawx,27h
mov charToDrawy,0
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'1'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'2'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'3'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'4'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'5'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'6'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'7'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'8'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'9'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'A'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'B'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'C'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'D'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'E'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar

mov charToDrawx,27h
mov charToDraw,'F'
inc charToDrawy
drawCharWithGivenVar
mov charToDrawx,13h
drawCharWithGivenVar
ENDM

;function to convert the hexa number to string to display (need ax=num)
convertRegToStr macro
  lea si,RegStringToPrint
  mov bx,4096
  mov dx,0
  div bx
  ;dx=num
  ;al=num to print      
  lea bx, ASC_TBL
  XLAT
  mov [si],al
  inc si
  
  mov ax,dx
  mov dx,0
  mov bx,256
  div bx
  lea bx, ASC_TBL
  XLAT
  mov [si],al
  inc si

  mov ax,dx
  mov dx,0
  mov bx,16
  div bx
  ;al=num to print      
  lea bx, ASC_TBL
  XLAT
  mov [si],al
  inc si

  mov al,dl
  lea bx, ASC_TBL
  XLAT
  mov [si],al
endm

;function to convert the hexa number to string to display (need al=num, ah=0)
convertMemToStr macro
  lea si,MemStringToPring
  mov bl,16d
  div bl
  ;al=num to print      
  lea bx, ASC_TBL
  XLAT
  mov [si],al
  inc si
  mov al,ah
  lea bx, ASC_TBL
  XLAT
  mov [si],al
endm

;functions to draw my registers data
drawMyRegisters macro
  ;first we need to get the number (4-bytes) and covert it to char
  ;then move it to charToDraw and pick a color and postions then draw
  
  ;print AX
  mov ax,myRegisters
  convertRegToStr
  mov al,myAXx
  mov printX,al
  mov al,myAXy
  mov printY,al
  printRegWithGivenVar

  ;print BX
  mov ax,myRegisters+2
  convertRegToStr
  mov al,myBXx
  mov printX,al
  mov al,myBXy
  mov printY,al
  printRegWithGivenVar

  ;print CX
  mov ax,myRegisters+4
  convertRegToStr
  mov al,myCXx
  mov printX,al
  mov al,myCXy
  mov printY,al
  printRegWithGivenVar

  ;print DX
  mov ax,myRegisters+6
  convertRegToStr
  mov al,myDXx
  mov printX,al
  mov al,myDXy
  mov printY,al
  printRegWithGivenVar

  ;print SI
  mov ax,myRegisters+8
  convertRegToStr
  mov al,mySIx
  mov printX,al
  mov al,mySIy
  mov printY,al
  printRegWithGivenVar

  ;print DI
  mov ax,myRegisters+10d
  convertRegToStr
  mov al,myDIx
  mov printX,al
  mov al,myDIy
  mov printY,al
  printRegWithGivenVar

  ;print BP
  mov ax,myRegisters+12d
  convertRegToStr
  mov al,myBPx
  mov printX,al
  mov al,myBPy
  mov printY,al
  printRegWithGivenVar

  ;print SP
  mov ax,myRegisters+14d
  convertRegToStr
  mov al,mySPx
  mov printX,al
  mov al,mySPy
  mov printY,al
  printRegWithGivenVar
endm
;functions to draw other registers data
drawOtherRegisters macro
;print AX
  mov ax,OtherRegisters
  convertRegToStr
  mov al,otherAXx
  mov printX,al
  mov al,otherAXy
  mov printY,al
  printRegWithGivenVar

  ;print BX
  mov ax,otherRegisters+2
  convertRegToStr
  mov al,otherBXx
  mov printX,al
  mov al,otherBXy
  mov printY,al
  printRegWithGivenVar

  ;print CX
  mov ax,otherRegisters+4
  convertRegToStr
  mov al,otherCXx
  mov printX,al
  mov al,otherCXy
  mov printY,al
  printRegWithGivenVar

  ;print DX
  mov ax,otherRegisters+6
  convertRegToStr
  mov al,otherDXx
  mov printX,al
  mov al,otherDXy
  mov printY,al
  printRegWithGivenVar

  ;print SI
  mov ax,otherRegisters+8
  convertRegToStr
  mov al,otherSIx
  mov printX,al
  mov al,otherSIy
  mov printY,al
  printRegWithGivenVar

  ;print DI
  mov ax,otherRegisters+10d
  convertRegToStr
  mov al,otherDIx
  mov printX,al
  mov al,otherDIy
  mov printY,al
  printRegWithGivenVar

  ;print BP
  mov ax,otherRegisters+12d
  convertRegToStr
  mov al,otherBPx
  mov printX,al
  mov al,otherBPy
  mov printY,al
  printRegWithGivenVar

  ;print SP
  mov ax,otherRegisters+14d
  convertRegToStr
  mov al,otherSPx
  mov printX,al
  mov al,otherSPy
  mov printY,al
  printRegWithGivenVar
endm

printRegWithGivenVar MACRO

  mov al,printX
  mov charToDrawx,al
  mov al,printY
  mov charToDrawy,al
  mov charToDrawColor,YELLOW

  lea si,RegStringToPrint
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar


  inc charToDrawx
  inc si
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar


  inc charToDrawx
  inc si
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar


  inc charToDrawx
  inc si
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar
ENDM

printMemWithGivenVar macro
  mov al,printX
  mov charToDrawx,al
  mov al,printY
  mov charToDrawy,al
  mov charToDrawColor,RED

  lea si,MemStringToPring
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar

  inc charToDrawx
  inc si
  mov al,[si]
  mov charToDraw,al
  drawCharWithGivenVar
endm

;functions to draw my memory data
drawMyMemory macro
LOCAL MyMemLoop,MyMemLoopH,myMemExit
  lea di,myMemory
  mov cx,15d
  add di,cx
  MyMemLoop:
  mov ah,0
  mov al,[di]
  convertMemToStr
  mov al,myMemx
  mov printX,al
  mov al,cl
  mov printY,al
  printMemWithGivenVar
  dec di
  LOOP MyMemLoopH
  jmp myMemExit
  MyMemLoopH: jmp MyMemLoop
  myMemExit:

  mov ah,0
  mov al,[di]
  convertMemToStr
  mov al,myMemx
  mov printX,al
  mov al,0
  mov printY,al
  printMemWithGivenVar
endm
;functions to draw other memory data
drawOtherMemory macro
LOCAL OtherMemLoop,OtherMemLoopH,otherMemExit
  lea di,otherMemory
  mov cx,15d
  add di,cx
  OtherMemLoop:
  mov ah,0
  mov al,[di]
  convertMemToStr
  mov al,otherMemx
  mov printX,al
  mov al,cl
  mov printY,al
  printMemWithGivenVar
  dec di
  LOOP OtherMemLoopH
  jmp otherMemExit
  OtherMemLoopH: jmp OtherMemLoop
  otherMemExit:

  mov ah,0
  mov al,[di]
  convertMemToStr
  mov al,otherMemx
  mov printX,al
  mov al,0
  mov printY,al
  printMemWithGivenVar
endm

; Function to print the two names
printTwoNames MACRO 
  ;set cursor
  mov ah,2
  mov dl,3h
  mov dh,0Dh 
  mov bh,0
  int 10h
  ; print name
  lea dx,myName
  mov ah,9
  int 21h
  ;set cursor
  mov ah,2
  mov dl,18h
  mov dh,0Dh 
  mov bh,0
  int 10h
  ; print name
  lea dx,otherName
  mov ah,9
  int 21h
  
ENDM


.code
main proc
  mov ax,@data
  mov ds,ax
  mov es,ax

  ;set video mode   (320x200)
  mov ah, 00h
  mov al, 13h     
  int 10h 

  drawBackGround
  
  drawRegNames
  drawMemoryAdresses
  drawMemoryLines
  printTwoNames


  ;for the main loop,   note: outside the loop called one time
  home:

  drawMyRegisters
  drawOtherRegisters
  drawMyMemory
  drawOtherMemory

  
  jmp home
  hlt
main endp
end main