unit modCFOP_CFPS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, Vcl.StdActns, Data.DB;

type
  TfrmCFOP_CFPS = class(TForm)
    grpPesquisa: TGroupBox;
    rdpOpcoesPesquisa: TRadioGroup;
    grpConteudoPesquisa: TGroupBox;
    impPesquisar: TImage;
    edtConteudoPesquisa: TEdit;
    imgNovo: TImage;
    lblF2: TLabel;
    imgDesfazer: TImage;
    lblF3: TLabel;
    imgSalvar: TImage;
    lblF4: TLabel;
    imgExcluir: TImage;
    lblF5: TLabel;
    imgEditar: TImage;
    lblF6: TLabel;
    imgSair: TImage;
    grpMensagem: TGroupBox;
    lblMsg: TLabel;
    pgcCFOP_CFPS: TPageControl;
    tbsTabela: TTabSheet;
    grdTabela: TDBGrid;
    tbsCadastro: TTabSheet;
    grpCadastro: TGroupBox;
    ActionList1: TActionList;
    WindowClose1: TWindowClose;
    actIncluir: TAction;
    actDesfazer: TAction;
    actSalvar: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    lblCFOP_CFPS: TLabel;
    lblDescricaoCFOP_CFPS: TLabel;
    edtCFOP_CFPS: TDBEdit;
    edtDescricaoCFOP_CFPS: TDBEdit;
    grpCorrelatas: TGroupBox;
    lblCorrelataEstadual: TLabel;
    lblCorrelataInterEstadual: TLabel;
    lblCorrelataEstrangeira: TLabel;
    edtCorrelataEstadual: TDBEdit;
    edtCorrelataInterEstadual: TDBEdit;
    edtCorrelataEstrangeira: TDBEdit;
    rdgOperacaoEstoque: TDBRadioGroup;
    rdgFinalidade: TDBRadioGroup;
    chkAtualizaCustos: TDBCheckBox;
    chkGeraCredDebICMS: TDBCheckBox;
    chkSubtsTrib: TDBCheckBox;
    chkGeraCredDebIPI: TDBCheckBox;
    chkGeraCREDDebPIS_COFINS: TDBCheckBox;
    frpObservacaoNFS: TGroupBox;
    memObservacao: TDBMemo;
    grpNaturezaReceita: TGroupBox;
    lblNaturezaPIS_COFINS: TLabel;
    edtNaturezaPIS_COFINS: TDBEdit;
    pnlNaturezaReceita: TPanel;
    edtDescricaoNaturezaReceita: TDBEdit;
    pgcContribuicoes: TPageControl;
    tbsPIS_COFINS_Entrada: TTabSheet;
    tbsPIS_COFINS_Saida: TTabSheet;
    grpPIS_Entrada: TGroupBox;
    grpCOFINS_Entrada: TGroupBox;
    grpPIS_Saida: TGroupBox;
    grpCOFINS_Saida: TGroupBox;
    lblCST_PIS_Entrada: TLabel;
    lblAliquota_PIS_Entrada: TLabel;
    lblCST_COFINS_Entrada: TLabel;
    lblAliquota_COFINS_Entrada: TLabel;
    lblCST_PIS_Saida: TLabel;
    lblAliquota_PIS_Saida: TLabel;
    lblCST_COFINS_Saida: TLabel;
    lblAliquota_COFINS_Saida: TLabel;
    edtCST_PIS_Entrada: TDBEdit;
    edtCST_COFINS_Entrada: TDBEdit;
    edtAliquotaCST_PIS_Entrada: TDBEdit;
    edtAliquotaCST_COFINS_Entrada: TDBEdit;
    edtCST_PIS_Saida: TDBEdit;
    edtALIQUOTA_PIS_SAIDA: TDBEdit;
    edtCST_COFINS_SAIDA: TDBEdit;
    edtALIQUOTA_COFINS_SAIDA: TDBEdit;
    GroupBox1: TGroupBox;
    edtNaturezaReceita: TDBEdit;
    GroupBox2: TGroupBox;
    edtCodigoCreditoPisCofins: TDBEdit;
    chkCFOPRemessa: TDBCheckBox;
    lblContaContabil: TLabel;
    edtCod_Cta: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure grdTabelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdTabelaDblClick(Sender: TObject);
    procedure grdTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure WindowClose1Execute(Sender: TObject);
    procedure edtConteudoPesquisaEnter(Sender: TObject);
    procedure edtConteudoPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConteudoPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edtConteudoPesquisaExit(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure HabilitaDesabilitaControles(pOpcao:boolean);
    procedure actDesfazerExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblF5Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actExcluirExecute(Sender: TObject);
    procedure edtCFOP_CFPSEnter(Sender: TObject);
    procedure edtCFOP_CFPSExit(Sender: TObject);
    procedure edtCorrelataEstadualExit(Sender: TObject);
    procedure edtCorrelataInterEstadualExit(Sender: TObject);
    procedure edtCorrelataEstrangeiraExit(Sender: TObject);
    procedure edtNaturezaPIS_COFINSExit(Sender: TObject);
    procedure edtCFOP_CFPSKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescricaoCFOP_CFPSExit(Sender: TObject);
    procedure memObservacaoExit(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure rdpOpcoesPesquisaClick(Sender: TObject);
    procedure chkGeraCredDebIPIClick(Sender: TObject);
    procedure chkGeraCREDDebPIS_COFINSClick(Sender: TObject);
    procedure edtALIQUOTA_PIS_SAIDAKeyPress(Sender: TObject; var Key: Char);
    procedure edtCST_PIS_EntradaExit(Sender: TObject);
    procedure edtAliquotaCST_PIS_EntradaExit(Sender: TObject);
    procedure edtCST_COFINS_EntradaExit(Sender: TObject);
    procedure edtAliquotaCST_COFINS_EntradaExit(Sender: TObject);
    procedure edtCST_PIS_SaidaExit(Sender: TObject);
    procedure edtCST_COFINS_SAIDAExit(Sender: TObject);
    procedure edtALIQUOTA_PIS_SAIDAExit(Sender: TObject);
    procedure edtALIQUOTA_COFINS_SAIDAExit(Sender: TObject);
    procedure rdgOperacaoEstoqueClick(Sender: TObject);
    procedure rdgFinalidadeClick(Sender: TObject);
    procedure edtNaturezaReceitaExit(Sender: TObject);
    procedure edtCod_CtaExit(Sender: TObject);
    procedure edtCod_CtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function PesquisaCFOP_CFPS(pCfop:string):boolean;
    function PesquisaTabela_4_3_7(pCodigo:string):boolean;
    function ValidarInfoContribuicoes:boolean;
  public
    { Public declarations }
  end;

var
  frmCFOP_CFPS: TfrmCFOP_CFPS;

implementation

{$R *.dfm}

uses dataDBEXMaster, dataMProvider, dataMSource, dataMSProcedure,
  uConstantes_Padrao, uFuncoes, uFuncoes_BD, modCod_Cta;

procedure TfrmCFOP_CFPS.actDesfazerExecute(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if dmMProvider.cdsCFOP_CFPS.Active then
    if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    begin
      dmMProvider.cdsCFOP_CFPS.Cancel;

      HabilitaDesabilitaControles(False);

      pgcCFOP_CFPS.Pages[1].TabVisible  := false;

      pgcCFOP_CFPS.ActivePageIndex      := 0;

      edtConteudoPesquisa.Clear;
      edtConteudoPesquisa.SetFocus;

    end;


end;

procedure TfrmCFOP_CFPS.actEditarExecute(Sender: TObject);
begin

  if dmMProvider.cdsCFOP_CFPS.Active then
  begin

    if not InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    begin

      HabilitaDesabilitaControles(True);
      edtCFOP_CFPS.SetFocus;

    end;

  end;


end;

procedure TfrmCFOP_CFPS.actExcluirExecute(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  try

    Man_Tab_CFOP(1);

    dmMProvider.cdsCFOP_CFPS.Delete;

  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

    end;

  end;

  HabilitaDesabilitaControles(false);
  edtConteudoPesquisa.Clear;
  edtConteudoPesquisa.SetFocus;

end;

procedure TfrmCFOP_CFPS.actIncluirExecute(Sender: TObject);
begin

  if not InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
  begin

    LimparMSG_ERRO(lblMsg, nil);

    try

      edtConteudoPesquisa.Clear;

      AbrirTabelaCFOP_CFPS(0,'-1');

      pgcCFOP_CFPS.Pages[1].TabVisible  := True;

      HabilitaDesabilitaControles(True);

      pgcCFOP_CFPS.ActivePageIndex      := 1;

      dmMProvider.cdsCFOP_CFPS.Append;

      edtCFOP_CFPS.SetFocus;

    except
      on E: exception do
      begin

         lblMsg.Caption := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
         Application.ProcessMessages;

      end;

    end;

  end;

end;

procedure TfrmCFOP_CFPS.actSalvarExecute(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  try

    ActiveControl := nil;

    if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    begin

      if dmMProvider.cdsCFOP_CFPSNATUREZA_CFOP.Value < 0 then
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', informe a finalidade da CFOP!';

        TocarSomAlerta(ord(SystemHand));

        Application.ProcessMessages;
        exit;

      end
      else
      begin

        Man_Tab_CFOP(0);

        HabilitaDesabilitaControles(false);

      end;

    end;

  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

    end;

  end;

end;

procedure TfrmCFOP_CFPS.chkGeraCredDebIPIClick(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
  begin

    if chkGeraCredDebIPI.Checked then
      dmMProvider.cdsCFOP_CFPSGERA_DEBITO_CREDITO_IPI.Value := 1
    else
      dmMProvider.cdsCFOP_CFPSGERA_DEBITO_CREDITO_IPI.Value := 0;

  end;

end;

procedure TfrmCFOP_CFPS.chkGeraCREDDebPIS_COFINSClick(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
  begin

    if chkGeraCREDDebPIS_COFINS.Checked then
      dmMProvider.cdsCFOP_CFPSGERA_CREDITO_PIS_COFINS.Value := 1
    else
      dmMProvider.cdsCFOP_CFPSGERA_CREDITO_PIS_COFINS.Value := 0;

  end;

end;

procedure TfrmCFOP_CFPS.edtAliquotaCST_COFINS_EntradaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSALIQUOTA_COFINS_SAIDA.Value := dmMProvider.cdsCFOP_CFPSALIQUOTA_COFINS_ENTRADA.Value;

end;

procedure TfrmCFOP_CFPS.edtAliquotaCST_PIS_EntradaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSALIQUOTA_PIS_SAIDA.Value := dmMProvider.cdsCFOP_CFPSALIQUOTA_PIS_ENTRADA.Value;

end;

procedure TfrmCFOP_CFPS.edtALIQUOTA_COFINS_SAIDAExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSALIQUOTA_COFINS_ENTRADA.Value := dmMProvider.cdsCFOP_CFPSALIQUOTA_COFINS_SAIDA.Value;

end;

procedure TfrmCFOP_CFPS.edtALIQUOTA_PIS_SAIDAExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSALIQUOTA_PIS_ENTRADA.Value := dmMProvider.cdsCFOP_CFPSALIQUOTA_PIS_SAIDA.Value;

end;

procedure TfrmCFOP_CFPS.edtALIQUOTA_PIS_SAIDAKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Key = FormatSettings.DecimalSeparator then
    Key := ',';

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end;

end;

procedure TfrmCFOP_CFPS.edtCFOP_CFPSEnter(Sender: TObject);
begin

   MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtCFOP_CFPSExit(Sender: TObject);
begin

   MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtCFOP_CFPSKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end
  else if not (Key in['0'..'9',Chr(8)]) then
    Key:= #0;

end;

procedure TfrmCFOP_CFPS.edtCod_CtaExit(Sender: TObject);
begin

  MudarCorEdit(sender);

  try

    if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    begin

      if length(trim(dmMProvider.cdsCFOP_CFPSCOD_CTA.Value)) > 0 then
      begin

        dmMProvider.cdsSped_R0500.Close;
        dmMProvider.cdsSped_R0500.ProviderName := 'dspSped_R0500';

        dmDBEXMaster.fdqSped_R0500.SQL.Clear;
        dmDBEXMaster.fdqSped_R0500.SQL.Add('select * from sped_r0500');
        dmDBEXMaster.fdqSped_R0500.SQL.Add('where cod_cta = ' + QuotedStr(Trim(dmMProvider.cdsCFOP_CFPSCOD_CTA.Value)));

        dmMProvider.cdsSped_R0500.Open;
        dmMProvider.cdsSped_R0500.ProviderName := '';

        if dmMProvider.cdsSped_R0500.IsEmpty then
        begin

          frmPlanoContaContabeis := TfrmPlanoContaContabeis.Create(self);

          dmMProvider.cdsSped_R0500.Append;
          dmMProvider.cdsSped_R0500COD_CTA.Value := dmMProvider.cdsCFOP_CFPSCOD_CTA.Value;

          if frmPlanoContaContabeis.ShowModal = mrOk then
            Man_Tab_Sped_R0500(0);

        end;

      end;

    end;

  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

    end;
  end;

end;

procedure TfrmCFOP_CFPS.edtCod_CtaKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end;

end;

procedure TfrmCFOP_CFPS.edtConteudoPesquisaEnter(Sender: TObject);
begin

   pgcCFOP_CFPS.Pages[1].TabVisible := false;

   MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtConteudoPesquisaExit(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if Length(Trim(edtConteudoPesquisa.Text)) > 0 then
  begin

    if AbrirTabelaCFOP_CFPS(rdpOpcoesPesquisa.ItemIndex, edtConteudoPesquisa.Text) then
      grdTabela.SetFocus;

    edtConteudoPesquisa.Clear;
    MudarCorEdit(Sender);

  end;

end;

procedure TfrmCFOP_CFPS.edtConteudoPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  iDirecao: Integer;
begin

  // habilita movimenta��o dos campos com as setas acima/abaixo
  iDirecao := -1;

  case Key of

    VK_DOWN:
      iDirecao := 0; { Pr�ximo }
    VK_UP:
      iDirecao := 1; { Anterior }

  end;

  if iDirecao <> -1 then
  begin

    Perform(WM_NEXTDLGCTL, iDirecao, 0);
    Key := 0;

  end;

end;

procedure TfrmCFOP_CFPS.edtConteudoPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Key = #13 then
  begin

    Key := #0;
    PostMessage(Handle, WM_KEYDOWN, VK_TAB, 1);

  end

end;

procedure TfrmCFOP_CFPS.edtCorrelataEstadualExit(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) and  (Length(Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTADUAL.Value)) > 0)then
  begin

    if not PesquisaCFOP_CFPS(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTADUAL.Value)  then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA + ' - ' + Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTADUAL.Value);
      TocarSomAlerta(ord(SystemHand));
      edtCorrelataEstadual.SetFocus;

    end;

  end;

  MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtCorrelataEstrangeiraExit(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) and  (Length(Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTRANGEIRA.Value)) > 0)then
  begin

    if not PesquisaCFOP_CFPS(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTRANGEIRA.Value)  then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA + ' - ' + Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_ESTRANGEIRA.Value);
      TocarSomAlerta(ord(SystemHand));
      edtCorrelataEstrangeira.SetFocus;

    end;

  end;

  MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtCorrelataInterEstadualExit(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) and  (Length(Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_INTERESTADUAL.Value)) > 0)then
  begin

    if not PesquisaCFOP_CFPS(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_INTERESTADUAL.Value)  then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA + ' - ' + Trim(dmMProvider.cdsCFOP_CFPSCFOP_ENTRADA_INTERESTADUAL.Value);
      TocarSomAlerta(ord(SystemHand));
      edtCorrelataInterEstadual.SetFocus;

    end;

  end;

  MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtCST_COFINS_EntradaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSCST_PIS_ENTRADA.Value := dmMProvider.cdsCFOP_CFPSCST_COFINS_ENTRADA.Value;

end;

procedure TfrmCFOP_CFPS.edtCST_COFINS_SAIDAExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSCST_PIS_SAIDA.Value := dmMProvider.cdsCFOP_CFPSCST_COFINS_SAIDA.Value;

end;

procedure TfrmCFOP_CFPS.edtCST_PIS_EntradaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSCST_COFINS_ENTRADA.Value := dmMProvider.cdsCFOP_CFPSCST_PIS_ENTRADA.Value;

end;

procedure TfrmCFOP_CFPS.edtCST_PIS_SaidaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSCST_COFINS_SAIDA.Value := dmMProvider.cdsCFOP_CFPSCST_PIS_SAIDA.Value;

end;

procedure TfrmCFOP_CFPS.edtDescricaoCFOP_CFPSExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSDESCRICAO.Value := RetirarAcentuacao(sender);

end;

procedure TfrmCFOP_CFPS.edtNaturezaPIS_COFINSExit(Sender: TObject);
begin

  LimparMSG_ERRO(lblMsg, nil);

  if (InserindoEditando(dmMProvider.cdsCFOP_CFPS)) and  (Length(Trim(dmMProvider.cdsCFOP_CFPSTABELA_4_3_7.Value)) > 0)then
  begin

    if not PesquisaTabela_4_3_7(dmMProvider.cdsCFOP_CFPSTABELA_4_3_7.Value)  then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA + ' - ' + Trim(dmMProvider.cdsCFOP_CFPSTABELA_4_3_7.Value);
      TocarSomAlerta(ord(SystemHand));
      edtNaturezaPIS_COFINS.SetFocus;

    end;

  end;

  MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.edtNaturezaReceitaExit(Sender: TObject);
begin

  MudarCorEdit(Sender);

end;

procedure TfrmCFOP_CFPS.FormCreate(Sender: TObject);
begin

  DesabilitarBotaoFecharForm(self.Handle);

  Color                             := COR_PADRAO_TELAS;
  Caption                           := ' ' + Application.Title + ' - ' + PREFIXO_VERSAO + RetornarVersao(ParamStr(0),1);

  dmDBEXMaster.sNomeUsuario         := ParamStr(1);
  dmDBEXMaster.sSenha               := paramstr(2);
  dmDBEXMaster.iIdUsuario           := StrToInt(ParamStr(3));
  dmDBEXMaster.iIdFilial            := StrToInt(ParamStr(4));

  if Length(Trim(ParamStr(5))) > 0 then
  begin

    if AbrirTabelaCFOP_CFPS(0, Trim(ParamStr(5))) then
    begin

      pgcCFOP_CFPS.Pages[1].TabVisible  := True;
      pgcCFOP_CFPS.ActivePageIndex      := 1;

    end;

  end
  else
    pgcCFOP_CFPS.Pages[1].TabVisible  := false;

  pgcContribuicoes.ActivePageIndex := 0;

end;

procedure TfrmCFOP_CFPS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = VK_F5 then
    lblF5Click(self);

end;

procedure TfrmCFOP_CFPS.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if (UpperCase(key) = 'S') and (lblMsg.Tag = -1) then
  begin

    Key         := #0;
    lblMsg.Tag  := 0;
    actExcluirExecute(self);

  end
  else   if (UpperCase(key) = 'N') and (lblMsg.Tag = -1) then
  begin

    Key         := #0;
    lblMsg.Tag  := 0;
    LimparMSG_ERRO(lblMsg, nil);

  end;

end;

procedure TfrmCFOP_CFPS.grdTabelaDblClick(Sender: TObject);
begin

  if not dmMProvider.cdsCFOP_CFPS.IsEmpty then
  begin

    pgcCFOP_CFPS.Pages[1].TabVisible  := True;
    pgcCFOP_CFPS.ActivePageIndex      := 1;

  end;

end;

procedure TfrmCFOP_CFPS.grdTabelaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsCFOP_CFPS.IsEmpty then
  begin

    if not odd(dmMProvider.cdsCFOP_CFPS.RecNo) then
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdTabela.Canvas.Font.Color   := clBlack;
      grdTabela.Canvas.Brush.Color  := clWhite;

    end;

    grdTabela.Canvas.FillRect(Rect);
    grdTabela.DefaultDrawDataCell(Rect, Column.Field, State);

  end;


end;

procedure TfrmCFOP_CFPS.grdTabelaKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
    grdTabelaDblClick(Self);

end;

procedure TfrmCFOP_CFPS.HabilitaDesabilitaControles(pOpcao: boolean);
begin

  grpCadastro.Enabled       := pOpcao;
//  pgcContribuicoes.Enabled  := not (chkGeraCREDDebPIS_COFINS.Checked);


end;

procedure TfrmCFOP_CFPS.lblF5Click(Sender: TObject);
begin

  if dmMProvider.cdsCFOP_CFPS.Active then
  begin

    if not (InserindoEditando(dmMProvider.cdsCFOP_CFPS)) then
    begin

      LimparMSG_ERRO(lblMsg, nil);

      lblMsg.Tag      := -1;
      lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_EXCLUSAO;

    end;

  end;

end;

procedure TfrmCFOP_CFPS.memObservacaoExit(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    RetirarAcentuacao(sender);

end;

function TfrmCFOP_CFPS.PesquisaCFOP_CFPS(pCfop: string): boolean;
begin

  dmDBEXMaster.fdqMasterPesquisa.Close;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('select cfop from cfop');
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('where cfop = ' + QuotedStr(pCfop));
  dmDBEXMaster.fdqMasterPesquisa.Open;

  Result := not dmDBEXMaster.fdqMasterPesquisa.IsEmpty;

  dmDBEXMaster.fdqMasterPesquisa.Close;

end;

function TfrmCFOP_CFPS.PesquisaTabela_4_3_7(pCodigo: string): boolean;
begin

  dmDBEXMaster.fdqMasterPesquisa.Close;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('select codigo from TABELA_4_3_7');
  dmDBEXMaster.fdqMasterPesquisa.SQL.Add('where codigo = ' + QuotedStr(pCodigo));
  dmDBEXMaster.fdqMasterPesquisa.Open;

  Result := not dmDBEXMaster.fdqMasterPesquisa.IsEmpty;

  dmDBEXMaster.fdqMasterPesquisa.Close;

end;

procedure TfrmCFOP_CFPS.rdgFinalidadeClick(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSNATUREZA_CFOP.Value := rdgFinalidade.ItemIndex;

end;

procedure TfrmCFOP_CFPS.rdgOperacaoEstoqueClick(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsCFOP_CFPS) then
    dmMProvider.cdsCFOP_CFPSOPERACAO.Value := rdgOperacaoEstoque.ItemIndex;

end;

procedure TfrmCFOP_CFPS.rdpOpcoesPesquisaClick(Sender: TObject);
begin

  edtConteudoPesquisa.Clear;
  edtConteudoPesquisa.SetFocus;

end;

function TfrmCFOP_CFPS.ValidarInfoContribuicoes: boolean;
begin

{  if dmMProvider.cdsCFOP_CFPSGERA_CREDITO_PIS_COFINS.Value = 0 then
    Result := (dmMProvider.cdsCFOP_CFPSCST_PIS_ENTRADA.Value > 0) and (dmMProvider.cdsCFOP_CFPSCST_PIS_SAIDA.Value > 0)
              and (dmMProvider.cdsCFOP_CFPSCST_COFINS_ENTRADA.Value > 0) and (dmMProvider.cdsCFOP_CFPSCST_COFINS_SAIDA.Value > 0)
  else}
    Result := True;

end;

procedure TfrmCFOP_CFPS.WindowClose1Execute(Sender: TObject);
begin

  close;

end;

end.
