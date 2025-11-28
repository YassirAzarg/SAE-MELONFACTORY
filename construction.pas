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

procedure InitialiserConstructions;

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
  Constructions[centrale_elec].EnergieConsommee := -1200; // produit 1200 d’énergie

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

end.
