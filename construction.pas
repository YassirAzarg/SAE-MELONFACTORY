unit Construction;

interface

uses SysUtils, GestionEcran, utils, Resources, ConstructionType;


type

  TConstruction = record
    Nom: string;
    CoutConstruction: array of record
      Ressource: resourcesC;
      Quantite: integer;
    end;
    EnergieConsommee: integer;
    CoutAmelioration: array of array of record
      Ressource: resourcesC;
      Quantite: integer;
    end;
  end;

var
  Constructions: array[TypeConstructions] of TConstruction;


//Procedure pour Initialiser les construction et leurs informations au niveau des ressources demandé
procedure InitialiserConstructions;


//Function qui sert a savoir si il a assez de ressources pour une construction 
//@param typologie TypeConstructions indique le type de construction
//@param Niveau actuelle
//return Oui ou Non si il a assez de ressources
function haveEnoughResources(typologie : TypeConstructions; niveau : Integer): boolean;


procedure removeRessources(typologie : TypeConstructions; niveau : Integer);


implementation

procedure InitialiserConstructions;
begin
  // Mine
  Constructions[mine].Nom := 'Mine Mk.';
  SetLength(Constructions[mine].CoutConstruction, 1);
  Constructions[mine].CoutConstruction[0].Ressource := plaques_de_fer;
  Constructions[mine].CoutConstruction[0].Quantite := 10;
  Constructions[mine].EnergieConsommee := 100;
  SetLength(Constructions[mine].CoutAmelioration, 3);
  SetLength(Constructions[mine].CoutAmelioration[0], 2);
  Constructions[mine].CoutAmelioration[0][0].Ressource := plaques_de_fer;
  Constructions[mine].CoutAmelioration[0][0].Quantite := 20;
  Constructions[mine].CoutAmelioration[0][1].Ressource := sacs_de_beton;
  Constructions[mine].CoutAmelioration[0][1].Quantite := 20;
  SetLength(Constructions[mine].CoutAmelioration[1], 2);
  Constructions[mine].CoutAmelioration[1][0].Ressource := plaques_de_fer;
  Constructions[mine].CoutAmelioration[1][0].Quantite := 20;
  Constructions[mine].CoutAmelioration[1][1].Ressource := acier;
  Constructions[mine].CoutAmelioration[1][1].Quantite := 20;

  // Constructeur
  Constructions[constructeur].Nom := 'Constructeur';
  SetLength(Constructions[constructeur].CoutConstruction, 2);
  Constructions[constructeur].CoutConstruction[0].Ressource := cables_de_cuivre;
  Constructions[constructeur].CoutConstruction[0].Quantite := 10;
  Constructions[constructeur].CoutConstruction[1].Ressource := plaques_de_fer;
  Constructions[constructeur].CoutConstruction[1].Quantite := 10;
  Constructions[constructeur].EnergieConsommee := 200;
  SetLength(Constructions[constructeur].CoutAmelioration, 2);
  SetLength(Constructions[constructeur].CoutAmelioration[0], 2);
  Constructions[constructeur].CoutAmelioration[0][0].Ressource := plaques_de_fer;
  Constructions[constructeur].CoutAmelioration[0][0].Quantite := 20;
  Constructions[constructeur].CoutAmelioration[0][1].Ressource := sacs_de_beton;
  Constructions[constructeur].CoutAmelioration[0][1].Quantite := 20;
  SetLength(Constructions[constructeur].CoutAmelioration[1], 2);
  Constructions[constructeur].CoutAmelioration[1][0].Ressource := plaques_de_fer;
  Constructions[constructeur].CoutAmelioration[1][0].Quantite := 20;
  Constructions[constructeur].CoutAmelioration[1][1].Ressource := acier;
  Constructions[constructeur].CoutAmelioration[1][1].Quantite := 20;

  // HUB
  Constructions[hub].Nom := 'HUB';
  Constructions[hub].EnergieConsommee := 100;
  SetLength(Constructions[hub].CoutConstruction, 0);
  SetLength(Constructions[hub].CoutAmelioration, 0);

  // Centrale électrique
  Constructions[centrale_elec].Nom := 'Centrale électrique';
  SetLength(Constructions[centrale_elec].CoutConstruction, 3);
  Constructions[centrale_elec].CoutConstruction[0].Ressource := cables_de_cuivre;
  Constructions[centrale_elec].CoutConstruction[0].Quantite := 30;
  Constructions[centrale_elec].CoutConstruction[1].Ressource := plaques_de_fer;
  Constructions[centrale_elec].CoutConstruction[1].Quantite := 10;
  Constructions[centrale_elec].CoutConstruction[2].Ressource := sacs_de_beton;
  Constructions[centrale_elec].CoutConstruction[2].Quantite := 20;
  Constructions[centrale_elec].EnergieConsommee := 1200; // produit 1200 d’énergie

  // Ascenseur orbital
  Constructions[ascenseur_orbitale].Nom := 'Ascenseur orbital';
  SetLength(Constructions[ascenseur_orbitale].CoutConstruction, 3);
  Constructions[ascenseur_orbitale].CoutConstruction[0].Ressource := cables_de_cuivre;
  Constructions[ascenseur_orbitale].CoutConstruction[0].Quantite := 200;
  Constructions[ascenseur_orbitale].CoutConstruction[1].Ressource := plaques_de_fer;
  Constructions[ascenseur_orbitale].CoutConstruction[1].Quantite := 200;
  Constructions[ascenseur_orbitale].CoutConstruction[2].Ressource := sacs_de_beton;
  Constructions[ascenseur_orbitale].CoutConstruction[2].Quantite := 200;
  Constructions[ascenseur_orbitale].EnergieConsommee := 1000;
