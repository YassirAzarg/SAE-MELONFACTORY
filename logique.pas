unit Logique;

interface

uses SysUtils, GestionEcran, Windows, utils, Construction, ConstructionType,
  Emplacement, Resources, EcranAccueil,ChangementJour;

procedure renderGame(); // Procedure qui affiche l'interface texte
procedure quitter(); // Procedure pour quitter du jeu
procedure initInterfaceGame(); // Procedure qui initialise l'Interface principale
procedure buildBatiment(); // Procedure qui gére l'option construire un batiment

// procedure pour facilement écrire les resources
procedure writeResources(x, y: integer; str: string; resource: resourcesC;
  couleur: byte);

//Gérer le jeu
procedure manageGame(val: string);

// Procedure qui refresh la page des resources
procedure refreshInterfaceGame();

// Procedure pour le menu princpale
procedure menuGame();

//Fonction qui me permet de ecrire des texte lors de la selection et qui retourne un choix
function SelectionInterfaceGame(str: string): string;

//Fonction qui ecris une alerte 
procedure AlertInterfaceGame(str, subtitle: string; color: byte);


//Fonction pour choisir le type de batiment et la gestion
procedure SelectionBatiment(indexBat: integer);


// Fonction qui returne le label des typologies
function TypologieToString(t: TypeConstructions): string;

// Fonction qui permet de faire le choix au niveau du type de Constructeur
function ConstructeurChoice(): integer;

implementation

type
  tLigne = record
    pos: coordonnees;
    texte: string;
  end;


procedure menuGame();
var
  choix: string;

begin
  effacerEcran();
  choix := menu();

  if (choix = '1') then
  begin
    renderGame();
  end
  else
  begin
    quitter();
  end;

end;


procedure retourmenuGame();
var
  choix: string;
begin
  effacerEcran();
  choix := menuRetour();

  case choix of
    '1': renderGame();
    '2': quitter();
    '3': refreshInterfaceGame();
    else
      quitter();
  end;

end;



procedure writeResources(x, y: integer; str: string; resource: resourcesC;
  couleur: byte);
begin
  deplacerCurseurXY(x, y);
  couleurTexte(couleur);
  Write(str);
  deplacerCurseurXY(x + 28, y);
  Write(': ', getPlayerResource(resource));
end;



procedure initInterfaceGame();
var
  choix: string;
begin
  effacerEcran();
  couleurTexte(white);

  dessinerCadreXY(1, 1, 52, 40, simple, white, black);
  dessinerCadreXY(52, 1, 201, 40, simple, white, black);

  SetConsoleOutputCP(CP_UTF8);

  deplacerCurseurXY(15, 3);
  Write('INVENTAIRE DE LA ZONE');

  deplacerCurseurXY(77, 3);
  Write('ZONE : Zone de départ');

  deplacerCurseurXY(153, 3);
  printDateActuelle();

  couleurTexte(Cyan);
  writeResources(6, 6, 'Marza''Coin', marzacoins, Cyan);

  couleurTexte(red);
  writeResources(6, 8, 'Production d''électricité', production_elec, red);
  writeResources(6, 9, 'Consommation d''électricité', consommation_elec, red);

  couleurTexte(white);
  writeResources(6, 11, 'Minerai de cuivre', minerai_de_cuivre, white);
  writeResources(6, 12, 'Minerai de fer', minerai_de_fer, white);
  writeResources(6, 13, 'Calcaire', calcaire, white);
  writeResources(6, 14, 'Charbon', charbon, white);
  writeResources(6, 15, 'Lingots de cuivre', cuivre, white);
  writeResources(6, 16, 'Lingots de fer', fer, white);
  writeResources(6, 17, 'Cables de cuivre', cables_de_cuivre, white);
  writeResources(6, 18, 'Plaques de fer', plaques_de_fer, white);
  writeResources(6, 19, 'Tuyaux en fer', tuyaux_en_fer, white);
  writeResources(6, 20, 'Sacs de Béton', sacs_de_beton, white);
  writeResources(6, 21, 'Acier', acier, white);
  writeResources(6, 22, 'Plaques renforcées', plaques_renforcees, white);
  writeResources(6, 23, 'Poutres industrielles', poutres_industrielles, white);
  writeResources(6, 24, 'Fondations', fondations, white);

  deplacerCurseurXY(6, 28);
  Write('Que voulez-vous faire ?');

  deplacerCurseurXY(8, 29);
  Write('1/ Construire un bâtiment');

  deplacerCurseurXY(8, 30);
  Write('2/ Changer la production');

  deplacerCurseurXY(8, 31);
  Write('3/ Améliorer un bâtiment');

  deplacerCurseurXY(8, 32);
  Write('4/ Explorer la zone');

  deplacerCurseurXY(8, 33);
  Write('5/ Changer de zone');

  deplacerCurseurXY(8, 34);
  Write('6/ Transferer des ressources');

  deplacerCurseurXY(8, 35);
  Write('7/ Passer la journée');

  deplacerCurseurXY(8, 36);
  Write('8/ Missions');

  deplacerCurseurXY(8, 37);
  Write('9/ Wiki');

  deplacerCurseurXY(8, 38);
  Write('0/ Quitter la partie');

  SetConsoleOutputCP(850);
  dessinerCadreXY(41, 37, 51, 39, simple, white, black);

  initEmplacement();

  deplacerCurseurXY(43, 38);

  ReadLn(choix);

  manageGame(choix);

