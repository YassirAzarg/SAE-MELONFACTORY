unit utils;


interface


uses SysUtils, GestionEcran;

procedure animEcriture(pos: coordonnees; str: string);

function mathRandom(max, min: integer): integer;

function getDebug(): boolean;

//@param str String = Chaîne de charactères a print si le debug est activé
procedure setDebug(state: boolean);

procedure dgprint(str: string);

implementation

var
  debugMode: boolean;

function getDebug(): boolean;
begin
  getDebug := debugMode;
end;

procedure setDebug(state: boolean);
begin
  debugMode := state;
end;


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

procedure dgprint(str: string);
begin
  if getDebug() then
  begin
    WriteLn(str);
  end;
end;


begin

end.
