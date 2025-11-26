unit utils;


interface


uses SysUtils, GestionEcran;

procedure animEcriture(pos: coordonnees; str: string);

function mathRandom(max, min: integer): integer;

implementation


procedure animEcriture(pos: coordonnees; str: string);

var
  i: integer;
  delai_sec: smallint;
begin
  delai_sec := 1; // Vitesse d'ecriture
  deplacerCurseurXY(pos.x, pos.y);
  for i := 1 to Length(str) do
  begin
    Write(str[i]);
    if not True then
      attendre(delai_sec);
  end;
end;

function mathRandom(max, min: integer): integer;
begin
  mathRandom := Random(max - min + 1) + min;
end;


begin

end.
