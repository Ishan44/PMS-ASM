org 100h 
.model small
.stack 100h
.data 
fname db 'reccordd.txt',0
fhandle dw ?        
buffer db 100 dup<'$'>
sun db 'Sunday     *$'
mon db 'Monday     *$'
tue db 'Tuesday    *$'    
wed db 'Wednesday  *$'
thu db 'Thursday   *$'
fri db 'Friday     *$'
sat db 'Saturday   *$'
menu db  '*  !Parking Management System! Day:$'
star db  '***********************************************$' 
ch1 db   '*  Enter 1 for Bike                           *$'
ch2 db   '*  Enter 2 for Car                            *$'
ch3 db   '*  Enter 3 for Jeep                           *$'
ch4 db   '*  Enter 4 to Display vehicles parked         *$'
ch5 db   '*  Enter 5 to Delete the record               *$' 
ch6 db   '*  Enter 6 to save Data to file               *$' 
ch7 db   '*  Enter 7 to exit the Program                *$'
save db 'Saving...$'                                    
sav db '---Parking record saved successfully to file---$'
tim db 'Entry Time: $' 
uc db 'Your Choice: $'
pric db 'Ticket Cost: $'
m1 db '---SORRY! PARKING FULL---$'
m2 db 'Invalid Entry!$'
m3 db 'Total Amount Collected=$'
m4 db 'Total Numbers of Vehicles Parked In Garage=$'
m5 db 'Total Number of Bikes Present/Parked=$'
m6 db 'Total Number of Cars Present/Parked=$'
m7 db 'Total Number of Jeeps Present/Parked=$'
m8 db '---history RESET Successfully---$'
tot db 'Parking space available: $'
amt dw 0    ;Total amount      
numtoprint db '$$$$$' ;for file handling
count dw  '0'  ;total no of vehicles entered
maxVe dw '4'   ;Max vehicles 2+1, index starts from 0, adjusted 
pSpace dw '4' ;for parking space 

bikePrice dw 100
carPrice dw 125
jeepPrice dw 150

b dw '0'  ;no of bike
c db '0'  ;no of cars
j db '0'  ;no of jeep   

endll   db  0Dh,0Ah 

.code
main proc    ;main procedure
mov ax,@data  ;load starting address of data segment
mov ds,ax 
dec maxVe   

;Create a new file
;mov ah,3ch
;lea dx,fname
;mov cl,1
;int 21h
;mov fhandle,ax


;close a file
;mov ah,3eh
;mov bx,fhandle
;int 21h  

;Open existing fiile
mov ah,3dh
lea dx, fname  
mov al,2 ;both reading and writing
int 21h
mov fhandle, ax

mov ah,42h
mov bx,fhandle
xor cx,cx
xor dx,dx
mov al,2   ;set pointer to the end
int 21h  





menuu:   
             ;print a line    
mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h

mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



lea dx, star
mov ah,9  
int 21h

mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h


lea dx, menu
mov ah,9  ;write string to stdo
int 21h

;SHOW DATE
mov ah, 2ah
int 21h 
;mov al,3 


cmp al,0  ;Day is stored in al
je s
cmp al,1
je m
cmp al,2
je t
cmp al,3
je w
cmp al,4
je th
cmp al,5
je f
cmp al,6
je sa
ct: 


mov dx,10 ;new line
mov ah,2  ;write character to stdout
int 21h
mov dx,13 ;carriage return 13 if this is not written then the new line will be pushed way off
mov ah,2
int 21h
            
            
lea dx, star
mov ah,9  
int 21h

mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h



lea dx, ch1
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


lea dx, ch2
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



lea dx, ch3
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


lea dx, ch4
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h



lea dx, ch5
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h


lea dx, ch6
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h            


lea dx, ch7
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h




lea dx, star
mov ah,9  
int 21h

mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h    

lea dx,tot     ;total no of vehicles parked
mov ah,9
int 21h

mov dx,pSpace
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

mov dx,10 
mov ah,2  
int 21h
mov dx,13 
mov ah,2
int 21h

lea dx, uc
mov ah,9  
int 21h



;Take input from user

mov ah,1   ;read character
int 21h
mov bl,al
mov dx,10  ;new line
mov ah,2   ;display
int 21h
mov dx,13  ;carriage return
mov ah,2
int 21h

;switch case
mov al,bl
cmp al,'1'
je bik
cmp al,'2'
je car
cmp al,'3'
je jeep
cmp al,'4'
je rec
cmp al,'5'
je del
cmp al,'7'
je eixtt 

cmp al,'6'
je filee



