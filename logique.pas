unit Logique;

interface

uses SysUtils, GestionEcran, Windows, utils;

procedure renderGame();
procedure quitter();

implementation

// Procedure qui lance le jeu
procedure renderGame();

type
  tLigne = record
    pos: coordonnees;
    texte: string;
  end;

var
  i: integer;
  lignes: array of tLigne;

begin

  effacerEcran();

  couleurTexte(Cyan);
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

end;


// Procedure pour quitter le jeu
procedure quitter();
begin
end;

begin
end.
