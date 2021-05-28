
org 100h 


mov al,7
mov ah,05h
int 10h


mov al,0h  
mov ah,0
int 10h  ;  ekrani 40x25 olarak ayarlardi

mov bh,0  ; aktif sayfayi belirtir

mov si,4  ;döngü 
mov di,2  ; döngü



call ayrisayfalar

call aynisayfa

call sayfalariSirala

;SIRA  3 - 4 - 1 - 2 

;-----1.KUTU KONTROL---------  
call mouseKontrol

cmp cx,80h
jb exit
cmp cx,97h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 

mov dl,12 ; sutun
call setCursorPosition

call tekKareCizme ; dh,4 ; satir   

   
   
;-----2.KUTU KONTROL---------   
call mouseKontrol

cmp cx,0a0h
jb exit
cmp cx,0b7h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 


mov dl,16 ; sutun
call setCursorPosition

call tekKareCizme


;-----3.KUTU KONTROL---------
   
call mouseKontrol

cmp cx,040h
jb exit
cmp cx,057h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 


mov dl,4 ; sutun
call setCursorPosition

call tekKareCizme


;-----4.KUTU KONTROL---------   
call mouseKontrol

cmp cx,060h
jb exit
cmp cx,077h
ja exit 
cmp dx,28h
jb exit
cmp dx,37h
ja exit 


mov dl,8 ; sutun
call setCursorPosition

call tekKareCizme 

;------------------------------










;cx - 80-97  kutu 1
;dx - 28-37    

;cx - a0-b7  kutu 2
;dx - 28-37   

;cx - 60-77  kutu 3
;dx - 28-37   

;cx - 40-57  kutu 3
;dx - 28-37






exit:
ret ; programý kapatýr 



    
    
;------FONKSÝYONLAR----------------------------    

;----------------------------------------------- 

sayfayiGetir:

mov ah,05h
int 10h
call gecikme

ret
;----------------------------------------------- 





;----------------------------------------------- 

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
mov bl,0a1h ; arkaplan kirmizi
mov cx,3    ; ekrana 3 karakter yazdirir
mov ah,09
int 10h

ret
 
;-----------------------------------------------   
  
                

                
                
;-----------------------------------------------
gecikme:
mov cx,4h
mov dx,063e0h
mov ah,86h
int 15h ; 2d00h mikrosaniye gecikme verdik 

ret  
;-----------------------------------------------





;-----------------------------------------------

ayrisayfalar:

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



;-----------------------------------------------

tekKareCizme:

mov di,2 

add dl,4
tekrar5:
inc dh
mov ah,2
int 10h   ; ekranda cursor posizyonu ayarlandi

call cizmeYesil

dec di
cmp di,0
jnz tekrar5

ret     


;-------------------------------------------------


 
 
 
;-------------------------------------------------

aynisayfa:
mov si,4
mov di,2

mov bh,4
mov dh,4 ; satir
mov dl,4 ; sutun
tekrar3:
add dl,4
tekrar4:
inc dh
mov ah,2
int 10h   ; ekranda cursor posizyonu ayarlandi

call cizme

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
 
mov al,2
call sayfayiGetir 

mov al,3
call sayfayiGetir

mov al,0
call sayfayiGetir

mov al,1
call sayfayiGetir 

mov al,4  
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




;------------------------------------------------- 

setCursorPosition:  ; dl'yi fonksiyon ustunde belirt
mov dh,4  ;satir
mov bh,4
mov ah, 2
int 10h  

ret


;------------------------------------------------- 