end;


procedure refreshInterfaceGame();
var
  choix: string;
begin
  effacerEcran();
  couleurTexte(white);

  dessinerCadreXY(1, 1, 52, 40, simple, white, black);
  dessinerCadreXY(52, 1, 201, 40, simple, white, black);

  SetConsoleOutputCP(CP_UTF8);

  deplacerCurseurXY(15, 3);
  Write('INVENTAIRE DE LA ZONE');

  deplacerCurseurXY(77, 3);
  Write('ZONE : Zone de départ');

  deplacerCurseurXY(153, 3);
  printDateActuelle();

  couleurTexte(Cyan);
  writeResources(6, 6, 'Marza''Coin', marzacoins, Cyan);

  couleurTexte(red);
  writeResources(6, 8, 'Production d''électricité', production_elec, red);
  writeResources(6, 9, 'Consommation d''électricité', consommation_elec, red);

  couleurTexte(white);
  writeResources(6, 11, 'Minerai de cuivre', minerai_de_cuivre, white);
  writeResources(6, 12, 'Minerai de fer', minerai_de_fer, white);
  writeResources(6, 13, 'Calcaire', calcaire, white);
  writeResources(6, 14, 'Charbon', charbon, white);
  writeResources(6, 15, 'Lingots de cuivre', cuivre, white);
  writeResources(6, 16, 'Lingots de fer', fer, white);
  writeResources(6, 17, 'Cables de cuivre', cables_de_cuivre, white);
  writeResources(6, 18, 'Plaques de fer', plaques_de_fer, white);
  writeResources(6, 19, 'Tuyaux en fer', tuyaux_en_fer, white);
  writeResources(6, 20, 'Sacs de Béton', sacs_de_beton, white);
  writeResources(6, 21, 'Acier', acier, white);
  writeResources(6, 22, 'Plaques renforcées', plaques_renforcees, white);
  writeResources(6, 23, 'Poutres industrielles', poutres_industrielles, white);
  writeResources(6, 24, 'Fondations', fondations, white);

  deplacerCurseurXY(6, 28);
  Write('Que voulez-vous faire ?');

  deplacerCurseurXY(8, 29);
  Write('1/ Construire un bâtiment');

  deplacerCurseurXY(8, 30);
  Write('2/ Changer la production');

  deplacerCurseurXY(8, 31);
  Write('3/ Améliorer un bâtiment');

  deplacerCurseurXY(8, 32);
  Write('4/ Explorer la zone');

  deplacerCurseurXY(8, 33);
  Write('5/ Changer de zone');

  deplacerCurseurXY(8, 34);
  Write('6/ Transferer des ressources');

  deplacerCurseurXY(8, 35);
  Write('7/ Passer la journée');

  deplacerCurseurXY(8, 36);
  Write('8/ Missions');

  deplacerCurseurXY(8, 37);
  Write('9/ Wiki');

  deplacerCurseurXY(8, 38);
  Write('0/ Quitter la partie');

  SetConsoleOutputCP(850);
  dessinerCadreXY(41, 37, 51, 39, simple, white, black);

  dessineEmplacement();

  deplacerCurseurXY(43, 38);

  ReadLn(choix);

  manageGame(choix);

