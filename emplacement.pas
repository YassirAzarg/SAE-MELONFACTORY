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

  positionEmplacement = record
    x: integer;
    y: integer;
    x2: integer;
    y2: integer;
  end;

  TEmplacementsArray = array of EmplacementC;

procedure initEmplacement(); // Initialiser les Emplacement
procedure initHUB(); // Créer le HUB

procedure dessineEmplacement(); // Procedure pour Dessiner les emplacement

//Function qui return les batiments
function getEmplacements(): TEmplacementsArray;


// Procedure pour explorer une Zone
procedure explorerZone();

// Procedure setConstructionParametre me permet de changer exactement un parametre d une construction precise
//@param indexCost index de l'Emplacement
//@param decouvert Boolean 
//@param gisement Boolean 
//@param gisement typologie 
//@param actif Boolean 
//@param minerai Minerai 
//@param resourcesC resourcesC 
//@param niveau niveau 
procedure setConstructionParametre(indexConst: integer; decouvert: boolean;
  gisement: boolean; typologie: TypeConstructions; actif: boolean;
  minerai: resourcesC; niveau: integer);


implementation


const
  MIN_EMPLACEMENT_GISEMENT = 2; // Min de gisement au départ
  MAX_EMPLACEMENT_GISEMENT = 2; //Max de gisement au départ

var
  tEmplacement: array of EmplacementC;

  posEmplacement: array[0..9] of positionEmplacement;


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
  i, r, r2, temp: integer;
  minDispo: array[0..1] of resourcesC;
  // Je donne au programme max 2 resources possible pour les gisement
begin
  SetLength(tEmplacement, 10);
  // Nombre d'emplacement que je veux 10 = le nombre de indexConst dans le tableau

  posEmplacement[0].x := 54;
  posEmplacement[0].y := 5;
  posEmplacement[0].x2 := 126;
  posEmplacement[0].y2 := 11;

  posEmplacement[1].x := 54;
  posEmplacement[1].y := 12;
  posEmplacement[1].x2 := 126;
  posEmplacement[1].y2 := 18;


  posEmplacement[2].x := 54;
  posEmplacement[2].y := 19;
  posEmplacement[2].x2 := 126;
  posEmplacement[2].y2 := 25;

  posEmplacement[3].x := 54;
  posEmplacement[3].y := 26;
  posEmplacement[3].x2 := 126;
  posEmplacement[3].y2 := 32;

  posEmplacement[4].x := 54;
  posEmplacement[4].y := 33;
  posEmplacement[4].x2 := 126;
  posEmplacement[4].y2 := 39;

  posEmplacement[5].x := 128;
  posEmplacement[5].y := 5;
  posEmplacement[5].x2 := 200;
  posEmplacement[5].y2 := 11;

  posEmplacement[6].x := 128;
  posEmplacement[6].y := 12;
  posEmplacement[6].x2 := 200;
  posEmplacement[6].y2 := 18;

  posEmplacement[7].x := 128;
  posEmplacement[7].y := 19;
  posEmplacement[7].x2 := 200;
  posEmplacement[7].y2 := 25;

  posEmplacement[8].x := 128;
  posEmplacement[8].y := 26;
  posEmplacement[8].x2 := 200;
  posEmplacement[8].y2 := 32;

  posEmplacement[9].x := 128;
  posEmplacement[9].y := 33;
  posEmplacement[9].x2 := 200;
  posEmplacement[9].y2 := 39;

  minDispo[0] := fer;
  minDispo[1] := cuivre;

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

  for i := 1 to r do
  begin
    repeat
      r2 := mathRandom(1, 9);
    until not tDeja[r2];

    temp := mathRandom(0, 1);

    // Générer des gisements casuel
    if minDispo[temp] = aucun then
    begin
      if minDispo[0] <> aucun then
        temp := 0
      else if minDispo[1] <> aucun then
        temp := 1;
    end;

    if minDispo[temp] <> aucun then
    begin
      tEmplacement[r2].gisement := True;
      tEmplacement[r2].decouvert := True;
      // je met true pour que je indique que l'emplacement est decouvert 
      tEmplacement[r2].actif := True;
      tEmplacement[r2].minerai := minDispo[temp];
      tEmplacement[r2].niveau := mathRandom(1, 3);
      // Je choisi un niveau random de purté

      minDispo[temp] := aucun;
      tDeja[r2] := True;
    end;
  end;



  dessineEmplacement();

end;

procedure dessineEmplacement();
var
  i: integer;
