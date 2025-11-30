unit ChangementJour;


interface




uses SysUtils, Resources, Emplacement, Construction, ConstructionType;

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

// Procedure pour changer de jour
procedure changerDeJour();



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


//procedure pour changer de jour
procedure changerDeJour();
var
  i, j: integer;
  aMineraiNecessaire: boolean;
begin
  tDate.jourSemaine := prochainJour(tDate.jourSemaine);
  tDate.jourMois := tDate.jourMois + 1;
  
  if tDate.jourMois > MaxJoursMois[tDate.mois] then
  begin
    tDate.jourMois := 1;
    tDate.mois := prochainMois(tDate.mois);
    
    if tDate.mois = janvier then
      tDate.annee := tDate.annee + 1;
  end;
  
  if getPlayerResource(production_elec) >= getPlayerResource(consommation_elec) then
  begin
    for i := 0 to 9 do
    begin
      if getEmplacements()[i].typologie = mine then
      begin
        addPlayerResource(getEmplacements()[i].minerai, 
                         Constructions[mine].ProductionParNiveau[getEmplacements()[i].niveau]);
      end
      else if getEmplacements()[i].typologie = constructeur then
      begin
        aMineraiNecessaire := False;
        
        for j := 0 to 9 do
        begin
          if (getEmplacements()[j].typologie = mine) and 
             (getEmplacements()[j].minerai = Recettes[getEmplacements()[i].minerai].RessourceEntree) then
          begin
            aMineraiNecessaire := True;
            Break;
          end;
        end;
        
        if aMineraiNecessaire then
        begin
          if getPlayerResource(Recettes[getEmplacements()[i].minerai].RessourceEntree) >= 
             Recettes[getEmplacements()[i].minerai].QuantiteEntree then
          begin
            removePlayerResource(Recettes[getEmplacements()[i].minerai].RessourceEntree, 
                                Recettes[getEmplacements()[i].minerai].QuantiteEntree);
            addPlayerResource(Recettes[getEmplacements()[i].minerai].RessourceSortie, 
                             Recettes[getEmplacements()[i].minerai].QuantiteSortie);
          end;
        end;
      end;
    end;
  end;
end;




end.


end.