unit ChangementJour;


interface



uses SysUtils, Resources, Emplacement, Construction, ConstructionType, ZoneType,GestionEcran , windows;

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

  TPanneRecord = record
    zone: TypeZone;
    index: integer;
  end;

var
  batimentsEnPannePersistants: array of TPanneRecord;

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

// Procedure pour changer de jour et afficher le bilan
procedure changerDeJour();

// Fonction pour verifier si un batiment est en panne
function estEnPanne(zone: TypeZone; index: integer): boolean;

// Procedure pour ajouter une panne
procedure ajouterPanne(zone: TypeZone; index: integer);

// Procedure pour enlever une panne
procedure enleverPanne(zone: TypeZone; index: integer);



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
  SetLength(batimentsEnPannePersistants, 0);
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

// Fonction pour verifier si un batiment est en panne
function estEnPanne(zone: TypeZone; index: integer): boolean;
var
  i: integer;
begin
  estEnPanne := False;
  for i := 0 to High(batimentsEnPannePersistants) do
  begin
    if (batimentsEnPannePersistants[i].zone = zone) and 
       (batimentsEnPannePersistants[i].index = index) then
    begin
      estEnPanne := True;
      Break;
    end;
  end;
end;

// Procedure pour ajouter une panne
procedure ajouterPanne(zone: TypeZone; index: integer);
var
  n: integer;
begin
  if not estEnPanne(zone, index) then
  begin
    n := Length(batimentsEnPannePersistants);
    SetLength(batimentsEnPannePersistants, n + 1);
    batimentsEnPannePersistants[n].zone := zone;
    batimentsEnPannePersistants[n].index := index;
  end;
end;

// Procedure pour enlever une panne
procedure enleverPanne(zone: TypeZone; index: integer);
var
  i, j: integer;
begin
  for i := 0 to High(batimentsEnPannePersistants) do
  begin
    if (batimentsEnPannePersistants[i].zone = zone) and 
       (batimentsEnPannePersistants[i].index = index) then
    begin
      // Decaler tous les elements apres celui-ci
      for j := i to High(batimentsEnPannePersistants) - 1 do
      begin
        batimentsEnPannePersistants[j] := batimentsEnPannePersistants[j + 1];
      end;
      SetLength(batimentsEnPannePersistants, Length(batimentsEnPannePersistants) - 1);
      Break;
    end;
  end;
end;


//procedure pour changer de jour
procedure changerDeJour();
var
  i, j, k: integer;
  aMineraiNecessaire: boolean;
  z: TypeZone;
  zoneTemp, zoneOrigine: TypeZone;
  totalMineraiProduit: array[resourcesC] of integer;
  totalRessourcesFabriquees: array[resourcesC] of integer;
  res: resourcesC;
  qqchProduit: boolean;
  ligneY: integer;
  panneChance: integer;
  nouvellesPannes: array[TypeZone] of array of record
    index: integer;
    typologie: TypeConstructions;
    niveau: integer;
  end;
  pannesAReparerAujourdhui: array[TypeZone] of array of record
    index: integer;
    typologie: TypeConstructions;
    niveau: integer;
  end;
  choixReparation: string;
  peutReparer: boolean;
  aConstructeurFonctionnel: boolean;
