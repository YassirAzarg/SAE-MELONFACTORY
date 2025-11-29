unit ConstructionType;

interface

type
  TypeConstructions = (
    aucune,
    mine,
    constructeur,
    hub,
    centrale_elec,
    ascenseur_orbitale
    );

function getLabelConstruction(construction : TypeConstructions) : String;

implementation

function getLabelConstruction(construction : TypeConstructions) : String;
  var tConstruct : array of TypeConstructions;
  begin
  end;

end.
