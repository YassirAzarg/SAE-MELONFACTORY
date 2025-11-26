unit utils;


interface

uses SysUtils, GestionEcran;

procedure animEcriture(pos: coordonnees; str: string);

implementation

procedure animEcriture(pos: coordonnees; str: string);

var
  i: integer;
  delai_sec: smallint;
begin
  delai_sec := 20; // Vitesse d'ecriture
  deplacerCurseurXY(pos.x, pos.y);
  for i := 1 to Length(str) do
  begin
    Write(str[i]);
    attendre(delai_sec);
  end;
end;




begin

end.