begin

  for res := Low(resourcesC) to High(resourcesC) do
  begin
    totalMineraiProduit[res] := 0;
    totalRessourcesFabriquees[res] := 0;
  end;
  
  for z := Low(TypeZone) to High(TypeZone) do
  begin
    SetLength(nouvellesPannes[z], 0);
    SetLength(pannesAReparerAujourdhui[z], 0);
  end;
  
  if getPlayerResource(production_elec) >= getPlayerResource(consommation_elec) then
  begin
    zoneTemp := getZoneActuelle();
    
    for z := Low(TypeZone) to High(TypeZone) do
    begin
      setZoneActuelle(z);
      
      for i := 0 to 9 do
      begin
        // Verifier si le batiment est deja en panne persistante
        if estEnPanne(z, i) then
        begin
          // Le batiment est toujours en panne, on skip la production
          Continue;
        end;
        
        // Verifier si le batiment tombe en panne aujourdhui, ( ja mis 5% de chance)
        panneChance := Random(100);
        
        if ((getEmplacements()[i].typologie = mine) or 
            (getEmplacements()[i].typologie = constructeur)) and 
            (panneChance < 5) then // ici changer pour la chance des panne
        begin
          // Le batiment tombe en panne aujourdhui (force !)
          k := Length(nouvellesPannes[z]);
          SetLength(nouvellesPannes[z], k + 1);
          nouvellesPannes[z][k].index := i;
          nouvellesPannes[z][k].typologie := getEmplacements()[i].typologie;
          nouvellesPannes[z][k].niveau := getEmplacements()[i].niveau;
          
          // Ajouter a la liste des pannes persistantes
          ajouterPanne(z, i);
          
          // On skip la production pour ce batiment
          Continue; 
        end;
        
        if getEmplacements()[i].typologie = constructeur then
        begin
          aMineraiNecessaire := False;
          
          for j := 0 to 9 do
          begin
            if (getEmplacements()[j].typologie = mine) and 
               (getEmplacements()[j].minerai = Recettes[getEmplacements()[i].minerai].RessourceEntree) and
               (not estEnPanne(z, j)) then
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
              
              totalRessourcesFabriquees[Recettes[getEmplacements()[i].minerai].RessourceSortie] :=
                totalRessourcesFabriquees[Recettes[getEmplacements()[i].minerai].RessourceSortie] +
                Recettes[getEmplacements()[i].minerai].QuantiteSortie;
            end;
          end;
        end;
      end;
      
      for i := 0 to 9 do
      begin
        if (getEmplacements()[i].typologie = mine) and (not estEnPanne(z, i)) then
        begin
          aConstructeurFonctionnel := False;
          
          for j := 0 to 9 do
          begin
            if (getEmplacements()[j].typologie = constructeur) and
               (Recettes[getEmplacements()[j].minerai].RessourceEntree = getEmplacements()[i].minerai) and
               (not estEnPanne(z, j)) then
            begin
              aConstructeurFonctionnel := True;
              Break;
            end;
          end;
          
          if aConstructeurFonctionnel then
          begin
            totalMineraiProduit[getEmplacements()[i].minerai] := 
              totalMineraiProduit[getEmplacements()[i].minerai] + 
              Constructions[mine].ProductionParNiveau[getEmplacements()[i].niveau];
              
            addPlayerResource(getEmplacements()[i].minerai, 
                             Constructions[mine].ProductionParNiveau[getEmplacements()[i].niveau]);
          end;
        end;
      end;
    end;
    
    setZoneActuelle(zoneTemp);
  end;
  
  // Preparer la liste des pannes a reparer aujourdhui
  for z := Low(TypeZone) to High(TypeZone) do
  begin
    setZoneActuelle(z);
    for i := 0 to 9 do
    begin
      if estEnPanne(z, i) then
      begin
        k := Length(pannesAReparerAujourdhui[z]);
        SetLength(pannesAReparerAujourdhui[z], k + 1);
        pannesAReparerAujourdhui[z][k].index := i;
        pannesAReparerAujourdhui[z][k].typologie := getEmplacements()[i].typologie;
        pannesAReparerAujourdhui[z][k].niveau := getEmplacements()[i].niveau;
      end;
    end;
  end;
  setZoneActuelle(zoneTemp);
  
  // Affichage du bilan
  effacerEcran();
  
  SetConsoleOutputCP(850);
  dessinerCadreXY(50, 10, 160, 36, simple, white, black);
  
  SetConsoleOutputCP(CP_UTF8);
  deplacerCurseurXY(85, 12);
  couleurTexte(14);
  Write('BILAN DU ');
  printDateActuelle();
  couleurTexte(white);
  
  ligneY := 16;
  
  // Verif elec
  if getPlayerResource(production_elec) >= getPlayerResource(consommation_elec) then
  begin
    deplacerCurseurXY(55, ligneY);
    couleurTexte(10);
    Write('√ ');
    couleurTexte(white);
    Write('Electricite : OK tout marche bien');
    ligneY := ligneY + 2;
    
    // Compter le total de nouvelles pannes
    k := 0;
    for z := Low(TypeZone) to High(TypeZone) do
    begin
      k := k + Length(nouvellesPannes[z]);
    end;
    
    // Afficher les nouvelles pannes si il y en a
    if k > 0 then
    begin
      deplacerCurseurXY(55, ligneY);
      couleurTexte(12);
      Write('ATTENTION : ', k, ' batiment(s) tombe en panne !');
      couleurTexte(white);
      ligneY := ligneY + 2;
      
      for z := Low(TypeZone) to High(TypeZone) do
      begin
        for i := 0 to High(nouvellesPannes[z]) do
        begin
          deplacerCurseurXY(60, ligneY);
          couleurTexte(8);
          Write('- ', getLabelConstruction(nouvellesPannes[z][i].typologie), 
               ' (Zone: ', getZoneLabel(z), ')');
          couleurTexte(white);
          ligneY := ligneY + 1;
        end;
      end;
      
      ligneY := ligneY + 1;
    end;
    
    //les minerais extraits
    qqchProduit := False;
    for res := Low(resourcesC) to High(resourcesC) do
    begin
      if totalMineraiProduit[res] > 0 then
      begin
        if not qqchProduit then
        begin
          deplacerCurseurXY(55, ligneY);
          couleurTexte(11);
          Write('EXTRACTION DE MINERAI :');
          couleurTexte(white);
          ligneY := ligneY + 2;
          qqchProduit := True;
        end;
        deplacerCurseurXY(60, ligneY);
        couleurTexte(6);
        Write('+ ');
        couleurTexte(white);
        Write(totalMineraiProduit[res], ' x ', getResourceLabel(res));
        ligneY := ligneY + 1;
      end;
    end;
    
    if qqchProduit then
      ligneY := ligneY + 1;
    
    // les ressources fabriquees
    qqchProduit := False;
    for res := Low(resourcesC) to High(resourcesC) do
    begin
      if totalRessourcesFabriquees[res] > 0 then
      begin
        if not qqchProduit then
        begin
          deplacerCurseurXY(55, ligneY);
          couleurTexte(11);
          Write('FABRICATION DE RESSOURCE :');
          couleurTexte(white);
          ligneY := ligneY + 2;
          qqchProduit := True;
        end;
        deplacerCurseurXY(60, ligneY);
        couleurTexte(6);
        Write('+ ');
        couleurTexte(white);
        Write(totalRessourcesFabriquees[res], ' x ', getResourceLabel(res));
        ligneY := ligneY + 1;
      end;
    end;
    
    if (ligneY = 18) and (k = 0) then
    begin
      deplacerCurseurXY(55, ligneY);
      couleurTexte(8);
      Write('Rien de special aujourdhui, tout est calme...');
      couleurTexte(white);
    end;
  end
  else
  begin
    deplacerCurseurXY(55, ligneY);
    couleurTexte(12);
    Write('X ');
    couleurTexte(white);
    Write('ALERTE : Pas assez d electricite !');
    ligneY := ligneY + 2;
    
    deplacerCurseurXY(60, ligneY);
    couleurTexte(8);
    Write('Toute les production sont arrete');
    ligneY := ligneY + 1;
    
    deplacerCurseurXY(60, ligneY);
    Write('Il faut construire plus de generateur');
    couleurTexte(white);
  end;
  
  
  ReadLn();
  
  zoneOrigine := getZoneActuelle();
  
  for z := Low(TypeZone) to High(TypeZone) do
  begin
    if Length(pannesAReparerAujourdhui[z]) > 0 then
    begin
      for i := 0 to High(pannesAReparerAujourdhui[z]) do
      begin
        effacerEcran();
        
        SetConsoleOutputCP(850);
        dessinerCadreXY(50, 10, 160, 36, simple, white, black);
        
        SetConsoleOutputCP(CP_UTF8);
        deplacerCurseurXY(80, 12);
        couleurTexte(12);
        Write('BATIMENT EN PANNE');
        couleurTexte(white);
        
        ligneY := 16;
        
        deplacerCurseurXY(55, ligneY);
        Write('Type : ', getLabelConstruction(pannesAReparerAujourdhui[z][i].typologie));
        ligneY := ligneY + 1;
        
        deplacerCurseurXY(55, ligneY);
        Write('Zone : ', getZoneLabel(z));
        ligneY := ligneY + 1;
        
        deplacerCurseurXY(55, ligneY);
        Write('Niveau : ', pannesAReparerAujourdhui[z][i].niveau);
        ligneY := ligneY + 2;
        
        // Afficher le cout de reparation
        deplacerCurseurXY(55, ligneY);
        couleurTexte(14);
        Write('COUT DE REPARATION :');
        couleurTexte(white);
        ligneY := ligneY + 2;
        
        // Changer vers la zone concernee pour verifier les ressources
        setZoneActuelle(z);
        setResourceZone(z);
        
        // Verifier si on peut reparer
        peutReparer := True;
        
        if pannesAReparerAujourdhui[z][i].niveau = 1 then
        begin
          // Pour niveau 1, on prend la moitie du cout de construction
          for j := Low(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction) to High(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction) do
          begin
            deplacerCurseurXY(60, ligneY);
            Write('- ', getResourceLabel(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Ressource), 
                 ' : ', Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Quantite div 2);
            
            if getPlayerResource(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Ressource) < 
               (Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Quantite div 2) then
            begin
              couleurTexte(12);
              Write(' (Manque)');
              couleurTexte(white);
              peutReparer := False;
            end;
            
            ligneY := ligneY + 1;
          end;
        end
        else
        begin
          // Pour niveau 2 ou 3, on prend la moitie du cout d'amelioration
          for j := Low(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2]) to 
                  High(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2]) do
          begin
            deplacerCurseurXY(60, ligneY);
            Write('- ', getResourceLabel(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Ressource), 
                 ' : ', Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Quantite div 2);
            
            if getPlayerResource(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Ressource) < 
               (Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Quantite div 2) then
            begin
              couleurTexte(12);
              Write(' (Manque)');
              couleurTexte(white);
              peutReparer := False;
            end;
            
            ligneY := ligneY + 1;
          end;
        end;
        
        ligneY := ligneY + 2;
        
        if peutReparer then
        begin
          deplacerCurseurXY(55, ligneY);
          couleurTexte(14);
          Write('Voulez-vous reparer ce batiment ? (O/N)');
          couleurTexte(white);
          
          SetConsoleOutputCP(850);
          dessinerCadreXY(95, 32, 115, 34, simple, white, black);
          SetConsoleOutputCP(CP_UTF8);
          deplacerCurseurXY(97, 33);
          ReadLn(choixReparation);
          
          if (choixReparation = 'O') or (choixReparation = 'o') then
          begin
            // Enlever les ressources et reparer
            if pannesAReparerAujourdhui[z][i].niveau = 1 then
            begin
              for j := Low(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction) to High(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction) do
              begin
                removePlayerResource(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Ressource, 
                                    Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutConstruction[j].Quantite div 2);
              end;
            end
            else
            begin
              for j := Low(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2]) to 
                      High(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2]) do
              begin
                removePlayerResource(Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Ressource, 
                                    Constructions[pannesAReparerAujourdhui[z][i].typologie].CoutAmelioration[pannesAReparerAujourdhui[z][i].niveau - 2][j].Quantite div 2);
              end;
            end;
            
            // Je enleve la panne de la liste ... sinon cest pas drole
            enleverPanne(z, pannesAReparerAujourdhui[z][i].index);
            
            effacerEcran();
            SetConsoleOutputCP(850);
            dessinerCadreXY(50, 15, 160, 25, simple, white, black);
            SetConsoleOutputCP(CP_UTF8);
            deplacerCurseurXY(85, 18);
            couleurTexte(10);
            Write('REPARATION EFFECTUE !');
            couleurTexte(white);
            deplacerCurseurXY(75, 20);
            Write('Le batiment fonctionne a nouveau');
            deplacerCurseurXY(80, 22);

            ReadLn();
          end
          else
          begin
            effacerEcran();
            SetConsoleOutputCP(850);
            dessinerCadreXY(50, 15, 160, 25, simple, white, black);
            SetConsoleOutputCP(CP_UTF8);
            deplacerCurseurXY(80, 18);
            couleurTexte(12);
            Write('REPARATION ANNULE');
            couleurTexte(white);
            deplacerCurseurXY(70, 20);
            couleurTexte(8);
            Write('Le batiment reste en panne...');
            couleurTexte(white);
            deplacerCurseurXY(80, 22);

            ReadLn();
          end;
        end
        else
        begin
          deplacerCurseurXY(55, ligneY);
          couleurTexte(12);
          Write('Impossible de reparer : pas assez de ressources');
          couleurTexte(white);
          deplacerCurseurXY(55, ligneY + 2);
          couleurTexte(8);
          Write('Le batiment reste en panne...');
          couleurTexte(white);
          deplacerCurseurXY(80, 33);

          SetConsoleOutputCP(850);

          ReadLn();
        end;
      end;
    end;
  end;

  SetConsoleOutputCP(850);
  
  // Revenir a la zone d'origine
  setZoneActuelle(zoneOrigine);
  setResourceZone(zoneOrigine);
  
  // Changement du jour
  tDate.jourSemaine := prochainJour(tDate.jourSemaine);
  tDate.jourMois := tDate.jourMois + 1;
  
  if tDate.jourMois > MaxJoursMois[tDate.mois] then
  begin
    tDate.jourMois := 1;
    tDate.mois := prochainMois(tDate.mois);
    
    if tDate.mois = janvier then
      tDate.annee := tDate.annee + 1;
  end;
end;


end.