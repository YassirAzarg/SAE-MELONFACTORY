unit Construction;

interface

uses SysUtils, GestionEcran, utils, Resources, ConstructionType;


type

  TConstruction = record
    Nom: string;
    CoutConstruction: array of record
      Ressource: resourcesC;
      Quantite: integer;
      EnergieProduite: integer;
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

//Procedure qui sert a enlever les ressource lors de la construction
//@param typologie TypeConstructions indique le type de construction
//@param Niveau actuelle
procedure removeRessources(typologie : TypeConstructions; niveau : Integer);


// Function qui me retourne la production actuelle de l'Energie en fonction du niveau
// @param niveau actuelle
// return Quantité
function getEnergieProduite(niveau : Integer): Integer;


implementation

procedure InitialiserConstructions;
begin
  // Mine
  Constructions[mine].Nom := 'Mine Mk.';
  SetLength(Constructions[mine].CoutConstruction, 1);
  Constructions[mine].CoutConstruction[0].Ressource := plaques_de_fer;
  Constructions[mine].CoutConstruction[0].Quantite := 10;
  Constructions[mine].EnergieConsommee := 100;
  SetLength(Constructions[mine].CoutAmelioration, 2);
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
  Constructions[centrale_elec].CoutConstruction[0].EnergieProduite := 1200; // Energie produite niveau 1
  
  Constructions[centrale_elec].CoutConstruction[1].Ressource := plaques_de_fer;
  Constructions[centrale_elec].CoutConstruction[1].Quantite := 10;
  Constructions[centrale_elec].CoutConstruction[1].EnergieProduite := 2400; // Energie produite niveau 2
  
  Constructions[centrale_elec].CoutConstruction[2].Ressource := sacs_de_beton;
  Constructions[centrale_elec].CoutConstruction[2].Quantite := 20;
  Constructions[centrale_elec].CoutConstruction[2].EnergieProduite := 3600; // Energie produite niveau 3
  
  SetLength(Constructions[centrale_elec].CoutAmelioration, 0);

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
  SetLength(Constructions[ascenseur_orbitale].CoutAmelioration, 0);
end;

// Function qui me retourne la production actuelle de l'Energie en fonction du niveau
// @param niveau actuelle
// return Quantité
function getEnergieProduite(niveau : Integer): Integer;
begin
  // Ici je retorune l'energie produite par le system 
  getEnergieProduite := Constructions[centrale_elec].CoutConstruction[niveau - 1].EnergieProduite;
end;

//Function qui sert a savoir si il a assez de ressources pour une construction 
//@param typologie TypeConstructions indique le type de construction
//@param Niveau actuelle
//return Oui ou Non si il a assez de ressources
function haveEnoughResources(typologie : TypeConstructions; niveau : Integer): boolean;
var 
  i, verification, good : Integer;
begin
  good := 0;

  // Niveau 1 = CoutConstruction
  if niveau = 1 then
  begin
    verification := High(Constructions[typologie].CoutConstruction);
    
    // je verifie que il a les ressources necessaires
    for i := Low(Constructions[typologie].CoutConstruction) to High(Constructions[typologie].CoutConstruction) do
    begin
      if getPlayerResource(Constructions[typologie].CoutConstruction[i].Ressource) >= 
         Constructions[typologie].CoutConstruction[i].Quantite then
      begin
        good := good + 1; // si il a assez des ressources pour cette condition alors je dit que une condition est vérifié
      end;
    end;
  end
  // Niveau 2 ou 3 = CoutAmelioration[0] ou [1]
  else
  begin
    verification := High(Constructions[typologie].CoutAmelioration[niveau - 2]);
    
    // je verifie que il a les ressources necessaires
    for i := Low(Constructions[typologie].CoutAmelioration[niveau - 2]) to High(Constructions[typologie].CoutAmelioration[niveau - 2]) do
    begin
      if getPlayerResource(Constructions[typologie].CoutAmelioration[niveau - 2][i].Ressource) >= 
         Constructions[typologie].CoutAmelioration[niveau - 2][i].Quantite then
      begin
        good := good + 1;
      end;
    end;
  end;

  // je retourne un boolean en fonction si toutes les conditions ont été vérifié
  haveEnoughResources := (verification + 1 = good);
end;

//Procedure qui sert a enlever les ressource lors de la construction
//@param typologie TypeConstructions indique le type de construction
//@param Niveau actuelle
procedure removeRessources(typologie : TypeConstructions; niveau : Integer);
var 
  i : Integer;
begin
  // Niveau 1 = CoutConstruction
  if niveau = 1 then
  begin
    for i := Low(Constructions[typologie].CoutConstruction) to High(Constructions[typologie].CoutConstruction) do
    begin
      removePlayerResource(Constructions[typologie].CoutConstruction[i].Ressource, 
                          Constructions[typologie].CoutConstruction[i].Quantite);
    end;
  end
  // Niveau 2 ou 3 = CoutAmelioration[0] ou [1]
  else
  begin
    for i := Low(Constructions[typologie].CoutAmelioration[niveau - 2]) to High(Constructions[typologie].CoutAmelioration[niveau - 2]) do
    begin
      removePlayerResource(Constructions[typologie].CoutAmelioration[niveau - 2][i].Ressource, 
                          Constructions[typologie].CoutAmelioration[niveau - 2][i].Quantite);
    end;
  end;
end;

end.