end;


function SelectionInterfaceGame(str: string): string;
var
  choix: string;
begin
  effacerEcran();
  couleurTexte(white);

  dessinerCadreXY(1, 1, 52, 40, simple, white, black);
  dessinerCadreXY(52, 1, 201, 40, simple, white, black);

  SetConsoleOutputCP(CP_UTF8);

  deplacerCurseurXY(15, 3);
  Write('INVENTAIRE DE LA ZONE');

  deplacerCurseurXY(77, 3);
  Write('ZONE : Zone de départ');

  deplacerCurseurXY(153, 3);
  printDateActuelle();

  couleurTexte(Cyan);
  writeResources(6, 6, 'Marza''Coin', marzacoins, Cyan);

  couleurTexte(red);
  writeResources(6, 8, 'Production d''électricité', production_elec, red);
  writeResources(6, 9, 'Consommation d''électricité', consommation_elec, red);

  couleurTexte(white);
  writeResources(6, 11, 'Minerai de cuivre', minerai_de_cuivre, white);
  writeResources(6, 12, 'Minerai de fer', minerai_de_fer, white);
  writeResources(6, 13, 'Calcaire', calcaire, white);
  writeResources(6, 14, 'Charbon', charbon, white);
  writeResources(6, 15, 'Lingots de cuivre', cuivre, white);
  writeResources(6, 16, 'Lingots de fer', fer, white);
  writeResources(6, 17, 'Cables de cuivre', cables_de_cuivre, white);
  writeResources(6, 18, 'Plaques de fer', plaques_de_fer, white);
  writeResources(6, 19, 'Tuyaux en fer', tuyaux_en_fer, white);
  writeResources(6, 20, 'Sacs de Béton', sacs_de_beton, white);
  writeResources(6, 21, 'Acier', acier, white);
  writeResources(6, 22, 'Plaques renforcées', plaques_renforcees, white);
  writeResources(6, 23, 'Poutres industrielles', poutres_industrielles, white);
  writeResources(6, 24, 'Fondations', fondations, white);

  deplacerCurseurXY(9, 31);
  WriteLn(str);
  SetConsoleOutputCP(850);
  dessinerCadreXY(41, 37, 51, 39, simple, white, black);

  dessineEmplacement();

  deplacerCurseurXY(43, 38);

  ReadLn(choix);

  SelectionInterfaceGame := choix;

end;


function MultiSelectionInterfaceGame(msg: array of tLigne): string;
var
  choix: string;
  i: integer;
