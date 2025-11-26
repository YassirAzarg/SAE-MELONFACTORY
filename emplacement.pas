unit Emplacement;

interface

uses SysUtils, GestionEcran, Resources, utils, ConstructionType;

type
  EmplacementC = record
    niveau: integer;      // 1 à 3
    decouvert: boolean;   // Si True alors découvert sinon non
    gisement: boolean;    // Si True alors possibilité de construire une mine
    typologie: TypeConstructions;
    actif: boolean;
    minerai: resourcesC;     // ou TMinerai si tu veux
  end;

procedure initEmplacement(); // Initialiser les Emplacement
procedure initHUB(); // Créer le HUB

implementation

const
  MIN_EMPLACEMENT_GISEMENT = 2; // Min de gisement au départ
  MAX_EMPLACEMENT_GISEMENT = 2; //Max de gisement au départ

var 
  tEmplacement: array of EmplacementC;

procedure initHUB(t: EmplacementC);
begin

  t[0].niveau := 0;
  t[0].decouvert := True;
  t[0].gistement := False;
  t[0].typologie := hub;
  t[0].actif := False; // Toujours blanc
  t[0].minerai := aucun;

end;

procedure initEmplacement();

var
  tDeja: array[0..MAX_EMPLACEMENT_GISEMENT] of boolean;
  i, r, r2: integer;
begin
  SetLength(tEmplacement, 10);
  // Nombre d'emplacement que je veux 10 = le nombre de index dans le tableau

  for i:=1 to 10 do
    begin
      t[i].niveau := 1;
      t[i].decouvert := False;
      t[i].gisement := False;
      t[i].typologie := aucune;
      t[i].actif := False;
      t[i].minerai := aucun;
    end;

  Randomize();

  // Nombre de Gisement disponible au départ
  r := mathRandom(MIN_EMPLACEMENT_GISEMENT, MAX_EMPLACEMENT_GISEMENT);

  initHUB(tEmplacement)

  for i := 0 to r do
  begin

    r2 := mathRandom(1, 10);
    // Générer des gisements casuel
    if not tDeja[i] then
    begin
      tEmplacement[r2].gisement := True;
      tDeja[i] := True;
    end;

  end;

end;

end.
