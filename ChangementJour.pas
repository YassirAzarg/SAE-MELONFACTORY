unit ChangementJour;


interface


// Fonction qui retourne le label du jour
function getJourLabel(jour : Jours) : String;

// Fonction qui retorune le prochain jour
function prochainJour(jourActuelle: Jours): Jours;

// Fonction qui retourne le label du Mois
function getMoisLabel(month : Mois) : String;

// Fonction qui retorune le prochain mois
function prochainMois(monthActuelle: Mois): Mois;

// Fonction pour avoir la date actuelle formaté
function getDateActuelle():String;

// Procedure pour initialiser la Date;
procedure initDate();

uses sysutils;

type
  Jours = (
    lundi,
    mardi,
    mercredi,
    jeudi,
    vendredi,
    samedi,
    dimanche,
  );

  Mois = (
    janvier,
    fevrier,
    mars,
    avril,
    mai,
    juin,
    juillet,
    aout,
    septembre,
    octobre,
    novembre,
    decembre
  );



implementation

const 
  JoursLabels: array[Jours] of string = (
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  );

  MoisLabels: array[Mois] of string = (
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Decembre'
  );

  MaxJoursMois : array[Mois] of Integer = (
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  );


  dateActuelle = record
    jourSemaine : Jour;
    jourMois : Integer;
    mois : Mois;
    annee : Integer;
  end;

var 
  tDate : array of dateActuelle;

// initialise la date
procedure initDate();
  begin
    SetLength(tDate,1);

    tDate[0].jourSemaine := mardi;
    tDate[0].jourMois := 2;
    tDate[0].mois := decembre;
    tDate[0].annee := 2025;

  end;

function getDateActuelle():String;
  begin
    getDateActuelle := getJourLabel(tDate[0].jourSemaine) + ' ' + tDate[0].jourMois + ' ' + getMoisLabel(tDate[0].mois) + ' ' + tDate[0].annee; 
  end;


//@param jour Jours le jour volu
//return String le label du jour
function getJourLabel(jour : Jours) : String;
  begin
    getJourLabel := JoursLabels[jour];
  end;


//@param jour Jours le jour actuelle
//return Jours le prochain jour
function prochainJour(jourActuelle: Jours): Jours;
begin
  if jourActuelle = dimanche then
    prochainJour := lundi
  else
    prochainJour := Succ(jourActuelle);
end;


//@param mois Mois le mois volu
//return String le label du mois
function getMoisLabel(month : Mois) : String;
  begin
    getMoisLabel := MoisLabels[month];
  end;

//@param mois Mois le mois actuelle
//return mois le prochain mois
function prochainMois(monthActuelle: Mois): Mois;
begin
  if monthActuelle = decembre then
    monthActuelle := janvier
  else
    prochainMois := Succ(monthActuelle);
end;



end.
 
  