begin
  for i := 0 to High(tEmplacement) do
  begin
    if not tEmplacement[i].decouvert then
    begin
      dessinerCadreXY(posEmplacement[i].x, posEmplacement[i].y,
        posEmplacement[i].x2, posEmplacement[i].y2, simple, 8, black);
      deplacerCurseurXY(posEmplacement[i].x + 23, posEmplacement[i].y + 3);
      Write('EMPLACEMENT NON DECOUVERT');
    end
    else if tEmplacement[i].typologie = hub then
    begin
      dessinerCadreXY(posEmplacement[i].x, posEmplacement[i].y,
        posEmplacement[i].x2, posEmplacement[i].y2, simple, white, black);
      deplacerCurseurXY(posEmplacement[i].x + 4, posEmplacement[i].y + 2);
      Write('BATIMENT : HUB');
    end
    else if tEmplacement[i].gisement and (tEmplacement[i].minerai <> aucun) and tEmplacement[i].actif then
    begin
      dessinerCadreXY(posEmplacement[i].x, posEmplacement[i].y,
        posEmplacement[i].x2, posEmplacement[i].y2, simple, 6, black);

      if tEmplacement[i].typologie = aucune then
      begin
        deplacerCurseurXY(posEmplacement[i].x + 4, posEmplacement[i].y + 2);
        Write('GISEMENT NON EXPLOITE');
        deplacerCurseurXY(posEmplacement[i].x + 38, posEmplacement[i].y + 2);
        Write('NIVEAU : ', tEmplacement[i].niveau);
        if tEmplacement[i].decouvert then
        begin
          deplacerCurseurXY(posEmplacement[i].x + 4, posEmplacement[i].y + 4);
          Write('MINERAI : ', getResourceLabel(tEmplacement[i].minerai));
        end;
      end;

    end
    else if tEmplacement[i].typologie = mine then
    begin
      dessinerCadreXY(posEmplacement[i].x, posEmplacement[i].y,
        posEmplacement[i].x2, posEmplacement[i].y2, simple, white, black);
      deplacerCurseurXY(posEmplacement[i].x + 4, posEmplacement[i].y + 2);
      Write('BATIMENT   : ', getLabelConstruction(tEmplacement[i].typologie));
      deplacerCurseurXY(posEmplacement[i].x + 38, posEmplacement[i].y + 2);
      Write('NIVEAU : ', tEmplacement[i].niveau);
      deplacerCurseurXY(posEmplacement[i].x + 4, posEmplacement[i].y + 4);
      Write('PRODUCTION   : ', getResourceLabel(tEmplacement[i].minerai));
    end
    else
    begin
      dessinerCadreXY(posEmplacement[i].x, posEmplacement[i].y,
        posEmplacement[i].x2, posEmplacement[i].y2, simple, white, black);
      deplacerCurseurXY(posEmplacement[i].x + 28, posEmplacement[i].y + 3);
      Write('EMPLACEMENT VIDE');
    end;

    couleurTexte(1);
    deplacerCurseurXY(posEmplacement[i].x + 2, posEmplacement[i].y);
    Write(i + 1);
  end;
end;


function getEmplacements(): TEmplacementsArray;
begin
  getEmplacements := tEmplacement;
end;

procedure setConstructionParametre(indexConst: integer; decouvert: boolean;
  gisement: boolean; typologie: TypeConstructions; actif: boolean;
  minerai: resourcesC; niveau: integer);
begin
  if (indexConst < 0) or (indexConst > High(tEmplacement)) then
    Exit;
  tEmplacement[indexConst].decouvert := decouvert;
  tEmplacement[indexConst].gisement := gisement;
  tEmplacement[indexConst].typologie := typologie;
  tEmplacement[indexConst].actif := actif;
  tEmplacement[indexConst].minerai := minerai;
  tEmplacement[indexConst].niveau := niveau;
end;


procedure explorerZone();
var
  c1, c2, c3: integer;
  done: boolean;
  decouvrables: array of integer;
  i, Count: integer;
  minDispo: array[0..1] of resourcesC;
begin
  if Length(tEmplacement) = 0 then
    Exit;

  minDispo[0] := fer;
  minDispo[1] := cuivre;

  c1 := Random(2); // 0 ou 1 : découvrir ou pas
  c3 := Random(3); // 0 ou 1 : Gisement ou pas
  if c1 = 1 then
  begin
    // Créer une liste des emplacements découvrables
    Count := 0;
    SetLength(decouvrables, Length(tEmplacement));
    for i := 0 to High(tEmplacement) do
      if not tEmplacement[i].decouvert and (tEmplacement[i].typologie <> hub) then
      begin
        decouvrables[Count] := i;
        Inc(Count);
      end;

    if Count = 0 then
      Exit; // Rien à découvrir

    // Tirer un emplacement au hasard parmi les découvrables
    c2 := decouvrables[Random(Count)];
    tEmplacement[c2].decouvert := True;
    if c3 = 1 then
    begin
      tEmplacement[c2].gisement := True;
      tEmplacement[c2].minerai := minDispo[c3];
    end;
  end;
end;

end.
