% Fakta 
pria(willi).
pria(jojo).
wanita(pika).

ayah(willi,jojo).
ibu(jojo,pika).

likes(willi,ayam).
likes(willi,ikan).
likes(willi,cewe).

getKelamin(X) :- 
	pria(X).
same(X,Y):-(X == Y).