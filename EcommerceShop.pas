unit EcommerceShop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.XMLDoc, Xml.XMLIntf,
  Vcl.StdCtrls;

type
  TClothingItem = class
  public
    Name: string;
    Size: string;
    Price: Currency;
    constructor Create(const AName, ASize: string; APrice: Currency);
  end;

  TEccomerceApp = class(TForm)
    ListBoxProducts: TListBox;
    BtnSaveProducts: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveProductsClick(Sender: TObject);
  private
    FProducts: TList;
    procedure LoadProductsFromXML(const FileName: string);
    procedure SaveProductsToXML(const FileName: string);
    procedure ShowProducts;
  public

  end;

var
  EccomerceApp: TEccomerceApp;

implementation

{$R *.dfm}

constructor TClothingItem.Create(const AName, ASize: string; APrice: Currency);
begin
  Name := AName;
  Size := ASize;
  Price := APrice;
end;

procedure TEccomerceApp.BtnSaveProductsClick(Sender: TObject);
begin
  FProducts.Add(TClothingItem.Create('New Jacket', 'XL', 49.99));
  SaveProductsToXML(ExtractFilePath(ParamStr(0)) + 'products.xml');
  ShowMessage('New item saved.');
end;

procedure TEccomerceApp.FormCreate(Sender: TObject);
begin
  FProducts := TList.Create;
  LoadProductsFromXML(ExtractFilePath(ParamStr(0)) + 'products.xml');
  ShowProducts;
end;

procedure TEccomerceApp.LoadProductsFromXML(const FileName: string);
var
  Doc: IXMLDocument;
  Node, ItemNode: IXMLNode;
  Name, Size: string;
  Price: Currency;
  i: Integer;
begin
  if not FileExists(FileName) then
  begin
    ShowMessage('File not found: ' + FileName);
    Exit;
  end;

  Doc := TXMLDocument.Create(Self);
  try
    Doc.LoadFromFile(FileName);
    Doc.Active := True;
    Node := Doc.DocumentElement;

    for i := 0 to Node.ChildNodes.Count - 1 do
    begin
      ItemNode := Node.ChildNodes[i];
      Name := ItemNode.ChildNodes['Name'].Text;
      Size := ItemNode.ChildNodes['Size'].Text;
      Price := StrToCurrDef(ItemNode.ChildNodes['Price'].Text, 0.0);

      FProducts.Add(TClothingItem.Create(Name, Size, Price));
    end;
  finally
    Doc := nil;
  end;
end;

procedure TEccomerceApp.SaveProductsToXML(const FileName: string);
var
  Doc: IXMLDocument;
  RootNode, ItemNode: IXMLNode;
  i: Integer;
  Item: TClothingItem;
begin
  Doc := TXMLDocument.Create(nil);
  try
    Doc.Active := True;
    Doc.Version := '1.0';
    RootNode := Doc.AddChild('Products');

    for i := 0 to FProducts.Count - 1 do
    begin
      Item := TClothingItem(FProducts[i]);
      ItemNode := RootNode.AddChild('Product');
      ItemNode.AddChild('Name').Text := Item.Name;
      ItemNode.AddChild('Size').Text := Item.Size;
      ItemNode.AddChild('Price').Text := CurrToStr(Item.Price);
    end;

    Doc.SaveToFile(FileName);
  finally
    Doc := nil;
  end;
end;

procedure TEccomerceApp.ShowProducts;
var
  i: Integer;
  Item: TClothingItem;
  ProductList: TStringList;
begin
  ProductList := TStringList.Create;
  try
    for i := 0 to FProducts.Count - 1 do
    begin
      Item := TClothingItem(FProducts[i]);
      ProductList.Add(
        Format('%s - Size: %s - Price: $%.2f', [Item.Name, Item.Size, Item.Price])
      );
    end;
    ListBoxProducts.Items.Assign(ProductList);
  finally
    ProductList.Free;
  end;

end.