end;

function haveEnoughResources(typologie : TypeConstructions; niveau : Integer): boolean;
var 
  i, verification, good : Integer;
begin
  // si niveau = 1 alors on vérifie le coût de construction
  if niveau = 1 then
    verification := High(Constructions[typologie].CoutConstruction)
  else
    // sinon on vérifie le coût d'amélioration correspondant
    verification := High(Constructions[typologie].CoutAmelioration[niveau + 1]);

  good := 0;

  deplacerCurseurXY(8,35);
  Write(verification);

  if niveau = 1 then
  begin
    for i := Low(Constructions[typologie].CoutConstruction) to High(Constructions[typologie].CoutConstruction) do
    begin
      // je verifie que il a les ressources necessaires
      if getPlayerResource(Constructions[typologie].CoutConstruction[i].Ressource) >= 
         Constructions[typologie].CoutConstruction[i].Quantite then
      begin
        good := good + 1; // si il a assez des ressources pour cette condition alors je dit que une condition est vérifié
      end;
    end;
  end
  else
  begin
    for i := Low(Constructions[typologie].CoutAmelioration[niveau - 1]) to High(Constructions[typologie].CoutAmelioration[niveau - 1]) do
    begin
      // je verifie que il a les ressources necessaires
      if getPlayerResource(Constructions[typologie].CoutAmelioration[niveau - 1][i].Ressource) >= 
         Constructions[typologie].CoutAmelioration[niveau - 1][i].Quantite then
      begin
        good := good + 1; 
        //deplacerCurseurXY(8,36);
        //Write(good);
      end;
    end;
  end;

  // je retourne un boolean en fonction si toutes les conditions ont été vérifié
  haveEnoughResources := (verification + 1 = good);
end;

// procedure pour enlever les ressources
procedure removeRessources(typologie : TypeConstructions; niveau : Integer);
  var 
   r,i : Integer;
  begin
   if niveau = 1 then
    begin
      r := High(Constructions[typologie].CoutConstruction);
    end
   else
    begin
      r := High(Constructions[typologie].CoutAmelioration)
    end;
    
    if niveau = 1 then
      begin
        for i:= Low(Constructions[typologie].CoutConstruction) to High(Constructions[typologie].CoutConstruction) do
          begin
            removePlayerResource(Constructions[typologie].CoutConstruction[i].Ressource,Constructions[typologie].CoutConstruction[i].Quantite);
          end
      end
      else 
        begin
          for i := Low(Constructions[typologie].CoutAmelioration[niveau - 1]) to Low(Constructions[typologie].CoutAmelioration[niveau - 1]) do
            begin
              removePlayerResource(Constructions[typologie].CoutAmelioration[niveau - 1][i].Ressource,Constructions[typologie].CoutAmelioration[niveau - 1][i].Quantite);
            end
        end;

  end;


end.
