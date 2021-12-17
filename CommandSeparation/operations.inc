;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Wrote by: Beshoy Morad                                          
;; parameters:                    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

execute macro numofoper,invalidflag,destination,source
LOCAL checkDS,OMOV,OADD,OADC,OSUB,OSBB,OXOR,OAND,ONOP,OCLC,invalid,EXIT
    
    ;check if the operation is valid or no
    mov al,invalidOperationFlag
    mov dl,1
    cmp al,dl
    jz EXIT
        
    ;compare the code of the operation to go to the block of that command
    mov al,numofoper
    mov dl,1h            
    cmp al,dl            ;code=1 for mov
    jz OMOV
    
    inc dl
    cmp al,dl
    jz OADD              ;code=2 for add
    
    inc dl
    cmp al,dl
    jz OADC              ;code=3 for adc
    
    inc dl
    cmp al,dl
    jz OSUB              ;code=4 for sub
    
    inc dl
    cmp al,dl
    jz OSBB              ;code=5 for sbb
    
    inc dl
    cmp al,dl
    jz OXOR              ;code=6 for xor
        
    inc dl
    cmp al,dl
    jz OAND              ;code=7 for and
        
    inc dl
    cmp al,dl
    jz ONOP              ;code=8 for nop
        
    inc dl
    cmp al,dl
    jz OCLC              ;code=11 for clc
    
    
    ;for the mov
    OMOV:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
        
    ;for the add
    OADD:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
    
    ;for the adc
    OADC:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
        
    ;for the sub
    OSUB:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
    
    ;for the sbb
    OSBB:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
    
    ;for the xor
    OXOR:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
    
    ;for the and
    OAND:
        ;need to check if there is destination and source first
        jmp checkDS
        
        ;check the flag if equal 1 then invalid --> exit
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jz EXIT
        
        ;else
        ;now we need to check the destination it self if it valid
        
        
        ;if yes check the source
        
        ;if yes get the register from the variables section 
        ;and perform the operation on them
        ;then put the results back to the register variables
        jmp EXIT
        
    ;for the nop
    ONOP:
        ;need to check that there is no destination and source
        jmp checkDS
        
        ;check the flag if equal 1 then it is valid 
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jnz EXIT:
        
        ;note we need to turn the flag back off
        mov invalidflag,0
        
        ;this operation do nothing
        
        jmp EXIT
        
    ;for the clc
    OCLC:
        ;need to check that there is no destination and source
        jmp checkDS
        
        ;check the flag if equal 1 then it is valid 
        mov al,invalidflag
        mov dl,1
        cmp al,dl
        jnz EXIT:
        
        ;note we need to turn the flag back off
        mov invalidflag,0
        
        ;get the carry variable and set it to zero
        
        
        jmp EXIT
    
    checkDS:
    ;check the destination
    mov al,destination
    mov dl,24h         ;check if the first char is $ (no destination)
    cmp al,dl
    jz invalid         ;invalid operation then turn on the flag and exit
        
    mov dl,0DH         ;check if the first char is enter (no destination)
    cmp al,dl
    jz invalid         ;invalid operation then turn on the flag and exit
        
    ;else, there is a destination
    ;now check the source
    mov al,source
    mov dl,24h         ;check if the first char is $ (no source)
    cmp al,dl
    jz invalid         ;invalid operation then turn on the flag and exit
        
    mov dl,0DH         ;check if the first char is enter (no source)
    cmp al,dl
    jz invalid         ;invalid operation then turn on the flag and exit    
    ;else, there is a source
    jmp EXIT
    
    invalid:
        mov invalidflag,1
        jmp EXIT:
    EXIT:
           
endm