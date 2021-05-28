
 
randomGenerator:

mov bx,2000h
mov ds,bx
mov bx,100h

mov si,4 ; loop miktarý 

mov [100h],0
mov [101h],0
mov [102h],0
mov [103h],0


call random

mov [bx],dl

inc bx

loop:
call random

call compare

mov [bx],dl
 
inc bx
dec si

cmp si,1
jg loop

exitFromRandom:
ret





;---------karsilastirma

compare:
cmp [103h],0
jne exitFromRandom
cmp dl,[0100h]
je loop
cmp dl,[0101h]
je loop
cmp dl,[0102h]
je loop
cmp dl,[0103h]
je loop

ret 


;------------------random fonksiyonu------------
;------DL ' ye  1-4 arasý sayý kaydeder
random:

   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 4    
   div  cx       ; here dx contains the remainder of the division - from 0 to 9   
   add dl,1  
RET 






