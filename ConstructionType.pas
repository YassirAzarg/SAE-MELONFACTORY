unit ConstructionType;

interface

type
  TypeConstructions = (
    mine,
    constructeur,
    hub,
    centrale_elec,
    ascenseur_orbitale,
    aucune
  );

function getLabelConstruction(construction : TypeConstructions) : String;

implementation

const 
  ConstructionLabels: array[TypeConstructions] of string = (
    'Mine Mk',
    'Constructeur',
    'HUB',
    'Centrale électrique',
    'Ascenseur orbital',
    'Aucun'
  );

function getLabelConstruction(construction : TypeConstructions) : String;
begin
  getLabelConstruction := ConstructionLabels[construction];
end;

end.
