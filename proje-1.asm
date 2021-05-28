
org 100h 


mov al,7
mov ah,05h
int 10h


mov al,0h  
mov ah,0
int 10h  ;  ekrani 40x25 olarak ayarlardi

mov bh,0  ; aktif sayfayi belirtir

mov si,4  ;d�ng� 
mov di,2  ; d�ng�



call ayrisayfalar

call aynisayfa

call sayfalariSirala   


call mouseKontrol




ret ; program� kapat�r 



    
    
;------FONKS�YONLAR----------------------------    

;----------------------------------------------- 

sayfayiGetir:

mov ah,05h
int 10h
call gecikme

ret
;----------------------------------------------- 





;----------------------------------------------- 

cizme:

mov al,0 ; bo� karakter
mov bl,0c1h ; arkaplan kirmizi
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


