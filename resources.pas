unit Resources;

interface

uses SysUtils, GestionEcran, ZoneType;

type
  resourcesC = (
    marzacoins,
    production_elec,
    consommation_elec,
    fer,
    cuivre,
    calcaire,
    acier,
    sacs_de_beton,
    plaques_de_fer,
    plaques_renforcees,
    minerai_de_cuivre,
    minerai_de_fer,
    cables_de_cuivre,
    poutres_industrielles,
    tuyaux_en_fer,
    fondations,
    charbon,
    aucun
    );

function traiterResource(resource: resourcesC) : resourcesC;
procedure initResources;
function getPlayerResource(resource: resourcesC): integer;
procedure setPlayerResource(resource: resourcesC; val: integer);
procedure addPlayerResource(resource: resourcesC; val: integer);
procedure removePlayerResource(resource: resourcesC; val: integer);
function getResourceLabel(resource: resourcesC): string;

// Nouvelles fonctions pour gérer les ressources par zone
procedure setResourceZone(zone: TypeZone);
function getResourceZone(): TypeZone;

implementation

var
  playerResource: array[TypeZone] of array[resourcesC] of integer; // Ressources par zone
  currentResourceZone: TypeZone; // Zone actuelle pour l  es ressources

const
  CONSOMATION_ELEC_DEPART = 100;
  PLAQUES_FER_DEPART = 100;
  CABLES_CUIVRE_DEPART = 100;
  SAC_BETONS = 20;

  ResourceLabels: array[resourcesC] of string = (
    'Marzacoins',
    'Electricité',
    'Consommation électrique',
    'Fer',
    'Cuivre',
    'Calcaire',
    'Acier',
    'Sacs de béton',
    'Plaques de fer',
    'Plaques renforcées',
    'Minerai de cuivre',
    'Minerai de fer',
    'Câbles de cuivre',
    'Poutres industrielles',
    'Tuyaux en fer',
    'Fondations',
    'Charbon',
    'Aucun'
    );

procedure setResourceZone(zone: TypeZone);
begin
  currentResourceZone := zone;
end;

function getResourceZone(): TypeZone;
begin
  getResourceZone := currentResourceZone;
end;

procedure initResources;
var
  res: resourcesC;
  z: TypeZone;
begin
  // Initialiser toutes les ressources pour toutes les zones
  for z := Low(TypeZone) to High(TypeZone) do
  begin
    for res := Low(resourcesC) to High(resourcesC) do
      playerResource[z][res] := 0;

    // Donner des ressources de départ seulement à la zone de départ
    if z = zone_depart then
    begin
      playerResource[z][cables_de_cuivre] := CABLES_CUIVRE_DEPART;
      playerResource[z][plaques_de_fer] := PLAQUES_FER_DEPART;
      playerResource[z][consommation_elec] := CONSOMATION_ELEC_DEPART;
      playerResource[z][sacs_de_beton] := SAC_BETONS;
    end;
  end;

  currentResourceZone := zone_depart;
end;

function getPlayerResource(resource: resourcesC): integer;
begin
  getPlayerResource := playerResource[currentResourceZone][resource];
end;

procedure setPlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[currentResourceZone][resource] := val;
end;

procedure addPlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[currentResourceZone][resource] := playerResource[currentResourceZone][resource] + val;
end;

procedure removePlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[currentResourceZone][resource] := playerResource[currentResourceZone][resource] - val;
end;

function getResourceLabel(resource: resourcesC): string;
begin
  getResourceLabel := ResourceLabels[resource];
end;

function traiterResource(resource: resourcesC) : resourcesC;
var
  tConvert : array[resourcesC] of resourcesC; 
begin
  tConvert[fer] := minerai_de_fer;
  tConvert[cuivre] := minerai_de_cuivre;

  if resource in [fer, cuivre] then
    begin
      traiterResource := tConvert[resource];
    end
  else
    traiterResource := resource; 
end;

end.