lea dx, m2  ;wrong input
mov ah,9 ;write string
int 21h

mov dx,10    ;new line
mov ah,2
int 21h
mov dx,13   ;cret
mov ah,2
int 21h
jmp menuu

bik:
call bike   ;call procedure


car:
call cars     ;call procedure


rec:
call history


del:
call delt


jeep:
call jeepp



eixtt:  
mov ah,3eh
mov bx,fhandle
int 21h  
mov ah,4ch
int 21h

main endp    ;end main procedure





bike proc 
mov ax,maxVe    ;Max vehicle to be stored
cmp count, ax   
jle bikee
lea dx, m1
mov ah,9
int 21h
jmp menuu
jmp eixtt

bikee:

lea dx, pric
mov ah,9
int 21h   

mov ax,bikePrice  ;price for bike
add amt, ax
mov dx,0 ; set initial remainder to 0
mov bx,10 
mov cx,0 
dec pSpace


it2:   ;iterate
        div bx    ;200/10
        push dx   ;stores remainder in the stack in the stack
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne it2
   
ds3:    ;display
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop ds3    ; loop instruction decrements cx and jumps to label if not 0
inc count
inc b   

;Show Time
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h 

lea dx, tim
mov ah,9
int 21h    

HOUR:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CH     ; Hour CH
AAM           ; The AAM instruction divides the AL register by 10, leaving the quotient in AH and the remainder in AL
MOV BX,AX     ; Bx has hr
CALL DISP

MOV DL,':'
MOV AH,02H    
INT 21H


MINUTES:
MOV AH,2CH    
INT 21H
MOV AL,CL     ; Minutes CL
AAM
MOV BX,AX
CALL DISP

MOV DL,':'   
MOV AH,02H
INT 21H


Seconds:
MOV AH,2CH    
INT 21H
MOV AL,DH     ;Seconds is in DH
AAM
MOV BX,AX
CALL DISP

jmp cnt     ;So that Seconds Doesnt get displayed twice

DISP PROC
MOV DL,BH      ; Since the values are in BX, BH Part
ADD DL,48     
MOV AH,2     
INT 21H
MOV DL,BL      ; BL Part 
ADD DL,48     
MOV AH,2
INT 21H
RET
DISP ENDP      ; End Disp Procedure

cnt:

jmp menuu
jmp eixtt


cars proc 
    mov ax,maxVe 
cmp count, ax
jle carr
lea dx, m1
mov ah,9
int 21h
jmp menuu


carr:
lea dx, pric
mov ah,9
int 21h 
mov ax,carPrice ;price of car
add amt, ax
mov dx,0
mov bx,10
mov cx,0
dec pSpace
it22:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
       jne it22
   
ds33:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop ds33


inc count
inc c    

;Show Time
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h 

lea dx, tim
mov ah,9
int 21h    

;HOUR:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CH     ; Hour CH
AAM           ; The AAM instruction divides the AL register by 10, leaving the quotient in AH and the remainder in AL
MOV BX,AX     ; Bx has hr
CALL DISP

MOV DL,':'
MOV AH,02H    
INT 21H


;MINUTES:
MOV AH,2CH    
INT 21H
MOV AL,CL     ; Minutes CL
AAM
MOV BX,AX
CALL DISP

MOV DL,':'   
MOV AH,02H
INT 21H


;Seconds:
MOV AH,2CH    
INT 21H
MOV AL,DH     ;Seconds is in DH
AAM
MOV BX,AX
CALL DISP

jmp cntt     ;So that Seconds Doesnt get displayed twice

cntt:
jmp menuu


jeepp proc 
    mov ax,maxVe 
cmp count, ax
jle jeep1
lea dx, m1
mov ah,9
int 21h
jmp menuu


jeep1:
lea dx, pric
mov ah,9
int 21h 
mov ax,bikePrice
add amt, ax
mov dx,0
mov bx,10
mov cx,0 
dec pSpace

it222:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
       jne it222
   
ds333:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop ds333


inc count
inc j     

;Show Time
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h 

lea dx, tim
mov ah,9
int 21h    

;HOUR:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CH     ; Hour CH
AAM           ; The AAM instruction divides the AL register by 10, leaving the quotient in AH and the remainder in AL
MOV BX,AX     ; Bx has hr
CALL DISP

MOV DL,':'
MOV AH,02H    
INT 21H


;MINUTES:
MOV AH,2CH    
INT 21H
MOV AL,CL     ; Minutes CL
AAM
MOV BX,AX
CALL DISP

MOV DL,':'   
MOV AH,02H
INT 21H


