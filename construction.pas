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
    ProductionParNiveau: array[1..3] of integer;
  end;

  TRecette = record
    RessourceEntree: resourcesC;
    QuantiteEntree: integer;
    RessourceSortie: resourcesC;
    QuantiteSortie: integer;
  end;

var
  Constructions: array[TypeConstructions] of TConstruction;
  Recettes: array[resourcesC] of TRecette;


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
  Constructions[mine].ProductionParNiveau[1] := 15;
  Constructions[mine].ProductionParNiveau[2] := 30;
  Constructions[mine].ProductionParNiveau[3] := 45;
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
  Constructions[centrale_elec].CoutConstruction[0].EnergieProduite := 1200;
  
  Constructions[centrale_elec].CoutConstruction[1].Ressource := plaques_de_fer;
  Constructions[centrale_elec].CoutConstruction[1].Quantite := 10;
  Constructions[centrale_elec].CoutConstruction[1].EnergieProduite := 2400;
  
  Constructions[centrale_elec].CoutConstruction[2].Ressource := sacs_de_beton;
  Constructions[centrale_elec].CoutConstruction[2].Quantite := 20;
  Constructions[centrale_elec].CoutConstruction[2].EnergieProduite := 3600;
  
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

  // Recettes de production d'apres la WIKI !!!!!!!!
  Recettes[cuivre].RessourceEntree := minerai_de_cuivre;
  Recettes[cuivre].QuantiteEntree := 15;
  Recettes[cuivre].RessourceSortie := cuivre;
  Recettes[cuivre].QuantiteSortie := 15;

  Recettes[fer].RessourceEntree := minerai_de_fer;
  Recettes[fer].QuantiteEntree := 30;
  Recettes[fer].RessourceSortie := fer;
  Recettes[fer].QuantiteSortie := 15;

  Recettes[cables_de_cuivre].RessourceEntree := cuivre;
  Recettes[cables_de_cuivre].QuantiteEntree := 15;
  Recettes[cables_de_cuivre].RessourceSortie := cables_de_cuivre;
  Recettes[cables_de_cuivre].QuantiteSortie := 5;

  Recettes[plaques_de_fer].RessourceEntree := fer;
  Recettes[plaques_de_fer].QuantiteEntree := 60;
  Recettes[plaques_de_fer].RessourceSortie := plaques_de_fer;
  Recettes[plaques_de_fer].QuantiteSortie := 10;

  Recettes[tuyaux_en_fer].RessourceEntree := fer;
  Recettes[tuyaux_en_fer].QuantiteEntree := 30;
  Recettes[tuyaux_en_fer].RessourceSortie := tuyaux_en_fer;
  Recettes[tuyaux_en_fer].QuantiteSortie := 10;

  Recettes[sacs_de_beton].RessourceEntree := calcaire;
  Recettes[sacs_de_beton].QuantiteEntree := 15;
  Recettes[sacs_de_beton].RessourceSortie := sacs_de_beton;
  Recettes[sacs_de_beton].QuantiteSortie := 5;

  Recettes[acier].RessourceEntree := minerai_de_fer;
  Recettes[acier].QuantiteEntree := 30;
  Recettes[acier].RessourceSortie := acier;
  Recettes[acier].QuantiteSortie := 15;

  Recettes[plaques_renforcees].RessourceEntree := plaques_de_fer;
  Recettes[plaques_renforcees].QuantiteEntree := 20;
  Recettes[plaques_renforcees].RessourceSortie := plaques_renforcees;
  Recettes[plaques_renforcees].QuantiteSortie := 2;

  Recettes[poutres_industrielles].RessourceEntree := plaques_de_fer;
  Recettes[poutres_industrielles].QuantiteEntree := 20;
  Recettes[poutres_industrielles].RessourceSortie := poutres_industrielles;
  Recettes[poutres_industrielles].QuantiteSortie := 2;

  Recettes[fondations].RessourceEntree := sacs_de_beton;
  Recettes[fondations].QuantiteEntree := 30;
  Recettes[fondations].RessourceSortie := fondations;
  Recettes[fondations].QuantiteSortie := 2;
end;

// Function qui me retourne la production actuelle de l'Energie en fonction du niveau
// @param niveau actuelle
// return Quantité
function getEnergieProduite(niveau : Integer): Integer;
begin
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
        good := good + 1;
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