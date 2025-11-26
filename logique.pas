unit Logique;

interface

uses SysUtils, GestionEcran, Windows, utils;

procedure renderGame();
procedure quitter();

implementation


procedure renderGame();
var
  pos: coordonnees;
begin
  effacerEcran();
  couleurTexte(Cyan);

  SetConsoleOutputCP(CP_UTF8);
  pos.x := 79;
  pos.y := 4;
  animEcriture(pos, 'Dans une réalité, pas si alternative que ça.');
end;

procedure quitter();
begin
  effacerEcran();
end;

begin
end.
