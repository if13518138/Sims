:- dynamic status/2.
status(hyg, 0).
status(fun, 0).
status(en, 10).

% Fungsi cek status valid
valid(Hyg, Fun, En) :-
	0 =:= Hyg mod 5, Hyg =< 15, Hyg >= 0,
	0 =:= Fun mod 5, Fun =< 15, Fun >= 0,
	0 =:= En mod 5, En =< 15, En >= 0.

getStatus(X,Y,Z) :-
	status(hyg, X),
	status(fun, Y),
	status(en, Z).

addStatus(A,B,C) :-
	getStatus(X,Y,Z),
	XX is X+A,
	YY is Y+B,
	ZZ is Z+C,
	valid(XX,YY,ZZ),
	retract(status(hyg,X)),
	retract(status(fun,Y)),
	retract(status(en,Z)),
	assert(status(hyg,XX)),
	assert(status(fun,YY)),
	assert(status(en,ZZ)),
	tulis(),
	!.
addStatus(_,_,_) :-
	writeln('Aksi tidak valid').

tulis() :-
	getStatus(X,Y,Z),
	write('Hygiene sekarang jadi '),writeln(X),
	write('Fun sekarang jadi '),writeln(Y),
	write('Energy sekarang jadi '),writeln(Z).

% Fungsi tambahan untuk cek status sekarang
cek() :-
	getStatus(X,Y,Z),
	write('Hygiene = '),writeln(X),
	write('Fun     = '),writeln(Y),
	write('Energy  = '),writeln(Z).

validasi(X) :- 
	(X == "Tidur Siang", call(tidur("Siang")));
	(X == "Tidur Malam", call(tidur("Malam")));
	(X == "Makan Hamburger", call(makan("Hamburger")));
	(X == "Makan Pizza", call(makan("Pizza")));
	(X == "Makan Steak and Beans", call(makan("Steak and Beans")));
	(X == "Minum Air", call(minum("Air")));
	(X == "Minum Kopi", call(minum("Kopi")));
	(X == "Minum Jus", call(minum("Jus")));
	(X == "Buang Air Kecil", call(buang_air("Kecil")));
	(X == "Buang Air Besar", call(buang_air("Besar")));
	(X == "Bersosialisasi ke Kafe", call(bersosialisasi_ke_kafe()));
	(X == "Bermain Media Sosial", call(bermain_media_sosial()));
	(X == "Bermain komputer", call(bermain_komputer()));
	(X == "Mandi", call(mandi()));
	(X == "Cuci Tangan", call(cuci_tangan()));
	(X == "Mendengarkan Musik di Radio", call(mendengarkan_musik_di_radio()));
	(X == "Membaca Koran", call(membaca("Koran")));
	(X == "Membaca Novel", call(membaca("Novel")));
	(call(tes())).

% Aksi dan konsekuensinya
tes() :-
	writeln("Command tidak ditemukan").

tidur(X) :-
	(addStatus(0,0,10), X == "Siang");
	(addStatus(0,0,15), X == "Malam").

mandi() :-
	addStatus(15,0,-5).

bersosialisasi_ke_kafe() :- 
	addStatus(-5,15,-10).

bermain_media_sosial() :-
	addStatus(0,10,-10).

bermain_komputer() :-
	addStatus(0,15,-10).

cuci_tangan() :-
	addStatus(5,0,0).

mendengarkan_musik_di_radio() :-
	addStatus(0,10,-5).

membaca(X) :- 
	("Koran" == X, addStatus(0,5,-5));
	("Novel" == X, addStatus(0,10,-5)).

makan(X) :-
	(X == "Hamburger",addStatus(0,0,5));
	(X == "Pizza",addStatus(0,0,10));
	(X == "Steak and Beans",addStatus(0,0,15)).

minum(X) :-
	(X == "Air",addStatus(-5,0,0));
	(X == "Kopi",addStatus(-10,0,5));
	(X == "Jus",addStatus(-5,0,10)).

buang_air(X) :-
	(X == "Kecil",addStatus(5,0,0));
	(X == "Besar",addStatus(10,0,-5)).

% Main Loop
game :-
    repeat,
    write('> '),
    read(X),
    writeln(X),
    validasi(X),
    game.

% ketika masukan tidak valid (komenan salah)
%% game :-
%% 	writeln("Command tidak valid."),
%% 	game.