begin
  effacerEcran();
  couleurTexte(white);

  dessinerCadreXY(1, 1, 52, 40, simple, white, black);
  dessinerCadreXY(52, 1, 201, 40, simple, white, black);

  SetConsoleOutputCP(CP_UTF8);

  deplacerCurseurXY(15, 3);
  Write('INVENTAIRE DE LA ZONE');

  deplacerCurseurXY(77, 3);
  Write('ZONE : Zone de départ');

  deplacerCurseurXY(153, 3);
  printDateActuelle();

  couleurTexte(Cyan);
  writeResources(6, 6, 'Marza''Coin', marzacoins, Cyan);

  couleurTexte(red);
  writeResources(6, 8, 'Production d''électricité', production_elec, red);
  writeResources(6, 9, 'Consommation d''électricité', consommation_elec, red);

  couleurTexte(white);
  writeResources(6, 11, 'Minerai de cuivre', minerai_de_cuivre, white);
  writeResources(6, 12, 'Minerai de fer', minerai_de_fer, white);
  writeResources(6, 13, 'Calcaire', calcaire, white);
  writeResources(6, 14, 'Charbon', charbon, white);
  writeResources(6, 15, 'Lingots de cuivre', cuivre, white);
  writeResources(6, 16, 'Lingots de fer', fer, white);
  writeResources(6, 17, 'Cables de cuivre', cables_de_cuivre, white);
  writeResources(6, 18, 'Plaques de fer', plaques_de_fer, white);
  writeResources(6, 19, 'Tuyaux en fer', tuyaux_en_fer, white);
  writeResources(6, 20, 'Sacs de Béton', sacs_de_beton, white);
  writeResources(6, 21, 'Acier', acier, white);
  writeResources(6, 22, 'Plaques renforcées', plaques_renforcees, white);
  writeResources(6, 23, 'Poutres industrielles', poutres_industrielles, white);
  writeResources(6, 24, 'Fondations', fondations, white);

  for i := Low(msg) to High(msg) do
  begin
    deplacerCurseurXY(msg[i].pos.x, msg[i].pos.y);
    Write(msg[i].texte);
  end;

  SetConsoleOutputCP(850);
  dessinerCadreXY(41, 37, 51, 39, simple, white, black);

  dessineEmplacement();

  deplacerCurseurXY(43, 38);
  ReadLn(choix);

  MultiSelectionInterfaceGame := choix;

end;

procedure AlertInterfaceGame(str, subtitle: string; color: byte);
var
  choix: string;
begin
  effacerEcran();
  couleurTexte(white);

  dessinerCadreXY(1, 1, 52, 40, simple, white, black);
  dessinerCadreXY(52, 1, 201, 40, simple, white, black);

  SetConsoleOutputCP(CP_UTF8);

  deplacerCurseurXY(15, 3);
  Write('INVENTAIRE DE LA ZONE');

  deplacerCurseurXY(77, 3);
  Write('ZONE : Zone de départ');

  deplacerCurseurXY(153, 3);
  printDateActuelle();

  couleurTexte(Cyan);
  writeResources(6, 6, 'Marza''Coin', marzacoins, Cyan);

  couleurTexte(red);
  writeResources(6, 8, 'Production d''électricité', production_elec, red);
  writeResources(6, 9, 'Consommation d''électricité', consommation_elec, red);

  couleurTexte(white);
  writeResources(6, 11, 'Minerai de cuivre', minerai_de_cuivre, white);
  writeResources(6, 12, 'Minerai de fer', minerai_de_fer, white);
  writeResources(6, 13, 'Calcaire', calcaire, white);
  writeResources(6, 14, 'Charbon', charbon, white);
  writeResources(6, 15, 'Lingots de cuivre', cuivre, white);
  writeResources(6, 16, 'Lingots de fer', fer, white);
  writeResources(6, 17, 'Cables de cuivre', cables_de_cuivre, white);
  writeResources(6, 18, 'Plaques de fer', plaques_de_fer, white);
  writeResources(6, 19, 'Tuyaux en fer', tuyaux_en_fer, white);
  writeResources(6, 20, 'Sacs de Béton', sacs_de_beton, white);
  writeResources(6, 21, 'Acier', acier, white);
  writeResources(6, 22, 'Plaques renforcées', plaques_renforcees, white);
  writeResources(6, 23, 'Poutres industrielles', poutres_industrielles, white);
  writeResources(6, 24, 'Fondations', fondations, white);

  couleurTexte(color);
  deplacerCurseurXY(9, 31);
  Write(str);
  deplacerCurseurXY(9, 32);
  Write(subtitle);
  couleurTexte(white);
  SetConsoleOutputCP(850);

  dessineEmplacement();

  ReadLn();

end;

function TypologieToString(t: TypeConstructions): string;
begin
  case t of
    aucune: TypologieToString := 'aucune';
    hub: TypologieToString := 'HUB';
    mine: TypologieToString := 'MINE';
    constructeur: TypologieToString := 'CONSTRUCTEUR';
  end;
end;



