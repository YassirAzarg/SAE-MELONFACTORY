unit ChangementJour;


interface


// Fonction qui retourne le label du jour
function getJourLabel(jour : Jours) : String;


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

//@param jour Jours le jour volu
//return String le label du jour
function getJourLabel(jour : Jours) : String;
  begin
    getJourLabel := JoursLabels[jour];
  end;


end.
 
  
