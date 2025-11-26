unit Emplacement;

interface

uses SysUtils, GestionEcran, utils, Logique, Resources, Construction;

type
  Emplacement = record
    id: integer;          // de 1 à 10
    niveau: integer;      // 1 à 3
    decouvert: boolean;   // Si True alors découvert sinon non
    gisement: boolean;    // Si True alors possibilité de construire une mine
    typologie: TypeConstructions;
    minerai: resources;   // Si gisement alors fer, calcaire ou cuivre
  end;


implementation