//@param indexBat entier qui indique l'Emplacement
procedure SelectionBatiment(indexBat: integer);
var
  choixStr: string;
  choix: integer;
  choix2: integer;
  tMessage: array of tLigne;
  tPossibilite: array of TypeConstructions;
  tRessources: array of resourcesC;
begin

  SetLength(tMessage, 5);
  tMessage[0].pos.x := 6;
  tMessage[0].pos.y := 28;
  tMessage[0].texte := 'Quel bâtiment voulez vous construire ?';

  tMessage[1].pos.x := 8;
  tMessage[1].pos.y := 29;
  tMessage[1].texte := '1/ Construire une mine';

  tMessage[2].pos.x := 8;
  tMessage[2].pos.y := 30;
  tMessage[2].texte := '2/ Construire un constructeur';

  tMessage[3].pos.x := 8;
  tMessage[3].pos.y := 31;
  tMessage[3].texte := '3/ Construire une centrale';

  tMessage[4].pos.x := 8;
  tMessage[4].pos.y := 32;
  tMessage[4].texte := '4/ Construire l''ascenseur orbital ';

  SetLength(tPossibilite, 5);
  tPossibilite[0] := mine;
  tPossibilite[1] := constructeur;
  tPossibilite[2] := centrale_elec;
  tPossibilite[3] := ascenseur_orbitale;

  SetLength(tRessources, 11);

  tRessources[1] := cuivre;
  tRessources[2] := fer;
  tRessources[3] := cables_de_cuivre;
  tRessources[4] := plaques_de_fer;
  tRessources[5] := tuyaux_en_fer;
  tRessources[6] := sacs_de_beton;
  tRessources[7] := acier;
  tRessources[8] := plaques_renforcees;
  tRessources[9] := poutres_industrielles;
  tRessources[10] := fondations;


  choixStr := MultiSelectionInterfaceGame(tMessage);
  choix := StrToInt(choixStr) - 1;

  // Si il est pas decouvert
  if not getEmplacements()[indexBat].decouvert then
  begin
    AlertInterfaceGame('Impossible de construire ici',
      ' Emplacement non decouvert', red);
    refreshInterfaceGame();
  end
  // Si typologie = hub alors impossible
  else if getEmplacements()[indexBat].typologie = hub then
  begin
    AlertInterfaceGame('Impossible de construire ici',
      TypologieToString(getEmplacements()[indexBat].typologie), red);
    refreshInterfaceGame();
  end
  // Si un bâtiment existe déjà (typologie <> aucune), impossible de construire
  else if getEmplacements()[indexBat].typologie <> aucune then
  begin
    AlertInterfaceGame('Impossible de construire',
      ' Un bâtiment existe déjà ici', red);
    refreshInterfaceGame();
  end
  // Si une mine est demandée mais pas de gisement
  else if (tPossibilite[choix] = mine) and not getEmplacements()[indexBat].gisement then
  begin
    AlertInterfaceGame('Impossible de construire', ' Pas de gisement exploitable', red);
    refreshInterfaceGame();
  end
  // Construction possible (emplacement libre : typologie = aucune)
  else
  begin
    if haveEnoughResources(tPossibilite[choix], getEmplacements()[indexBat].niveau) then
    begin
      // Cas spécial pour le constructeur
      if tPossibilite[choix] = constructeur then
      begin
        choix2 := ConstructeurChoice();
        setConstructionParametre(indexBat, getEmplacements()[indexBat].decouvert,
          getEmplacements()[indexBat].gisement,
          tPossibilite[choix], False, tRessources[choix2],
          getEmplacements()[indexBat].niveau);
      end
      // Cas spécial pour la centrale électrique
      else if tPossibilite[choix] = centrale_elec then
      begin
        setConstructionParametre(indexBat, getEmplacements()[indexBat].decouvert,
          getEmplacements()[indexBat].gisement,
          tPossibilite[choix], False, production_elec,
          getEmplacements()[indexBat].niveau);
        setPlayerResource(production_elec, getPlayerResource(production_elec) +
          getEnergieProduite(getEmplacements()[indexBat].niveau));
      end
      // Cas pour la mine et autres bâtiments
      else
      begin
        setConstructionParametre(indexBat, getEmplacements()[indexBat].decouvert,
          getEmplacements()[indexBat].gisement,
          tPossibilite[choix], False,
          traiterResource(getEmplacements()[indexBat].minerai),
          getEmplacements()[indexBat].niveau);
      end;

      removeRessources(tPossibilite[choix], getEmplacements()[indexBat].niveau);
      AlertInterfaceGame('Construction Effectué', 'Bravo !', green);
      refreshInterfaceGame();
    end
    else
    begin
      AlertInterfaceGame('Impossible de construire', ' Pas assez de ressources', red);
      refreshInterfaceGame();
    end;
  end;

