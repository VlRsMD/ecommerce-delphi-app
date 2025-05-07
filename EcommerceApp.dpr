program EcommerceApp;

uses
  Vcl.Forms,
  EcommerceShop in 'EcommerceShop.pas' {EccomerceApp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TEccomerceApp, EccomerceApp);
  Application.Run;
end.
