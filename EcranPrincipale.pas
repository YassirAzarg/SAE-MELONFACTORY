unit EcranPrincipale;

interface

uses
  Classes,
  SysUtils,
  Logique,
  EcranAccueil;

// Procedure principale qui lance les pages principales
procedure menuGame();

implementation

procedure menuGame();
var
  choix: string;

begin
  choix := menu();

  if (choix = '1') then
  begin
    renderGame();
  end
  else
  begin
    quitter();
  end;

end;

begin



end.