end;


// Fonction helper qui m'aide a faire un choix au niveau des resources que je veux
function ConstructeurChoice(): integer;
var
  choix: integer;
  tMessage, tMessage2: array of tLigne;
  page: integer;
begin
  page := 1;

  SetLength(tMessage, 7);
  SetLength(tMessage2, 7);

  tMessage[0].pos.x := 6;
  tMessage[0].pos.y := 28;
  tMessage[0].texte := 'Que doit produire le constructeur ?';
  tMessage[1].pos.x := 8;
  tMessage[1].pos.y := 29;
  tMessage[1].texte := '1/ Lingots de cuivre';
  tMessage[2].pos.x := 8;
  tMessage[2].pos.y := 30;
  tMessage[2].texte := '2/ Lingots de fer';
  tMessage[3].pos.x := 8;
  tMessage[3].pos.y := 31;
  tMessage[3].texte := '3/ Cables de cuivre';
  tMessage[4].pos.x := 8;
  tMessage[4].pos.y := 32;
  tMessage[4].texte := '4/ Plaques de fer ';
  tMessage[5].pos.x := 8;
  tMessage[5].pos.y := 33;
  tMessage[5].texte := '5/ Tuyaux en fer ';
  tMessage[6].pos.x := 8;
  tMessage[6].pos.y := 34;
  tMessage[6].texte := '6/ Autre ';

  tMessage2[0].pos.x := 6;
  tMessage2[0].pos.y := 28;
  tMessage2[0].texte := 'Que doit produire le constructeur ?';
  tMessage2[1].pos.x := 8;
  tMessage2[1].pos.y := 29;
  tMessage2[1].texte := '1/ Sacs de Béton';
  tMessage2[2].pos.x := 8;
  tMessage2[2].pos.y := 30;
  tMessage2[2].texte := '2/ Acier';
  tMessage2[3].pos.x := 8;
  tMessage2[3].pos.y := 31;
  tMessage2[3].texte := '3/ Plaques renforcées';
  tMessage2[4].pos.x := 8;
  tMessage2[4].pos.y := 32;
  tMessage2[4].texte := '4/ Poutres industrielles';
  tMessage2[5].pos.x := 8;
  tMessage2[5].pos.y := 33;
  tMessage2[5].texte := '5/ Fondations';
  tMessage2[6].pos.x := 8;
  tMessage2[6].pos.y := 34;
  tMessage2[6].texte := '6/ Autre ';

  repeat
    if page = 1 then
      choix := StrToInt(MultiSelectionInterfaceGame(tMessage))
    else
      choix := StrToInt(MultiSelectionInterfaceGame(tMessage2));

    // si l'utilisateur choisit 6 je le passe à l'autre page
    if (choix = 6) and (page = 1) then
      page := 2
    else if (choix = 6) and (page = 2) then
      page := 1


  until choix <> 6; // boucle tant que l'utilisateur choisit 6

  if page = 2 then
  begin
    choix := choix * 2; // si page 2 je fais fois 2
  end;


  ConstructeurChoice := choix;
end;

// procedure pour upgrade les batiments
procedure upgradeBatiment();

var
  choixStr: string;
  choix: integer;

