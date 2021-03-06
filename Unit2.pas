unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,WinSock,   ScktComp,   CheckLst;
 const 
  MAX_ADAPTER_NAME_LENGTH = 256;
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
  MAX_ADAPTER_ADDRESS_LENGTH = 8;
type
  TIP_ADDRESS_STRING = record
    IPstring: array [0..15] of Char;
  end;
  PIP_ADDRESS_STRING = ^TIP_ADDRESS_STRING;
  TIP_MASK_STRING = TIP_ADDRESS_STRING;
  PIP_MASK_STRING = ^TIP_MASK_STRING;

  PIP_ADDR_STRING = ^TIP_ADDR_STRING;
  TIP_ADDR_STRING = record
    Next: PIP_ADDR_STRING;
    IpAddress: TIP_ADDRESS_STRING;
    IpMask: TIP_MASK_STRING;
    Context:DWORD;
  end;

  PIP_ADAPTER_INFO = ^TIP_ADAPTER_INFO;
  TIP_ADAPTER_INFO = packed record
    Next: PIP_ADAPTER_INFO;
    ComboIndex: DWORD;
    AdapterName: array [0..MAX_ADAPTER_NAME_LENGTH + 4-1] of Char;
    Description: array [0..MAX_ADAPTER_DESCRIPTION_LENGTH + 4-1] of Char;
    AddressLength: UINT;
    Address: array [0..MAX_ADAPTER_ADDRESS_LENGTH-1] of BYTE;
    Index: DWORD;
    dwType: UINT;
    DhcpEnabled: UINT;
    CurrentIpAddress: PIP_ADDR_STRING;
    IpAddressList: TIP_ADDR_STRING;
    GatewayList: TIP_ADDR_STRING;
    DhcpServer: TIP_ADDR_STRING;
    HaveWins: BOOL;
    PrimaryWinsServer: TIP_ADDR_STRING;
    SecondaryWinsServer: TIP_ADDR_STRING;
  end;
  ///////////////
  TForm1 = class(TForm)
    Button1: TButton;
    function   GetipFangshi:Boolean;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
function   GetAdaptersInfo(pAdapterInfo: PIP_ADAPTER_INFO;
                pOutBufLen: PDWORD): DWORD; stdcall;
                external 'IPHLPAPI.DLL' name 'GetAdaptersInfo';
{$R *.dfm}
function TForm1.GetipFangshi:Boolean;

var
  pbuf:PIP_ADAPTER_INFO;
  buflen:DWORD;
  i:   integer;
begin
  buflen:= 0;
  if GetAdaptersInfo(pbuf, @bufLen) = ERROR_BUFFER_OVERFLOW then
  begin
    pbuf:= AllocMem(buflen);
    if GetAdaptersInfo(pbuf, @bufLen) = ERROR_SUCCESS then
    while pbuf <> nil do
    begin
      //showmessage( IntToStr( pbuf.DhcpEnabled ) );//1动态分配
      if  pbuf.DhcpEnabled=1 then
      Result:=False else
      Result:=True;
      pbuf   :=   pbuf.Next;
    end;
    FreeMem(pbuf);
  end;
end;
  function test:string;
  begin
Result:='
[zjnbjsq]3CBB208C8231A122BCFE6C0A1CA56DED1D77BB0BFA5CC8F42CEF2F491D529EE14FD5654B0BE9A202C07F91A682D35CCB62A38054A1AEC1709F50D1B4B1CC576BEE000B962032EE711074DB9E1C5A4263D5E6D185E4A2F16D9718EBDF53C02A95ADD2CDA4E6B7A2AF6930D8EA4197981CE380EF3BC051EC541F4761582B0032A2DD9B9381EE646DE8CC57ED8FB419F8F582D506C5248BC600CC4D3928A8CE83F8058688544175F44920329506C86E0E1FB283A90B1C67B93EEEA3F7B29989856A01DCB03187930816F21A333536DF6FB7066D999F07FA96778F47ECD7FABD728D380E894C6697A12655AA6D794BBC84DDAAB336C745427D89327E300783404E5F47D678F9B1AABB93E7880FB4B35E48D3EA7DB523E5FCEF2E3FD445C06FAEDB8D0780A047D069988837FB47DECDD90418130147690BDD4011FF2928EFBBC810A12183E5EA95AAB8AED81AD86E72D063E9B7F3808D2BE175BA15FF72FD61181F98C6BFC0A03C92D31AB3C8BFB4F099DD6229FE566550B8510A8367BBF0C0C75CE81D9FF095FC9A182A7EDBB6548BDB9C74F51E978F9062B158C5AEB219ECCA6DA3BACAF6CF0E836366EA9D1A93CD6151ABB3CEC4E940D78934ECE832707622F9D084327B8AF9040C3AFAF46E0CE54516966211F80A1193B1117D501D28D0374BD20BD158C8C7E114061D6E5CE58FD126D042E0BBCD570AB4803C9EB0B1ED3437504FC5B29930DDBB6188A6F454A85F45F997DE7714B2F90FD61FABE0A3FD44146391110C41335791B43DFA2A2DA133B80945D4290F996CDB47E03EA53B54A7ADEDE915642C16E4F57E6881645B80A4D3BEAF0E965C887735A9A451FCF993B8478A1A73662391F7325CE04980EA726791BE333015C7629D2101[/zjnbjsq]
';
   end;  
procedure TForm1.Button1Click(Sender: TObject);
begin
if GetipFangshi=True then
ShowMessage('你的电脑是固定IP上网')
else
ShowMessage('你的电脑是动态IP上网');
end;

end.
 