;Seconds:
MOV AH,2CH    
INT 21H
MOV AL,DH     ;Seconds is in DH
AAM
MOV BX,AX
CALL DISP

jmp cnttt     ;So that Seconds Doesnt get displayed twice
    
cnttt:
jmp menuu


           
           
filee proc 
    
mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h     

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h 

mov ah,40h
mov bx,fhandle
mov cx,23   
lea dx,m3     ;total amt collected
int 21h   

push offset numtoprint
mov ax,amt
push ax
call numtoascii 
mov dx,offset numtoprint
;mov ah,9h
;int 21h

mov ah,40h
mov bx,fhandle
mov cx,3   
lea dx,numtoprint    ;total amt collected
int 21h    

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h  

mov ah,40h
mov bx,fhandle   ;total number of vehicles parked
mov cx,43   
lea dx,m4
int 21h      

mov ah,40h
mov bx,fhandle   ;total number of vehicles parked
mov cx,1   
lea dx,count
int 21h      

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h  

mov ah,40h
mov bx,fhandle   ;total number of bike
mov cx,37   
lea dx,m5
int 21h     

lea dx, save ;Saving message
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

mov ah,40h
mov bx,fhandle   
mov cx,1   
lea dx,b
int 21h       

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h  
 
mov ah,40h
mov bx,fhandle   ;total no of car
mov cx,36   
lea dx,m6
int 21h  

mov ah,40h
mov bx,fhandle   
mov cx,1   
lea dx,c
int 21h         

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h  
 
mov ah,40h
mov bx,fhandle    ;total no of jeep
mov cx,37  
lea dx,m7
int 21h

mov ah,40h
mov bx,fhandle   
mov cx,1   
lea dx,j
int 21h       

mov ah,40h
mov bx,fhandle
mov cx,1   
lea dx,endll    ;new Line
int 21h 

lea dx, sav ;Saving message
mov ah,9
int 21h
mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h
    
jmp menuu   
    
history proc 

;writing save data to file?

;mov si,0
   
;mov al, m3
;mov buffer[si],al  
;inc si 
;mov buffer[si],
                 
 
 
 



; Total Amount accumulated  
lea dx,m3
mov ah,9
int 21h  

mov ax, amt
mov dx,0
mov bx,10
mov cx,0
itamt:
        div bx
        push dx
        mov dx,0
      
        inc cx
        cmp ax,0
       jne itamt
   
dispamt:
        pop dx
        add dx,48
        mov ah,2
        int 21h
loop dispamt

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

lea dx,m4     ;total no of vehicles parked
mov ah,9
int 21h

mov dx,count
mov ah,2
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

lea dx,m5     ;total number of bike
mov ah,9
int 21h

mov dx,b
mov ah,2
int 21h

mov dx,10     
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h    

lea dx,m6     ;total number of car
mov ah,9
int 21h

mov dl,c
mov ah,2
int 21h

mov dx,10     
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

lea dx,m7     ;total number of jeep
mov ah,9
int 21h

mov dl,j
mov ah,2
int 21h

mov dx,10     
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

jmp menuu 



delt proc
mov b,'0' ;reset number of bikes to 0
mov amt,0 
mov count,'0' 
mov cx,maxVe
inc cx
mov pSpace, cx
lea dx,  m8
mov ah,9
int 21h

mov dx,10
mov ah,2
int 21h
mov dx,13
mov ah,2
int 21h

jmp menuu 

;FOR DAYS
s:
lea dx, sun
mov ah,9  
int 21h
jmp ct
m:
lea dx, mon
mov ah,9  
int 21h
jmp ct
t:
lea dx, tue
mov ah,9  
int 21h
jmp ct
w:  
lea dx, wed
mov ah,9  
int 21h
jmp ct
th:    
lea dx, thu
mov ah,9  
int 21h
jmp ct
f:     
lea dx, fri
mov ah,9  
int 21h
jmp ct
sa:    
lea dx, sat
mov ah,9  
int 21h
jmp ct    


proc numtoascii
    push bp
    mov bp,sp
    push cx  
    push bx
    mov ax,[bp+4]
    mov si,[bp+6]
    mov bx,10    
    xor cx,cx
    
    
digit1:
    xor dx,dx  
    div bx
    push dx
    inc cx
    cmp ax,0
    jne digit1

convdigit:
    pop dx
    add dl,30h
    mov [si],dl
    inc si
    loop convdigit

    pop bx
    pop cx
    pop bp   
    ret 4
endp numtoascii 


end main ;for main function to end  


