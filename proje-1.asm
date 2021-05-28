
org 100h 

call randomGenerator
mov al,7
mov ah,05h
int 10h


mov al,0h  
mov ah,0
int 10h  ;  ekrani 40x25 olarak ayarlardi 


call griArkaPlan01234 ; 


call ayriSayfalarKutuYerlestir1234


call sayfalariSirala


 

mov si,100h
karsilastirmaDongusu:

cmp [si],1
je kutu1 

cmp [si],2
je kutu2

cmp [si],3
je kutu3

cmp [si],4
je kutu4

don:

inc si
cmp si,104h
jb karsilastirmaDongusu

jmp basarili



kutu1:
call kutu1f

kutu2:
call kutu2f

kutu3:
call kutu3f

kutu4:
call kutu4f



basarili:

mov ax,0700h
mov ds,ax

MOV dh,2
mov dl,6
call setCursorDHDL

mov dx,offset yazi
mov ah,09
int 21h
jmp atla
ret 
yazi db "TEBRIKLER, KAZANDIN !!","$"
atla:
call gecikme
hlt 


exit: 

mov ax,0700h
mov ds,ax  

MOV dh,2
mov dl,10
call setCursorDHDL

mov dx,offset yazi2
mov ah,09
int 21h 
jmp atla2
ret 
yazi2 db "KAYBETTIN !!","$"
atla2:
call gecikme
hlt







;------KUTU 1 ---------

kutu1f:
call mouseKontrol

cmp cx,40h
jb exit
cmp cx,67h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 



mov dh,4  ;satir
mov dl,8 ; sutun 

mov bh,0
mov ah, 2
int 10h

call tekKareCizme ; dh,4 ; satir 

jmp don  
;---------------------------------  

;------KUTU 2 ---------

kutu2f:
call mouseKontrol

cmp cx,60h
jb exit
cmp cx,87h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 



mov dh,4  ;satir
mov dl,12 ; sutun

mov bh,0
mov ah, 2
int 10h

call tekKareCizme ; dh,4 ; satir 

jmp don    
;---------------------------------


;------KUTU 3 --------- 
kutu3f:
call mouseKontrol

cmp cx,80h
jb exit
cmp cx,97h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 



mov dh,4  ;satir
mov dl,16 ; sutun

mov bh,0
mov ah, 2
int 10h

call tekKareCizme ; dh,4 ; satir  

jmp don  
 
;---------------------------------

;------KUTU 4 ---------

kutu4f:
call mouseKontrol

cmp cx,0a0h
jb exit
cmp cx,0b7h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 



mov dh,4  ;satir
mov dl,20 ; sutun

mov bh,0
mov ah, 2
int 10h

call tekKareCizme ; dh,4 ; satir 


jmp don    
;---------------------------------



;cx - 80-97  kutu 1
;dx - 28-37    

;cx - a0-b7  kutu 2
;dx - 28-37   

;cx - 60-77  kutu 3
;dx - 28-37   

;cx - 40-57  kutu 3
;dx - 28-37









    
    
;------FONKSÝYONLAR----------------------------    

;----------------------------------------------- 

sayfayiGetir:

mov ah,05h
int 10h
call gecikme

ret
;----------------------------------------------- 





;----------------------------------------------------------------------------------------------------------------------------------------- 

cizme:

mov al,0 ; boþ karakter
mov bl,0e1h ; arkaplan kirmizi
mov cx,3    ; ekrana 3 karakter yazdirir
mov ah,09
int 10h

ret
 
;----------------------------------------------- 

;----------------------------------------------- 

cizmeYesil:

mov al,0 ; boþ karakter
mov bl,0a1h ; arkaplan yeþil
mov cx,3    ; ekrana 3 karakter yazdirir
mov ah,09
int 10h

ret
 
;-----------------------------------------------  

;----------------------------------------------- 

cizmeGri:

mov al,0 ; boþ karakter
mov bl,071h ; arkaplan kirmizi
mov cx,3    ; ekrana 3 karakter yazdirir
mov ah,09
int 10h

ret
 
;----------------------------------------------- 

;-----------------------------------------------

tekKareCizme:

mov di,2 
tekrar5:
inc dh
mov ah,2
int 10h   ; ekranda cursor posizyonu ayarlandi

call cizmeYesil

dec di
cmp di,0
jnz tekrar5

ret     


;-------------------------------------------------------------------------------------------------------------------------------------------  
  

                
                
;-----------------------------------------------
gecikme:
mov cx,4h
mov dx,063e0h
mov ah,86h
int 15h ; 2d00h mikrosaniye gecikme verdik 

ret  
;-----------------------------------------------




;-----------------------------------------------

ayriSayfalarKutuYerlestir1234:
mov bh,1  ; hangi sayfadan baslyacagi
mov si,4  ;dongu
mov di,2  ; dongu

mov dh,4 ; satir
mov dl,4 ; sutun
tekrar1:
add dl,4
tekrar2:
inc dh
mov ah,2
int 10h   ; ekranda cursor posizyonu ayarlandi

call cizme

dec di
cmp di,0
jnz tekrar2


mov di,2
dec si 
inc bh ; aktif sayfayi arttirdik
sub dh,2
cmp si,0
jnz tekrar1 

ret
;-------------------------------------------------


 
 
 
;-------------------------------------------------

aynisayfa:
mov si,4
mov di,2
mov dh,4 ; satir
mov dl,4 ; sutun
tekrar3:
add dl,4
tekrar4:
inc dh
mov ah,2
int 10h   ; ekranda cursor posizyonu ayarlandi

call cizmeGri

dec di
cmp di,0
jnz tekrar4


mov di,2
dec si 
sub dh,2
cmp si,0
jnz tekrar3 

ret

;-------------------------------------------------


;-------------------------------------------------
 
sayfalariSirala:
 
mov al,0
call sayfayiGetir 

call gecikme


mov al,[100h]
call sayfayiGetir
 
mov al,[101h]
call sayfayiGetir 

mov al,[102h]
call sayfayiGetir

mov al,[103h] 
call sayfayiGetir
 

mov al,0
call sayfayiGetir

ret 


;-------------------------------------------------
                                                      
                                                      
;-------------------------------------------------

mouseKontrol:
                                                      
  mov  ax, 0000h  ; reset mouse
  int  33h        ; -> AX BX
  cmp  ax, 0FFFFh
  mov  ax, 0001h  ; show mouse
  int  33h
MouseLP:
  mov  ax, 0003h  ; get mouse position and buttonstatus
  int  33h        ; -> BX CX DX
  test bx, 1      ; check left mouse click
  jz   MouseLP    ; Loop until mouse click 
  
  ret
  
;-------------------------------------------------  



;--------------RANDOM----------------------------------------------------------------------------------------------------------
 
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



;-------------------------------------------------------------------------------------------- 
griArkaPlan01234:
    mov bh,0
    call aynisayfa 
    mov bh,1
    call aynisayfa
    mov bh,2
    call aynisayfa
    mov bh,3
    call aynisayfa
    mov bh,4
    call aynisayfa 

ret

;--------SETCURSOR DH DL --------------
setCursorDHDL:
	mov bh, 0
	mov ah, 2
	int 10h

ret
	
;-----------------------------------------------------RET