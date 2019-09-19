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

% Aksi dan konsekuensinya
mandi() :-
	addStatus(10,0,0).

% Main Loop
game :-
    repeat,
    write('> '),
    read(X),
    call(X),
    game.