
% Commande principale
sudoku :-
	grille(Table),
	structure(Table,Groupes),
	voisins(Table,Groupes,Voisins).
	%possibilites(Table,Groupes,0,Possibilites).
	
grille(Table) :-
	Table = [
    5, 3, _, _, 7, _, _, _, _,
    6, _, _, 1, 9, 5, _, _, _,
    _, 9, 8, _, _, _, _, 6, _,

    8, _, _, _, 6, _, _, _, 3,
    4, _, _, 8, _, 3, _, _, 1,
    7, _, _, _, 2, _, _, _, 6,

    _, 6, _, _, _, _, 2, 8, _,
    _, _, _, 4, 1, 9, _, _, 5,
    _, _, _, _, 8, _, _, 7, 9].



strict_member(E, [Head|_]) :- E == Head, !.
strict_member(E, [_|Tail]) :- strict_member(E, Tail).

	
possibilites([Case|Table], Groupes, Index, [Result|Results]) :-
	 (var(Case) ->
	 LigneIndex is Index div 9,
	 ColonneIndex is Index mod 9 + 9,
	 SecteurIndex is LigneIndex div 3 * 3 + ColonneIndex div 3 + 18,
	 nth0(LigneIndex, Groupes, Ligne),
	 nth0(ColonneIndex, Groupes, Colonne),
	 nth0(SecteurIndex, Groupes, Secteur),
	 append([Ligne, Colonne, Secteur], Voisins),
	 flatten(Voisins, Voisins2),
	 include(atomic, Voisins2, Voisins3),
	 subtract([1,2,3,4,5,6,7,8,9],Voisins3,Result);
	 Result = Case),
	 writeln(Result),
	 NewIndex is Index + 1,
	 possibilites(Table,Groupes,NewIndex,Results);

voisins([],_,[]).
voisins([Case|Table],Groupes,[Result|Results]) :-
	not(integer(Case)),
	!,
	include(strict_member(Case),Groupes,Result),
	voisins(Table,Groupes,Results).
voisins([_|Table],Groupes,[Results]) :-
	voisins(Table, Groupes, Results).
	


%possibilites([],_,[]).
%possibilites([Case|Table],[Voisin|Voisins],[Result|Results]) :-
	%not(integer(Case)),
%	subtract([1,2,3,4,5,6,7,8,9],Voisin,Result),
	%possibilites(Table,Voisins,Results).

% Liste qui contient les listes de tous lpes groupes (lignes, colonnes et secteurs)
structure(Table, Groupes) :-
	Table = [
    C11, C12, C13, C14, C15, C16, C17, C18, C19,
    C21, C22, C23, C24, C25, C26, C27, C28, C29,
    C31, C32, C33, C34, C35, C36, C37, C38, C39,

    C41, C42, C43, C44, C45, C46, C47, C48, C49,
    C51, C52, C53, C54, C55, C56, C57, C58, C59,
    C61, C62, C63, C64, C65, C66, C67, C68, C69,

    C71, C72, C73, C74, C75, C76, C77, C78, C79,
    C81, C82, C83, C84, C85, C86, C87, C88, C89,
    C91, C92, C93, C94, C95, C96, C97, C98, C99],

	Groupes = [
	% Lignes
    [C11, C12, C13, C14, C15, C16, C17, C18, C19],
    [C21, C22, C23, C24, C25, C26, C27, C28, C29],
    [C31, C32, C33, C34, C35, C36, C37, C38, C39],
    [C41, C42, C43, C44, C45, C46, C47, C48, C49],
    [C51, C52, C53, C54, C55, C56, C57, C58, C59],
    [C61, C62, C63, C64, C65, C66, C67, C68, C69],
    [C71, C72, C73, C74, C75, C76, C77, C78, C79],
    [C81, C82, C83, C84, C85, C86, C87, C88, C89],
    [C91, C92, C93, C94, C95, C96, C97, C98, C99],
	
	% Colonnes
	[C11, C21, C31, C41, C51, C61, C71, C81, C91],
    [C12, C22, C32, C42, C52, C62, C72, C82, C92],
    [C13, C23, C33, C43, C53, C63, C73, C83, C93],
    [C14, C24, C34, C44, C54, C64, C74, C84, C94],
    [C15, C25, C35, C45, C55, C65, C75, C85, C95],
    [C16, C26, C36, C46, C56, C66, C76, C86, C96],
    [C17, C27, C37, C47, C57, C67, C77, C87, C97],
    [C18, C28, C38, C48, C58, C68, C78, C88, C98],
    [C19, C29, C39, C49, C59, C69, C79, C89, C99],

	% Secteurs
	[C11,C12,C13,C21,C22,C23,C31,C32,C33],
	[C14,C15,C16,C24,C25,C26,C34,C35,C36],
	[C17,C18,C19,C27,C28,C29,C37,C38,C39],
	[C41,C42,C43,C51,C52,C53,C61,C62,C63],
	[C44,C45,C46,C54,C55,C56,C64,C65,C66],
	[C47,C48,C49,C57,C58,C59,C67,C68,C69],
	[C71,C72,C73,C81,C82,C83,C91,C92,C93],
	[C74,C75,C76,C84,C85,C86,C94,C95,C96],
	[C77,C78,C79,C87,C88,C89,C97,C98,C99]].