begin

  choixStr := SelectionInterfaceGame('< Selectionnez un emplacement >');

  if choixStr = '' then
  begin
    AlertInterfaceGame('Impossible de construire ici', '   Aucune valeur saisie', red);
    refreshInterfaceGame();
  end;

  choix := StrToInt(choixStr);

  choix := choix - 1;

  if (getEmplacements()[choix].typologie <> aucune) then
  begin
    if getEmplacements()[choix].niveau < 3 then
    begin
      if haveEnoughResources(getEmplacements()[choix].typologie,
        getEmplacements()[choix].niveau) then
      begin
        setConstructionParametre(choix, getEmplacements()[choix].decouvert,
          getEmplacements()[choix].gisement, getEmplacements()[choix].typologie,
          False, getEmplacements()[choix].minerai, getEmplacements()[choix].niveau + 1);
        AlertInterfaceGame('Amélioration réussie', 'Bravo !', green);
        refreshInterfaceGame;
      end
      else
      begin
        AlertInterfaceGame('Impossible d''améliorer',
          ' Pas assez de ressources', red);
        refreshInterfaceGame;
      end;
    end
    else
    begin
      AlertInterfaceGame('Impossible d''améliorer',
        ' Niveau maximum atteint !', red);
      refreshInterfaceGame;
    end;

  end
  else
  begin
    AlertInterfaceGame('Impossible d''améliorer',
      'Ce n''est pas un bâtiment !', red);
    refreshInterfaceGame;
  end;

end;

// procedure qui va permettre de changer de resources pour les constructeur
procedure changerDeResource();
var
  choixStr: string;
  choix: integer;
  choix2: integer;
  tRessources : array of resourcesC;

begin

  SetLength(tRessources, 11);

  tRessources[1] := cuivre;
  tRessources[2] := fer;
  tRessources[3] := cables_de_cuivre;
  tRessources[4] := plaques_de_fer;
  tRessources[5] := tuyaux_en_fer;
  tRessources[6] := sacs_de_beton;
  tRessources[7] := acier;
  tRessources[8] := plaques_renforcees;
  tRessources[9] := poutres_industrielles;
  tRessources[10] := fondations;

  choixStr := SelectionInterfaceGame('< Selectionnez un emplacement >');

  if choixStr = '' then
  begin
    AlertInterfaceGame('Impossible de effectuer l''action', '   Aucune valeur saisie', red);
    refreshInterfaceGame();
  end;

  choix := StrToInt(choixStr);

  choix := choix - 1;

  if getEmplacements()[choix].typologie = constructeur then
    begin

      choix2 := ConstructeurChoice();

      setConstructionParametre(choix, getEmplacements()[choix].decouvert, getEmplacements()[choix].gisement, constructeur, False, tRessources[choix2], getEmplacements()[choix].niveau);
      AlertInterfaceGame('Changement effectuer !', 'Nice !', green);
      refreshInterfaceGame;
    end
  else
    begin
      AlertInterfaceGame('Impossible de effectuer l''action', 'Ce n''est pas un constructeur ! ', red);
      refreshInterfaceGame;
    end;
      
end;


// Procedure qui gére les choix dans le interface de jeu
procedure manageGame(val: string);
begin
  case val of
    '0':
    begin

      // Procedure retour menu (avec retour possible a la partie actuelle)
      retourmenuGame();

    end;
    '1':
    begin
      buildBatiment();
    end;
    '2':
    begin
      changerDeResource();
    end;
    '3':
    begin
      upgradeBatiment();
    end;
    '4':
    begin
      explorerZone();
      refreshInterfaceGame();
    end;
    '5':
    begin
      refreshInterfaceGame();
    end;
    '6':
    begin
      refreshInterfaceGame();
    end;
    '7':
    begin
      // action pour 7
      //changerDeJour();
    end;
    '8':
    begin
      // action pour 8
    end;
    '9':
    begin
      // action pour 9
    end;
    else
    begin
      refreshInterfaceGame();
    end;
  end;
end;

// Procedure qui lance le jeu
procedure renderGame();

var
  i: integer;
  lignes: array of tLigne;

