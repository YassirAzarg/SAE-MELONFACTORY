unit ChangementJour;


interface




uses SysUtils;

type
  Jours = (
    lundi,
    mardi,
    mercredi,
    jeudi,
    vendredi,
    samedi,
    dimanche
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

// Fonction qui retourne le label du jour
function getJourLabel(jour: Jours): string;

// Fonction qui retorune le prochain jour
function prochainJour(jourActuelle: Jours): Jours;

// Fonction qui retourne le label du Mois
function getMoisLabel(month: Mois): string;

// Fonction qui retorune le prochain mois
function prochainMois(monthActuelle: Mois): Mois;

// Fonction pour avoir la date actuelle formaté
procedure printDateActuelle();


// Procedure pour initialiser la Date;
procedure initDate();



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

  MaxJoursMois: array[Mois] of integer = (
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

type
  dateActuelle = record
    jourSemaine: Jours;
    jourMois: integer;
    mois: Mois;
    annee: integer;
  end;

var
  tDate: dateActuelle;

// initialise la date
procedure initDate();
begin
  tDate.jourSemaine := mardi;
  tDate.jourMois := 2;
  tDate.mois := decembre;
  tDate.annee := 2025;
end;

procedure printDateActuelle();
begin
  
  Write(getJourLabel(tDate.jourSemaine),' ',tDate.jourMois,' ',getMoisLabel(tDate.mois),' ',tDate.annee);

end;


//@param jour Jours le jour volu
//return String le label du jour
function getJourLabel(jour: Jours): string;
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
function getMoisLabel(month: Mois): string;
begin
  getMoisLabel := MoisLabels[month];
end;

//@param mois Mois le mois actuelle
//return mois le prochain mois
function prochainMois(monthActuelle: Mois): Mois;
begin
  if monthActuelle = decembre then
    prochainMois := janvier
  else
    prochainMois := Succ(monthActuelle);
end;




end.