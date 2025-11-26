unit EcranPrincipale;

interface

procedure menuGame();

implementation

procedure menuGame()
var
  choix: String;

begin
  choix := menu();

if (choix == '1') then
  begin
    renderGame();
  end
  else 
    begin
      quitter();
    end

end;

begin



end.
