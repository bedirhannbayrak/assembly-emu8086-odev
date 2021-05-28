
org 100h
 mov al,7
mov ah,05h
int 10h


mov al,0h  
mov ah,0
int 10h  ;ekrani 40x25 olarak ayarlardi

mov bh,0  ;aktif sayfayi belirtir(sayfa 0 secildi

mov si,4
mov di,2

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
inc bh
sub dh,2
cmp si,0
jnz tekrar1

mov al,2
call sayfayiGetir 

mov al,3
call sayfayiGetir

mov al,0
call sayfayiGetir

mov al,1
call sayfayiGetir




ret

sayfayiGetir:
mov ah,05h
int 10h
ret

cizme:
mov al,0 ; boþ karakter
mov bl,0c1h ; arkaplan kirmizi on plan mavi
mov cx,3    ; ekrana 2 karakter yazdirilacak
mov ah,09
int 10h

ret




