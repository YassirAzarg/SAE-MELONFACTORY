unit Logique;

interface

uses SysUtils, GestionEcran, Windows, utils;

procedure renderGame();
procedure quitter();

implementation

// Procedure qui lance le jeu
procedure renderGame();

type
  tLigne = record
    pos: coordonnees;
    texte: string;
  end;

var
  i: integer;

  lignes: array of tLigne;

begin

  effacerEcran();

  couleurTexte(Cyan);
  SetLength(lignes, 18);
  // 18 Le nombres de lignes du texte que je veux je definis la taille du tableau
  // J'utilise ici SetConsoleOutputCP pour appliquer l'encodage UTF-8 pour avoir du coup les charactères speciaux français.
  SetConsoleOutputCP(CP_UTF8);
  lignes[0].pos.x := 79;
  lignes[0].pos.y := 4;
  lignes[0].texte := 'Dans une réalité, pas si alternative que ça.';


  lignes[1].pos.x := 78;
  lignes[1].pos.y := 6;
  lignes[1].texte := '2024 : une année particulièrement compliquée.';

  lignes[2].pos.x := 51;
  lignes[2].pos.y := 7;
  lignes[2].texte :=
    'Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements';

  lignes[3].pos.x := 68;
  lignes[3].pos.y := 8;
  lignes[3].texte := 'se sont succédé entre janvier et mars. Oui, douze. En trois mois.';

  lignes[4].pos.x := 52;
  lignes[4].pos.y := 10;
  lignes[4].texte :=
    'L''instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans';



  for i := 0 to High(lignes) do
  begin
    animEcriture(lignes[i].pos, lignes[i].texte);
  end;

end;

// Procedure pour quitter le jeu
procedure quitter();
begin
  effacerEcran();
end;

begin
end.