begin

  effacerEcran();

  // Définition du nombre total de lignes
  SetLength(lignes, 17);
  // J'utilise ici SetConsoleOutputCP pour appliquer l'encodage UTF-8 pour avoir les caractères spéciaux français.
  SetConsoleOutputCP(CP_UTF8);

  lignes[0].pos.x := 79;
  lignes[0].pos.y := 4;
  lignes[0].texte := 'Dans une réalité, pas si alternative que ça.';

  lignes[1].pos.x := 78;
  lignes[1].pos.y := 6;
  lignes[1].texte := '2024 : une année particulièrement compliquée.';

  lignes[2].pos.x := 51;
  lignes[2].pos.y := 7;
  lignes[2].texte :=
    'Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements';

  lignes[3].pos.x := 68;
  lignes[3].pos.y := 8;
  lignes[3].texte := 'se sont succédé entre janvier et mars. Oui, douze. En trois mois.';

  lignes[4].pos.x := 52;
  lignes[4].pos.y := 10;
  lignes[4].texte :=
    'L''instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans';

  lignes[5].pos.x := 51;
  lignes[5].pos.y := 11;
  lignes[5].texte :=
    'une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l''État, la direc';

  lignes[6].pos.x := 57;
  lignes[6].pos.y := 13;
  lignes[6].texte :=
    'utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.';

  lignes[7].pos.x := 52;
  lignes[7].pos.y := 15;
  lignes[7].texte :=
    'Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins';

  lignes[8].pos.x := 52;
  lignes[8].pos.y := 16;
  lignes[8].texte :=
    'novatrice : Envoyer les étudiant(e)s coloniser d''autres planètes et y construire des usines de pro';

  lignes[9].pos.x := 51;
  lignes[9].pos.y := 17;
  lignes[9].texte :=
    'duction automatisées. Un moyen simple (et étonnamment peu onéreux) d''obtenir rapidement les ressour';

  lignes[10].pos.x := 77;
  lignes[10].pos.y := 18;
  lignes[10].texte := 'ces nécessaires à la survie de l''établissement.';

  lignes[11].pos.x := 52;
  lignes[11].pos.y := 20;
  lignes[11].texte :=
    'C''est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord';

  lignes[12].pos.x := 53;
  lignes[12].pos.y := 21;
  lignes[12].texte :=
    'd''une fusée baptisée "Maëlle", fièrement assemblée lors d''une SAE du département GMP. Avec pour';

  lignes[13].pos.x := 54;
  lignes[13].pos.y := 22;
  lignes[13].texte :=
    'seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,';

  lignes[14].pos.x := 55;
  lignes[14].pos.y := 23;
  lignes[14].texte :=
    'vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.';

  lignes[15].pos.x := 63;
  lignes[15].pos.y := 25;
  lignes[15].texte :=
    'Maintenant, il est temps de vous mettre au travail. L''IUT a besoin de vous !';

  lignes[16].pos.x := 80;
  lignes[16].pos.y := 33;
  lignes[16].texte := '< Appuyez sur une touche pour continuer >';

  for i := 0 to High(lignes) do
  begin
    // Procedure pour ecrire avec une petite animation
    animEcriture(lignes[i].pos, lignes[i].texte);
  end;


  ReadLn();


  SetConsoleOutputCP(850);

  initDate();
  InitialiserConstructions();
  initResources();
  initInterfaceGame();


end;


// Procedure pour quitter le jeu
procedure quitter();
begin
end;


procedure buildBatiment();
var
  choixStr: string;
  choix: integer;
begin
  choixStr := SelectionInterfaceGame('< Selectionnez un emplacement >');

  if choixStr = '' then
  begin
    AlertInterfaceGame('Impossible de construire ici', '   Aucune valeur saisie', red);
    refreshInterfaceGame();
  end;

  choix := StrToInt(choixStr);

  choix := choix - 1;
  // Je affiche de 1 a 10 du coup l'utilisateur choisira un chiffre entre 1 et 10 sauf que moi la table elle est de 0 a 9.

  if (choix >= 0) and (choix <= 9) then
  begin
    SelectionBatiment(choix);
  end
  else
  begin
    AlertInterfaceGame('Impossible de construire ici', '   Emplacement inexistant', red);
    refreshInterfaceGame();
  end;
end;



end.
