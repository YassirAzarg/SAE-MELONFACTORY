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
    minerai: resourcesC;
  end;

procedure initEmplacement(); // Initialiser les Emplacement
procedure initHUB(); // Créer le HUB

implementation

const
  MIN_EMPLACEMENT_GISEMENT = 2; // Min de gisement au départ
  MAX_EMPLACEMENT_GISEMENT = 2; //Max de gisement au départ

var
  tEmplacement: array of EmplacementC;

procedure initHUB();

begin
  tEmplacement[0].niveau := 0;
  tEmplacement[0].decouvert := True;
  tEmplacement[0].gisement := False;
  tEmplacement[0].typologie := hub;
  tEmplacement[0].actif := False; // Toujours blanc
  tEmplacement[0].minerai := aucun;

end;

procedure initEmplacement();

var
  tDeja: array[1..9] of boolean;
  i, r, r2: integer;
begin
  SetLength(tEmplacement, 10);
  // Nombre d'emplacement que je veux 10 = le nombre de index dans le tableau

  for i := 1 to 9 do
  begin
    tEmplacement[i].niveau := 1;
    tEmplacement[i].decouvert := False;
    tEmplacement[i].gisement := False;
    tEmplacement[i].typologie := aucune;
    tEmplacement[i].actif := False;
    tEmplacement[i].minerai := aucun;
  end;

  for i := 1 to High(tDeja) do
  begin
    tDeja[i] := False;
  end;

  Randomize();

  // Nombre de Gisement disponible au départ
  r := mathRandom(MIN_EMPLACEMENT_GISEMENT, MAX_EMPLACEMENT_GISEMENT);

  initHUB();

  for i := 0 to r do
  begin

    r2 := mathRandom(1, 9);
    // Générer des gisements casuel
    if not tDeja[r2] then
    begin
      //WriteLn('Emplacement choisi : ', r2);
      tEmplacement[r2].gisement := True;
      tDeja[r2] := True;
    end;

  end;

end;

end.
