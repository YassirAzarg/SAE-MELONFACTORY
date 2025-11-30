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
 
  
