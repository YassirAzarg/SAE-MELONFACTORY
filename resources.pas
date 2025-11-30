unit Resources;

interface

uses SysUtils, GestionEcran;




type
  //Nouveau type : Resources pour indiquer les resources dispo pour le joueur
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

// Initialisation des resources (Resources du joueur)
procedure initResources;

// Fonction qui retorune le stock d une resource
//@parm resource de type ResourceC
//@return un entier qui indique le nombre de resources dispo
function getPlayerResource(resource: resourcesC): integer;


// Procedure qui set le nombre de resource d'une resource précise
//@param resource de type ResourceC
//@parm val de type entier qui est la Valeur qui va correpondre au nombre de resource dispo
procedure setPlayerResource(resource: resourcesC; val: integer);

// Procedure qui add un nombre au nombre de resource d'une resource précise
//@param resource de type ResourceC
//@parm val de type entier qui est la Valeur qui va étre ajouter au nombre de resource dispo
procedure addPlayerResource(resource: resourcesC; val: integer);

// Procedure qui remove un nombre au nombre de resource d'une resource précise
//@param resource de type ResourceC
//@parm val de type entier qui est la Valeur qui va étre ajouter au nombre de resource dispo
procedure removePlayerResource(resource: resourcesC; val: integer);


// Function pour avoir le nom d une resource a afficher
//@return le label textuel lié à la resource
function getResourceLabel(resource: resourcesC): string;


implementation

var
  playerResource: array[resourcesC] of integer; // Resources du joueur

const
  CONSOMATION_ELEC_DEPART = 100; // Constantes des resources reçu au départ

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



procedure initResources;
var
  res: resourcesC;
begin
  for res := Low(resourcesC) to High(resourcesC) do
    playerResource[res] := 0;

  playerResource[cables_de_cuivre] := CABLES_CUIVRE_DEPART;
  playerResource[plaques_de_fer] := PLAQUES_FER_DEPART;
  playerResource[consommation_elec] := CONSOMATION_ELEC_DEPART;
  playerResource[sacs_de_beton] := SAC_BETONS;

end;


//@parm resource de type ResourceC
//@return un entier qui indique le nombre de resources dispo
function getPlayerResource(resource: resourcesC): integer;
begin
  // return le nombre dispo de la resource
  getPlayerResource := playerResource[resource];
end;

//@param resource de type ResourceC
//@parm val de type entier qui est la Valeur qui va correpondre au nombre de resource dispo
procedure setPlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[resource] := val;
end;

procedure addPlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[resource] := getPlayerResource(resource) + val;
end;

procedure removePlayerResource(resource: resourcesC; val: integer);
begin
  playerResource[resource] := getPlayerResource(resource) - val;
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

  if resource in [fer, cuivre] then // on evite de passer une resource qui n'est pas dans le tableau tConvert
    begin
      traiterResource := tConvert[resource];
    end
  else
    traiterResource := resource; 


 end;


end.
