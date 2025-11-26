unit emplacement;

interface

uses SysUtils, GestionEcran, utils, logique;

const
  FER_DEPART = 200;

type
  emplacement = record
    id: integer;          // de 1 à 10
    niveau: integer;      // 1 à 3
    decouvert: boolean;   // Si True alors découvert sinon non
    gisement: boolean;    // Si True alors possibilité de construire une mine
    typologie: string;
    // Mine, Constructeur, Central, AscenseurOrbital ou Hub (le hub est unique)
    minerai: string;      // Si gisement alors fer, calcaire ou cuivre
    energieConso: integer;
  end;


implementation