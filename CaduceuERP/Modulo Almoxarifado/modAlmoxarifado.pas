unit modAlmoxarifado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ActnList, Vcl.Mask,
  Vcl.DBCtrls, db, Vcl.Imaging.jpeg, IniFiles, System.Actions,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, DBXCommon;

type
  TDBGrid = class(Vcl.DBGrids.TDBGrid)
  protected
    procedure DrawCellBackground(const ARect: TRect; AColor: TColor;
      AState: TGridDrawState; ACol, ARow: Integer); override;
  end;
  TfrmAlmoxarifado = class(TForm)
    pgcAlmoxarifado: TPageControl;
    tbsTabela: TTabSheet;
    tbsCadastro: TTabSheet;
    grdTabela: TDBGrid;
    grpMensagem: TGroupBox;
    lblMsg: TLabel;
    actAlmoxarifado: TActionList;
    actIncluir: TAction;
    actCancelar: TAction;
    actSalvar: TAction;
    actExcluir: TAction;
    actEditar: TAction;
    actSair: TAction;
    grpDadosAlmoxarifado: TGroupBox;
    grpItensAlmoxarifado: TGroupBox;
    grdItensAlmoxarifado: TDBGrid;
    lblControle: TLabel;
    lblEmissao: TLabel;
    lblHora: TLabel;
    edtControle: TDBEdit;
    edtEmissao: TDBEdit;
    edtHora: TDBEdit;
    lblAtendente: TLabel;
    lblRequerente: TLabel;
    edtAtendente: TDBEdit;
    edtrequerente: TDBEdit;
    edtNomeAtendente: TDBEdit;
    edtNomeRequerente: TDBEdit;
    lblCodigo: TLabel;
    lblQuantidade: TLabel;
    lblDescricoa: TLabel;
    grpSaldoAtual: TGroupBox;
    edtAlmoxarifadoAtual: TEdit;
    edtCodigoGTIN: TEdit;
    edtQuantidade: TEdit;
    edtDescricao: TEdit;
    rdgOpcoesPesquisa: TRadioGroup;
    grpConteudoPesquisa: TGroupBox;
    edtConteudoPesquisa: TEdit;
    imgImprimir: TImage;
    imgConfirmar: TImage;
    lblObservacao: TLabel;
    edtDescricaoMotivo: TDBMemo;
    imgStatus: TImage;
    actImprimir: TAction;
    actConfirmarTransacao: TAction;
    imgNovo: TImage;
    imgDesfazer: TImage;
    lblF3: TLabel;
    imgSalvar: TImage;
    imgSair: TImage;
    lblF2: TLabel;
    lblF4: TLabel;
    imgEditar: TImage;
    lblF6: TLabel;
    imgPesqAtendente: TImage;
    imgPesquisaRequerente: TImage;
    imgPeqProdutos: TImage;
    actExcluirItemAmoxarifado: TAction;
    imgExcluir: TImage;
    lblF5: TLabel;
    imgConfirmado: TImage;
    imgAConfirmar: TImage;
    memObservacaoTabela: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure edtAtendenteEnter(Sender: TObject);
    procedure edtAtendenteExit(Sender: TObject);
    procedure edtrequerenteExit(Sender: TObject);
    procedure edtControleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoGTINExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtConteudoPesquisaEnter(Sender: TObject);
    procedure rdgOpcoesPesquisaClick(Sender: TObject);
    procedure edtConteudoPesquisaExit(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure edtEmissaoChange(Sender: TObject);
    procedure edtConteudoPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure actCancelarExecute(Sender: TObject);
    procedure imgDesfazerClick(Sender: TObject);
    procedure imgNovoClick(Sender: TObject);
    procedure imgSalvarClick(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure imgEditarClick(Sender: TObject);
    procedure edtCodigoGTINEnter(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure imgImprimirClick(Sender: TObject);
    procedure actConfirmarTransacaoExecute(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
    procedure edtCodigoGTINKeyPress(Sender: TObject; var Key: Char);
    procedure imgPesqAtendenteClick(Sender: TObject);
    procedure imgPesquisaRequerenteClick(Sender: TObject);
    procedure edtDescricaoMotivoKeyPress(Sender: TObject; var Key: Char);
    procedure grdItensAlmoxarifadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actExcluirItemAmoxarifadoExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure lblF5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdTabelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdTabelaDblClick(Sender: TObject);
    procedure grdTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure tbsCadastroShow(Sender: TObject);
    procedure imgPeqProdutosClick(Sender: TObject);
    procedure grdItensAlmoxarifadoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure edtControleKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ifArqIni :TIniFile;
    procedure HabilitarControles;
    procedure DesabilitarControles;
    procedure LimparMsgErro;
    procedure AbrirTabelas;
    function AbrirTabelaAlmoxarifado(pOpcao:smallint; pConteudo:string):boolean;
    procedure RelacionarItensAlmoxarifado;
    function Man_tab_Item_Almoxarifado(pOpcao:smallint):boolean;
    function Man_Tab_Almoxarifado(pOpcao:smallint):boolean;
  public
    { Public declarations }
  end;

var
  frmAlmoxarifado: TfrmAlmoxarifado;

implementation

{$R *.dfm}

uses dataDBEXMaster, dataMProvider, dataMSource, dataMSProcedure,
  uConstantes_Padrao, uFuncoes, dataMRelatorios, modPesquisaFuncionario,
  modPesquisaProduto;

function TfrmAlmoxarifado.AbrirTabelaAlmoxarifado(pOpcao: smallint;
  pConteudo: string): boolean;
var
  sWhere:string;
begin

  sWhere := dmDBEXMaster.Montar_SQL_Pesquisa_Almoxarifado(pOpcao,pConteudo);

  dmMProvider.cdsAlmoxarifado.Close;
  dmMProvider.cdsAlmoxarifado.ProviderName := 'dspAlmoxarifado';;
  dmDBEXMaster.fdqAlmoxarifado.SQL.Clear;
  dmDBEXMaster.fdqAlmoxarifado.SQL.Add('select * from almoxarifado');
  dmDBEXMaster.fdqAlmoxarifado.SQL.Add(sWhere);
  dmDBEXMaster.fdqAlmoxarifado.SQL.Add('order by almoxarifado');

  try

    dmMProvider.cdsAlmoxarifado.Open;

    dmMProvider.cdsAlmoxarifado.ProviderName := '';

    if (dmMProvider.cdsAlmoxarifado.IsEmpty) and (pConteudo <> '-1') then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA + ' - ' + Trim(edtConteudoPesquisa.Text);
      TocarSomAlerta(ord(SystemHand));

    end;

    Result := not dmMProvider.cdsAlmoxarifado.IsEmpty;

   except
    on E: exception do
      Tratar_Erro_Conexao(E);

  end;

end;

procedure TfrmAlmoxarifado.AbrirTabelas;
begin

  dmMProvider.cdsFuncionarios.Close;
  dmMProvider.cdsFuncionarios.ProviderName := 'dspFuncionarios';

  dmDBEXMaster.fdqFuncionarios.SQL.Clear;
  dmDBEXMaster.fdqFuncionarios.SQL.Add('select * from funcionario');

  dmMProvider.cdsFuncionarios.Open;
  dmMProvider.cdsFuncionarios.ProviderName := '';

end;

procedure TfrmAlmoxarifado.actCancelarExecute(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.State in[dsEdit] then
  begin

    if dmMProvider.cdsItemAlmoxarifado.State in [dsEdit, dsInsert] then
      dmMProvider.cdsItemAlmoxarifado.Cancel;

    dmMProvider.cdsAlmoxarifado.Cancel;

  end
  else if dmMProvider.cdsAlmoxarifado.State in[dsInsert] then
  begin

    dmMProvider.cdsItemAlmoxarifado.Close;
    dmMProvider.cdsAlmoxarifado.Close;

  end;

  DesabilitarControles;

end;

procedure TfrmAlmoxarifado.actConfirmarTransacaoExecute(Sender: TObject);
begin

  LimparMsgErro;

  dmDBEXMaster.fdcMaster.StartTransaction();
  FormatSettings.DecimalSeparator := '.';
  try

    dmMProvider.cdsItemAlmoxarifado.First;

    dmMSProcedure.fdspMaster.StoredProcName := 'EXECUTA_SQL';
    dmMSProcedure.fdspMaster.Prepare;

    if dmMProvider.cdsAlmoxarifadoSTATUS.Value = 0 then
    begin

      while not dmMProvider.cdsItemAlmoxarifado.Eof do
      begin

        dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE PRODUTOFILIAL SET SALDO_ALMOXARIFADO =  SALDO_ALMOXARIFADO - ' + FloatToStr(dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value)
                                                          + ' WHERE PRODUTO = ' + IntToStr(dmMProvider.cdsItemAlmoxarifadoPRODUTO.Value)
                                                          + ' AND FILIAL = ' + IntToStr(dmDBEXMaster.iIdFilial);

        dmMSProcedure.fdspMaster.ExecProc;
        dmMProvider.cdsItemAlmoxarifado.Next;

      end;

      dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE ALMOXARIFADO SET STATUS = 1 WHERE ALMOXARIFADO = ' + (IntToStr(dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value));
      dmMSProcedure.fdspMaster.ExecProc;

      dmMProvider.cdsAlmoxarifado.Edit;
      dmMProvider.cdsAlmoxarifadoSTATUS.Value := 1;
      dmMProvider.cdsAlmoxarifado.Post;

      imgStatus.Picture := imgConfirmado.Picture;

      DesabilitarControles;

      edtConteudoPesquisa.SetFocus;

    end
    else
    begin

      while not dmMProvider.cdsItemAlmoxarifado.Eof do
      begin

        dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE PRODUTOFILIAL SET SALDO_ALMOXARIFADO =  SALDO_ALMOXARIFADO + ' + FloatToStr(dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value)
                                                          + ' WHERE PRODUTO = ' + IntToStr(dmMProvider.cdsItemAlmoxarifadoPRODUTO.Value)
                                                          + ' AND FILIAL = ' + IntToStr(dmDBEXMaster.iIdFilial);

        dmMSProcedure.fdspMaster.ExecProc;
        dmMProvider.cdsItemAlmoxarifado.Next;

      end;

      dmMSProcedure.fdspMaster.Params[0].Value := 'UPDATE ALMOXARIFADO SET STATUS = 0 WHERE ALMOXARIFADO = ' + (IntToStr(dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value));
      dmMSProcedure.fdspMaster.ExecProc;

      dmMProvider.cdsAlmoxarifado.Edit;
      dmMProvider.cdsAlmoxarifadoSTATUS.Value := 0;
      dmMProvider.cdsAlmoxarifado.Post;

      dmDBEXMaster.fdcMaster.Commit;
      dmDBEXMaster.fdcMaster.Close;
      dmDBEXMaster.fdcMaster.Open();


      imgStatus.Picture := imgAConfirmar.Picture;

      DesabilitarControles;

      edtConteudoPesquisa.SetFocus;

      FormatSettings.DecimalSeparator := ',';

    end;
  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario+ ', ' + Tratar_Erro_Conexao(E);
      dmDBEXMaster.fdcMaster.Rollback;

    end;

  end;


end;

procedure TfrmAlmoxarifado.actEditarExecute(Sender: TObject);
begin

  LimparMsgErro;

  if dmMProvider.cdsAlmoxarifado.Active then
  begin

    if dmMProvider.cdsAlmoxarifadoSTATUS.Value = 0 then
    begin

      HabilitarControles;
      pgcAlmoxarifado.ActivePageIndex := 1;
      dmMProvider.cdsAlmoxarifado.Edit;
      edtAtendente.SetFocus;

    end
    else
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_STATUS_NAO_PERMITE;
      Application.ProcessMessages;

    end;

  end;

end;

procedure TfrmAlmoxarifado.actExcluirExecute(Sender: TObject);
begin

  LimparMsgErro;

  if not dmMProvider.cdsItemAlmoxarifado.IsEmpty then
  begin

    dmMProvider.cdsItemAlmoxarifado.First;

    while not dmMProvider.cdsItemAlmoxarifado.Eof do
    begin

      if Man_tab_Item_Almoxarifado(1) then
        dmMProvider.cdsItemAlmoxarifado.Delete
      else
      begin

        break;
        exit;

      end;

    end;

  end;


  if Man_Tab_Almoxarifado(1) then
    dmMProvider.cdsAlmoxarifado.Delete;

end;

procedure TfrmAlmoxarifado.actExcluirItemAmoxarifadoExecute(Sender: TObject);
begin

  LimparMsgErro;

  if Man_tab_Item_Almoxarifado(1) then
    dmMProvider.cdsItemAlmoxarifado.Delete;

end;

procedure TfrmAlmoxarifado.actImprimirExecute(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.Active then
  begin

    if dmMProvider.cdsAlmoxarifadoSTATUS.Value = 1 then
    begin


      dmRelatorios.rvsGenesisAC.SystemPreview.ZoomFactor  := 126.4;
      dmRelatorios.rvdGenesis.DataSet                     := dmMProvider.cdsAlmoxarifado;

      LimparMsgErro;

      if FileExists(ExtractFilePath(Application.ExeName)+'Rav\Relatorios_Diversos.rav') then
      begin

        dmRelatorios.rvpGenesisAC.ProjectFile := ExtractFilePath(Application.ExeName)+'Rav\Relatorios_Diversos.rav';
        dmRelatorios.rvpGenesisAC.SelectReport('rptComprovanteTransfSaldo',true);
        dmRelatorios.rvpGenesisAC.SetParam('pNOME_LOJA',dmMProvider.cdsFilialRAZAOSOCIAL.Value);
        dmRelatorios.rvpGenesisAC.SetParam('pLOGO_MARCA',ExtractFilePath(Application.ExeName) + 'Logomarca\LogoMarca.bmp');
        dmRelatorios.rvpGenesisAC.Execute;
        dmRelatorios.rvpGenesisAC.Close;

      end
      else
        Application.MessageBox(PChar(dmDBEXMaster.sNomeUsuario + ', ' + MSG_ARQ_NEXISTE + #13
          + ExtractFilePath(Application.ExeName)+'Rav\Relatorios_Diversos.rav'), 'Aten��o!',mb_IconWarning + mb_Ok);


    end
    else
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', status atual n�o permite impress�o de comprovante!';
      Application.ProcessMessages;

    end;

  end;

end;

procedure TfrmAlmoxarifado.actIncluirExecute(Sender: TObject);
begin

  LimparMsgErro;

  if not (dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert]) then
  begin

    try

      pgcAlmoxarifado.Pages[1].TabVisible  := True;
      pgcAlmoxarifado.ActivePageIndex      := 1;

      AbrirTabelaAlmoxarifado(0,'-1');

      HabilitarControles;
      dmMProvider.cdsAlmoxarifado.Append;
      RelacionarItensAlmoxarifado;

      edtAtendente.SetFocus;

    except
      on E: exception do
        lblMsg.Caption := dmDBEXMaster.sNomeUsuario+ ', ' + Tratar_Erro_Conexao(E);

    end;

  end;

end;

procedure TfrmAlmoxarifado.actSairExecute(Sender: TObject);
begin

  Close;

end;

procedure TfrmAlmoxarifado.actSalvarExecute(Sender: TObject);
begin

  if InserindoEditando(dmMProvider.cdsAlmoxarifado) then
  begin

    if Man_Tab_Almoxarifado(0) then
    begin

      dmMProvider.cdsAlmoxarifado.Post;
      DesabilitarControles;

    end

  end;

end;

procedure TfrmAlmoxarifado.DesabilitarControles;
begin

  grpDadosAlmoxarifado.Enabled  := false;
  grpItensAlmoxarifado.Enabled  := false;

end;

procedure TfrmAlmoxarifado.edtAtendenteEnter(Sender: TObject);
begin

  MudarCorEdit(sender);

end;

procedure TfrmAlmoxarifado.edtAtendenteExit(Sender: TObject);
var
  sSenha:string;
begin

  MudarCorEdit(sender);

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    if dmMProvider.cdsAlmoxarifadoFUNCIONARIO.Value > 0 then
    begin

      LimparMsgErro;

      if not dmMProvider.cdsFuncionarios.Locate('FUNCIONARIO', dmMProvider.cdsAlmoxarifadoFUNCIONARIO.Value, []) then
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
        Application.ProcessMessages;
        edtAtendente.SetFocus;

      end;

    end
    else
//      edtAtendente.SetFocus;

  end;

end;

procedure TfrmAlmoxarifado.edtCodigoGTINEnter(Sender: TObject);
begin

  MudarCorEdit(sender);

end;

procedure TfrmAlmoxarifado.edtCodigoGTINExit(Sender: TObject);
begin

  MudarCorEdit(sender);

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    if (Length(Trim(edtCodigoGTIN.Text)) > 0 ) and (Length(Trim(edtCodigoGTIN.Text)) <= 6) then
    begin

      dmMProvider.cdsPesqProdutos.Close;
      dmMProvider.cdsPesqProdutos.ProviderName  := 'dspPesqProdutos';

      dmDBEXMaster.fdqPesqProdutos.SQL.Clear;
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('SELECT PRO.*, PF.* ,UND.PERMITE_VENDA_FRACIONADA AS FRACAO FROM PRODUTO PRO');
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('JOIN PRODUTOFILIAL PF');
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('ON(PF.PRODUTO = PRO.PRODUTO)');
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('JOIN UNIDADE_MEDIDA UND');
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('ON(UND.UNIDADE = PRO.UNIDADE)');
      dmDBEXMaster.fdqPesqProdutos.SQL.Add('where pro.produto =  '+ Trim(edtCodigoGTIN.Text));
      dmDBEXMaster.fdqPesqProdutos.SQL.Add(' AND PF.FILIAL = ' + IntToStr(dmDBEXMaster.iIdFilial));
      dmDBEXMaster.fdqMasterPesquisa.SQL.Add('order by pro.descricao');

      dmMProvider.cdsPesqProdutos.Open;
      dmMProvider.cdsPesqProdutos.ProviderName := '';

      if dmMProvider.cdsPesqProdutos.IsEmpty then
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', ' + MSG_PESQUISA;
        Application.ProcessMessages;
        edtCodigoGTIN.SetFocus;
        exit;

      end
      else
      begin

        LimparMsgErro;

        if dmMProvider.cdsItemAlmoxarifado.Locate('produto;almoxarifado',VarArrayOf([edtCodigoGTIN.Text,dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value]),[]) then
        begin

          dmMProvider.cdsItemAlmoxarifado.Edit;

          edtQuantidade.Text        := FormatFloat('#,##0.000',(dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value));
          edtDescricao.Text         := dmMProvider.cdsItemAlmoxarifadoDESCRICAO.Value;
          edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value));

        end
        else
        begin

          edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value));
          edtDescricao.Text         := dmMProvider.cdsPesqProdutosDESCRICAO.Value;
          dmMProvider.cdsItemAlmoxarifado.Append;
          dmMProvider.cdsItemAlmoxarifadoPRODUTO.Value := dmMProvider.cdsPesqProdutosPRODUTO.Value;

        end;

      end;

    end
    else if (Length(Trim(edtCodigoGTIN.Text)) > 0) and (Length(Trim(edtCodigoGTIN.Text)) > 6) then
    begin

      LimparMsgErro;

      dmDBEXMaster.fdqBarras.Close;
      dmDBEXMaster.fdqBarras.SQL.Clear;
      dmDBEXMaster.fdqBarras.sql.Add('SELECT * FROM BARRAS');
      dmDBEXMaster.fdqBarras.sql.Add('WHERE BARRAS = ' + edtCodigoGTIN.Text);
      dmDBEXMaster.fdqBarras.Open;

      if dmDBEXMaster.fdqBarras.IsEmpty then
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
        Application.ProcessMessages;
        edtCodigoGTIN.SetFocus;
        dmDBEXMaster.fdqBarras.Close;
        exit;

      end
      else
      begin

        dmMProvider.cdsPesqProdutos.Close;
        dmMProvider.cdsPesqProdutos.ProviderName  := 'dspPesqProdutos';

        dmDBEXMaster.fdqPesqProdutos.SQL.Clear;
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('SELECT PRO.*, PF.* ,UND.PERMITE_VENDA_FRACIONADA AS FRACAO FROM PRODUTO PRO');
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('JOIN PRODUTOFILIAL PF');
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('ON(PF.PRODUTO = PRO.PRODUTO)');
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('JOIN UNIDADE_MEDIDA UND');
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('ON(UND.UNIDADE = PRO.UNIDADE)');
        dmDBEXMaster.fdqPesqProdutos.SQL.Add('where pro.produto =  '+ Trim(IntToStr(dmDBEXMaster.fdqBarras.FieldByName('PRODUTO').Value)));
        dmDBEXMaster.fdqPesqProdutos.SQL.Add(' AND PF.FILIAL = ' + IntToStr(dmDBEXMaster.iIdFilial));
        dmDBEXMaster.fdqMasterPesquisa.SQL.Add('order by pro.descricao');

        dmMProvider.cdsPesqProdutos.Open;
        dmMProvider.cdsPesqProdutos.ProviderName := '';

        if dmMProvider.cdsPesqProdutos.IsEmpty then
        begin

          lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', inconsist�ncia do c�digo de barras. Contacte suporte!';
          Application.ProcessMessages;
          edtCodigoGTIN.SetFocus;
          dmDBEXMaster.fdqBarras.Close;
          exit;

        end
        else
        begin

          LimparMsgErro;

          edtCodigoGTIN.Text    := IntToStr(dmMProvider.cdsPesqProdutosPRODUTO.Value);

          if dmMProvider.cdsItemAlmoxarifado.Locate('produto;almoxarifado',VarArrayOf([dmMProvider.cdsPesqProdutosPRODUTO.Value,dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value]),[]) then
          begin

            dmMProvider.cdsItemAlmoxarifado.Edit;

            edtQuantidade.Text        := FormatFloat('#,##0.000',(dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value));
            edtDescricao.Text         := dmMProvider.cdsItemAlmoxarifadoDESCRICAO.Value;
            edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value));

          end
          else
          begin

            edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value));
            edtDescricao.Text         := dmMProvider.cdsPesqProdutosDESCRICAO.Value;

            dmMProvider.cdsItemAlmoxarifado.Append;


          end;

        end;

      end;

    end;

  end;

end;

procedure TfrmAlmoxarifado.edtCodigoGTINKeyPress(Sender: TObject;
  var Key: Char);
begin

  if key = #13 then
  begin

    key := #0;
    PostMessage(handle, WM_KEYDOWN, VK_TAB, 1);

  end
  else
  begin

    if (key <> #8) and (key <> '-') then
      if not (Key in ['0'..'9']) then
        abort;

  end;

end;

procedure TfrmAlmoxarifado.edtConteudoPesquisaEnter(Sender: TObject);
begin

  MudarCorEdit(sender);

end;

procedure TfrmAlmoxarifado.edtConteudoPesquisaExit(Sender: TObject);
var
  iProduto:integer;
begin

  MudarCorEdit(sender);

  LimparMsgErro;

  if Length(Trim(edtConteudoPesquisa.Text)) > 0 then
  begin

    dmMProvider.cdsAlmoxarifado.Close;
    dmMProvider.cdsItemAlmoxarifado.Close;

    lblMsg.Caption := 'Aguarde.....';
    Application.ProcessMessages;

    pgcAlmoxarifado.ActivePageIndex := 0;

    case rdgOpcoesPesquisa.ItemIndex of
      0:begin

          //verifica se ofoi digitado codigo de barras
          if Length(Trim(edtConteudoPesquisa.Text)) > 6 then
          begin

            dmDBEXMaster.fdqBarras.Close;
            dmDBEXMaster.fdqBarras.SQL.Clear;
            dmDBEXMaster.fdqBarras.SQL.Add('SELECT PRODUTO FROM BARRAS');
            dmDBEXMaster.fdqBarras.SQL.Add('WHERE BARRAS = ' + QuotedStr(edtConteudoPesquisa.Text));
            dmDBEXMaster.fdqBarras.Open;

            if dmDBEXMaster.fdqBarras.IsEmpty then
            begin

              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
              Application.ProcessMessages;
              dmDBEXMaster.fdqBarras.Close;
              edtConteudoPesquisa.SetFocus;
              exit;

            end
            else
            begin

              dmDBEXMaster.fdqProdutos.Close;
              dmDBEXMaster.fdqProdutos.SQL.Clear;
              dmDBEXMaster.fdqProdutos.SQL.Add('SELECT * FROM PRODUTO');
              dmDBEXMaster.fdqProdutos.SQL.Add('WHERE PRODUTO = ' + IntToStr(dmDBEXMaster.fdqBarras.FieldByName('PRODUTO').Value));
              dmDBEXMaster.fdqProdutos.Open;

              if dmDBEXMaster.fdqProdutos.IsEmpty then
              begin

                lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', c�digo de barras �rf�o. Entre em contato com o suporte!';
                Application.ProcessMessages;
                dmDBEXMaster.fdqProdutos.Close;
                dmDBEXMaster.fdqBarras.Close;
                edtConteudoPesquisa.SetFocus;
                exit;

              end
              else
                iProduto := dmDBEXMaster.fdqBarras.FieldByName('PRODUTO').Value;

            end;

          end
          else
          begin

            dmDBEXMaster.fdqProdutos.Close;
            dmDBEXMaster.fdqProdutos.SQL.Clear;
            dmDBEXMaster.fdqProdutos.SQL.Add('SELECT * FROM PRODUTO');
            dmDBEXMaster.fdqProdutos.SQL.Add('WHERE PRODUTO = ' + Trim(edtConteudoPesquisa.Text));
            dmDBEXMaster.fdqProdutos.Open;

            if dmDBEXMaster.fdqProdutos.IsEmpty then
            begin

              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
              Application.ProcessMessages;
              dmDBEXMaster.fdqProdutos.Close;
              edtConteudoPesquisa.SetFocus;
              exit;

            end
            else
              iProduto := dmDBEXMaster.fdqProdutos.FieldByName('PRODUTO').Value;

          end;

          edtConteudoPesquisa.Clear;

          dmMProvider.cdsItemAlmoxarifado.Close;
          dmMProvider.cdsItemAlmoxarifado.ProviderName := 'dspItemAlmoxarifado';

          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Clear;
          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('select italm.*, pro.descricao from item_almoxarifado italm');
          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('join produto pro');
          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('on(pro.produto = italm.produto)');
          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('where italm.produto = ' + IntToStr(iProduto));
          dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('order by italm.item_almoxarifado');

          dmMProvider.cdsItemAlmoxarifado.Open;
          dmMProvider.cdsItemAlmoxarifado.ProviderName := '';

          if dmMProvider.cdsItemAlmoxarifado.IsEmpty then
          begin

              lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', n�o existe(m) transferencia(s) com este produto!';
              Application.ProcessMessages;
              edtConteudoPesquisa.SetFocus;
              exit;

          end
          else
          begin

            dmMProvider.cdsAlmoxarifado.Close;
            dmMProvider.cdsAlmoxarifado.ProviderName := 'dspAlmoxarifado';

            dmDBEXMaster.fdqAlmoxarifado.SQL.Clear;
            dmDBEXMaster.fdqAlmoxarifado.SQL.Add('SELECT * FROM ALMOXARIFADO');
            dmDBEXMaster.fdqAlmoxarifado.SQL.Add('WHERE ALMOXARIFADO IN (SELECT ALMOXARIFADO FROM ITEM_ALMOXARIFADO WHERE PRODUTO = ' + IntToStr(iProduto)+')');

            dmMProvider.cdsAlmoxarifado.Open;
            dmMProvider.cdsAlmoxarifado.ProviderName := '';

          end;

          LimparMsgErro;
          grdTabela.SetFocus;

        end;

      1:begin

          dmMProvider.cdsAlmoxarifado.Close;
          dmMProvider.cdsAlmoxarifado.ProviderName := 'dspAlmoxarifado';

          dmDBEXMaster.fdqAlmoxarifado.SQL.Clear;
          dmDBEXMaster.fdqAlmoxarifado.SQL.Add('SELECT * FROM ALMOXARIFADO');
          dmDBEXMaster.fdqAlmoxarifado.SQL.Add('WHERE ALMOXARIFADO = ' + edtConteudoPesquisa.Text);

          dmMProvider.cdsAlmoxarifado.Open;
          dmMProvider.cdsAlmoxarifado.ProviderName := '';

          if dmMProvider.cdsAlmoxarifado.IsEmpty then
          begin

            lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
            Application.ProcessMessages;
            edtConteudoPesquisa.SetFocus;

          end
          else
          begin

            grdTabela.SetFocus;

            edtConteudoPesquisa.Clear;

            LimparMsgErro;

          end;

        end;

    end;

    case dmMProvider.cdsAlmoxarifadoSTATUS.Value of
      0:imgStatus.Picture := imgAConfirmar.Picture;
      1:imgStatus.Picture := imgConfirmado.Picture;
    end;

    imgStatus.Visible := not (dmMProvider.cdsAlmoxarifado.IsEmpty);

  end;

end;

procedure TfrmAlmoxarifado.edtConteudoPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin

  if key = #13 then
  begin

    key := #0;
    PostMessage(handle, WM_KEYDOWN, VK_TAB, 1);

    if rdgOpcoesPesquisa.ItemIndex = 0 then
    begin

      if Length(Trim(edtConteudoPesquisa.Text)) <= 0 then
      begin

        frmPesquisaProduto      := TfrmPesquisaProduto.Create(self);
        frmPesquisaProduto.Tag  := 1;
        if frmPesquisaProduto.ShowModal = mrOK then
        begin

          edtConteudoPesquisa.Text := IntToStr(dmMProvider.cdsPesqProdutosPRODUTO.Value);
          edtConteudoPesquisaExit(self);

        end;

        FreeAndNil(frmPesquisaProduto);


      end;

    end;

  end;

end;

procedure TfrmAlmoxarifado.edtControleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  iDirecao: Integer;
begin
  //habilita movimenta��o dos campos com as setas acima/abaixo
  iDirecao := -1;
  case Key of
    VK_DOWN: iDirecao := 0; {Pr�ximo}
    VK_UP: iDirecao := 1;   {Anterior}
  end;
  if iDirecao <> -1 then
  begin
    Perform(WM_NEXTDLGCTL, iDirecao, 0);
    Key := 0;
  end;

end;

procedure TfrmAlmoxarifado.edtControleKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
  begin

    key := #0;
    PostMessage(handle, WM_KEYDOWN, VK_TAB, 1);

  end;

end;

procedure TfrmAlmoxarifado.edtDescricaoMotivoKeyPress(Sender: TObject;
  var Key: Char);
begin

  Key := UpCase(Key);

end;

procedure TfrmAlmoxarifado.edtEmissaoChange(Sender: TObject);
begin

  case dmMProvider.cdsAlmoxarifadoSTATUS.Value of
    0:imgStatus.Picture := imgAConfirmar.Picture;
    1:imgStatus.Picture := imgConfirmado.Picture;
  end;

  imgStatus.Visible := (dmMProvider.cdsAlmoxarifado.IsEmpty) or (dmMProvider.cdsAlmoxarifado.State in [dsInsert]);

end;

procedure TfrmAlmoxarifado.edtQuantidadeExit(Sender: TObject);
var
  iItem:integer;
begin

  MudarCorEdit(sender);

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    if StrToFloat(RetirarPonto(edtQuantidade.Text)) > dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value then
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario + ', saldo insuficiente para efetivar esta opera��o!';
      Application.ProcessMessages;
      edtCodigoGTIN.SetFocus;
      exit;

    end
    else
    begin

      if dmMProvider.cdsItemAlmoxarifadoITEM_ALMOXARIFADO.Value < 0 then
        imgSalvarClick(self);
      HabilitarControles;

      dmMProvider.cdsAlmoxarifado.Edit;

      if dmMProvider.cdsItemAlmoxarifado.State in [dsEdit, dsInsert] then
        dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value :=  StrToFloat(RetirarPonto(edtQuantidade.Text));

      Man_tab_Item_Almoxarifado(0);

      edtCodigoGTIN.Clear;
      edtCodigoGTIN.SetFocus;
      edtQuantidade.Text          := '1,000';
      edtDescricao.Clear;
      edtAlmoxarifadoAtual.Text   := '0,000';

      RelacionarItensAlmoxarifado;

    end;

  end;

end;

procedure TfrmAlmoxarifado.edtQuantidadeKeyPress(Sender: TObject;
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

procedure TfrmAlmoxarifado.edtrequerenteExit(Sender: TObject);
begin

  MudarCorEdit(sender);
  LimparMsgErro;

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    if dmMProvider.cdsAlmoxarifadoREQUERENTE.Value > 0 then
    begin

      if not dmMProvider.cdsFuncionarios.Locate('FUNCIONARIO', dmMProvider.cdsAlmoxarifadoREQUERENTE.Value, []) then
      begin

        lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_PESQUISA;
        Application.ProcessMessages;
        edtrequerente.SetFocus;

      end;

    end
    else
      edtrequerente.SetFocus;

  end;

end;

procedure TfrmAlmoxarifado.FormCreate(Sender: TObject);
var
  i:integer;
begin


  DesabilitarBotaoFecharForm(self.Handle);

  Color                           := COR_PADRAO_TELAS;
  Caption                         := ' ' + Application.Title + ' - ' + RetornarVersao(ParamStr(0),1) + 'xe';

  dmDBEXMaster.sNomeUsuario       := ParamStr(1);
  dmDBEXMaster.sSenha             := paramstr(2);
  dmDBEXMaster.iIdUsuario         := StrToInt(ParamStr(3));
  dmDBEXMaster.iIdFilial          := StrToInt(ParamStr(4));

  pgcAlmoxarifado.Pages[1].TabVisible := False;

  for i := 0 to grdTabela.Columns.Count - 1 do
    grdTabela.Columns[i].Title.Color := COR_TITULO_GRADE;

  for i := 0 to grdItensAlmoxarifado.Columns.Count - 1 do
    grdItensAlmoxarifado.Columns[i].Title.Color := COR_TITULO_GRADE;

  pgcAlmoxarifado.ActivePageIndex := 0;

end;

procedure TfrmAlmoxarifado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if key = VK_F5 then
    lblF5Click(self);

end;

procedure TfrmAlmoxarifado.FormKeyPress(Sender: TObject; var Key: Char);
begin

  try

    if (UpperCase(Key) = 'S') and (lblMsg.Tag = ord(ExcluirItemAlmoxarifado))
    then
    begin

      Key         := #0;
      lblMsg.Tag  := ord(nulo);
      actExcluirItemAmoxarifadoExecute(self);

    end
    else if (UpperCase(key) = 'S') and (lblMsg.Tag = -1) then
    begin

      Key         := #0;
      lblMsg.Tag  := 0;
      actExcluirExecute(self);

    end
    else if (UpperCase(key) = 'S') and (lblMsg.Tag = ord(ConfirmarLancAlmoxarifado)) then
    begin

      Key         := #0;
      lblMsg.Tag  := 0;
      actConfirmarTransacaoExecute(self);

    end
    else if (UpperCase(Key) = 'N') AND (lblMsg.Tag <> ord(nulo)) then
    begin

      Key         := #0;
      lblMsg.Tag  := ord(nulo);
      LimparMsgErro;

    end;
  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  Tratar_Erro_Conexao(E);
      Application.ProcessMessages;

    end;

  end;

end;

procedure TfrmAlmoxarifado.grdItensAlmoxarifadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsItemAlmoxarifado.IsEmpty then
  begin

    if not odd(dmMProvider.cdsItemAlmoxarifado.RecNo) then
    begin

      grdItensAlmoxarifado.Canvas.Font.Color   := clBlack;
      grdItensAlmoxarifado.Canvas.Brush.Color  := COR_ZEBRA_GRADE;

    end
    else
    begin

      grdItensAlmoxarifado.Canvas.Font.Color   := clBlack;
      grdItensAlmoxarifado.Canvas.Brush.Color  := clWhite;

    end;

    grdItensAlmoxarifado.Canvas.FillRect(Rect);
    grdItensAlmoxarifado.DefaultDrawDataCell(Rect, Column.Field, State);

  end;

end;

procedure TfrmAlmoxarifado.grdItensAlmoxarifadoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  case Key of

    VK_DELETE:
      begin

        LimparMsgErro;

        if dmMProvider.cdsItemAlmoxarifado.Active then
        begin

          if not dmMProvider.cdsItemAlmoxarifado.IsEmpty then
          begin

            lblMsg.Tag      := ord(ExcluirItemAlmoxarifado);
            lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_EXCLUSAO;

          end;

        end;

      end;

  end;

end;

procedure TfrmAlmoxarifado.grdTabelaDblClick(Sender: TObject);
begin

  if not dmMProvider.cdsAlmoxarifado.IsEmpty then
  begin

    pgcAlmoxarifado.Pages[1].TabVisible := False;
    pgcAlmoxarifado.ActivePageIndex     := 1;

  end;

end;

procedure TfrmAlmoxarifado.grdTabelaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not dmMProvider.cdsAlmoxarifado.IsEmpty then
  begin

    if not odd(dmMProvider.cdsAlmoxarifado.RecNo) then
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

procedure TfrmAlmoxarifado.grdTabelaKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
    grdTabelaDblClick(self);

end;

procedure TfrmAlmoxarifado.HabilitarControles;
begin

  grpDadosAlmoxarifado.Enabled := true;
  grpItensAlmoxarifado.Enabled := true;

end;

procedure TfrmAlmoxarifado.imgPeqProdutosClick(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    frmPesquisaProduto      := TfrmPesquisaProduto.Create(self);
    frmPesquisaProduto.Tag  := 1;

    if frmPesquisaProduto.ShowModal = mrOK then
    begin

      if dmMProvider.cdsItemAlmoxarifado.Locate('produto;almoxarifado',VarArrayOf([dmMProvider.cdsPesqProdutosPRODUTO.Value,dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value]),[]) then
      begin

        dmMProvider.cdsItemAlmoxarifado.Edit;

        edtQuantidade.Text        := FormatFloat('#,##0.000',(dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value));
        edtDescricao.Text         := dmMProvider.cdsItemAlmoxarifadoDESCRICAO.Value;
        edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmDBEXMaster.fdqProdutos.FieldByName('SALDO_ALMOXARIFADO').AsCurrency));
        edtQuantidade.SetFocus;

      end
      else
      begin

        edtCodigoGTIN.Text        := IntToStr(dmMProvider.cdsPesqProdutosPRODUTO.Value);
        edtDescricao.Text         := dmMProvider.cdsPesqProdutosDESCRICAO.Value;
        edtAlmoxarifadoAtual.Text := FormatFloat('#,##0.000',(dmMProvider.cdsPesqProdutosSALDO_ALMOXARIFADO.Value));
        edtDescricao.Text         := dmMProvider.cdsPesqProdutosDESCRICAO.Value;

        dmMProvider.cdsItemAlmoxarifado.Append;
        dmMProvider.cdsItemAlmoxarifadoPRODUTO.Value  := dmMProvider.cdsPesqProdutosPRODUTO.Value;

        edtQuantidade.SetFocus;

      end;

    end;

    FreeAndNil(frmPesquisaProduto);

  end;

end;

procedure TfrmAlmoxarifado.imgConfirmarClick(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.Active then
  begin

    if not InserindoEditando(dmMProvider.cdsAlmoxarifado) then
    begin

      LimparMsgErro;
      lblMsg.Tag      := ord(ConfirmarLancAlmoxarifado) ;

      case dmMProvider.cdsAlmoxarifadoSTATUS.Value of
        0:lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_LANCAMENTO;
        1:lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_ESTORNO;
      end;

      Application.ProcessMessages;

    end;

  end;

end;

procedure TfrmAlmoxarifado.imgDesfazerClick(Sender: TObject);
begin

  actCancelarExecute(self);

end;

procedure TfrmAlmoxarifado.imgEditarClick(Sender: TObject);
begin

  actEditarExecute(self);

end;

procedure TfrmAlmoxarifado.imgImprimirClick(Sender: TObject);
begin

//  actImprimirExecute(Self);

end;

procedure TfrmAlmoxarifado.imgNovoClick(Sender: TObject);
begin

  actIncluirExecute(self);;

end;

procedure TfrmAlmoxarifado.imgPesqAtendenteClick(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    frmPesquisaFuncionario      := TfrmPesquisaFuncionario.Create(self);
    frmPesquisaFuncionario.Tag  := 1;

    if frmPesquisaFuncionario.ShowModal = mrOK then
    begin

      dmMProvider.cdsAlmoxarifadoFUNCIONARIO.Value := dmMProvider.cdsFuncionariosFUNCIONARIO.Value;
      edtrequerente.SetFocus;

    end;

    FreeAndNil(frmPesquisaFuncionario);

  end;

end;

procedure TfrmAlmoxarifado.imgPesquisaRequerenteClick(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert] then
  begin

    frmPesquisaFuncionario      := TfrmPesquisaFuncionario.Create(self);
    frmPesquisaFuncionario.Tag  := 1;

    if frmPesquisaFuncionario.ShowModal = mrOK then
    begin

      dmMProvider.cdsAlmoxarifadoREQUERENTE.Value := dmMProvider.cdsFuncionariosFUNCIONARIO.Value;
      edtrequerente.SetFocus;

    end;

    FreeAndNil(frmPesquisaFuncionario);

  end;

end;

procedure TfrmAlmoxarifado.imgSalvarClick(Sender: TObject);
begin

  actSalvarExecute(self);;

end;

procedure TfrmAlmoxarifado.lblF5Click(Sender: TObject);
begin

  if dmMProvider.cdsAlmoxarifado.Active then
  begin

    if not (dmMProvider.cdsAlmoxarifado.State in [dsEdit, dsInsert]) then
    begin

      LimparMsgErro;

      if dmMProvider.cdsAlmoxarifadoSTATUS.Value = 0 then
      begin

        lblMsg.Tag      := -1;
        lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_CONFIRMA_EXCLUSAO;

      end
      else
      begin

        lblMsg.Caption  := dmDBEXMaster.sNomeUsuario + MSG_STATUS_NAO_PERMITE;
        Application.ProcessMessages;

      end;

    end;

  end;

end;

procedure TfrmAlmoxarifado.LimparMsgErro;
begin

  lblMsg.Caption := '';
  Application.ProcessMessages;

end;

function TfrmAlmoxarifado.Man_Tab_Almoxarifado(pOpcao: smallint): boolean;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    dmMSProcedure.fdspAlmoxarifado.Params[0].Value  := pOpcao;
    dmMSProcedure.fdspAlmoxarifado.Params[1].Value  := dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[2].Value  := dmMProvider.cdsAlmoxarifadoEMISSAO.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[3].Value  := dmMProvider.cdsAlmoxarifadoHORA.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[4].Value  := dmMProvider.cdsAlmoxarifadoFUNCIONARIO.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[5].Value  := dmMProvider.cdsAlmoxarifadoREQUERENTE.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[6].Value  := dmMProvider.cdsAlmoxarifadoSTATUS.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[7].Value  := dmMProvider.cdsAlmoxarifadoOBSERVACAO.Value;
    dmMSProcedure.fdspAlmoxarifado.Params[8].Value  := dmDBEXMaster.sNomeUsuario;
    dmMSProcedure.fdspAlmoxarifado.ExecProc;

    if not InserindoEditando(dmMProvider.cdsAlmoxarifado) then
      dmMProvider.cdsAlmoxarifado.Edit;


    if dmMSProcedure.fdspAlmoxarifado.Params[9].Value > 0 then
      dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value := dmMSProcedure.fdspAlmoxarifado.Params[9].Value;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

    Result := true;

  except
    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario+ ', ' + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;
      Result := false;

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

    end;

  end;

end;

function TfrmAlmoxarifado.Man_tab_Item_Almoxarifado(pOpcao:smallint):boolean;
begin

  try

    if not dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.StartTransaction;

    dmMSProcedure.fdspItemAlmoxarifado.Params[0].Value  := pOpcao;
    dmMSProcedure.fdspItemAlmoxarifado.Params[1].Value  := dmMProvider.cdsItemAlmoxarifadoITEM_ALMOXARIFADO.Value;
    dmMSProcedure.fdspItemAlmoxarifado.Params[2].Value  := dmMProvider.cdsItemAlmoxarifadoPRODUTO.Value;
    dmMSProcedure.fdspItemAlmoxarifado.Params[3].Value  := dmMProvider.cdsItemAlmoxarifadoQUANTIDADE.Value;
    dmMSProcedure.fdspItemAlmoxarifado.Params[4].Value  := dmDBEXMaster.sNomeUsuario;
    dmMSProcedure.fdspItemAlmoxarifado.Params[5].Value  := dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value;
    dmMSProcedure.fdspItemAlmoxarifado.ExecProc;

    if dmDBEXMaster.fdtMaster.Active then
      dmDBEXMaster.fdtMaster.Commit;

    Result := true;

  except

    on E: exception do
    begin

      lblMsg.Caption := dmDBEXMaster.sNomeUsuario+ ', ' + Tratar_Erro_Conexao(E);
      Application.ProcessMessages;
      Result := False;

      if dmDBEXMaster.fdtMaster.Active then
        dmDBEXMaster.fdtMaster.Rollback;

    end;

  end;

end;

procedure TfrmAlmoxarifado.rdgOpcoesPesquisaClick(Sender: TObject);
begin

  edtConteudoPesquisa.Clear;
  edtConteudoPesquisa.SetFocus;

end;

procedure TfrmAlmoxarifado.RelacionarItensAlmoxarifado;
begin

  dmMProvider.cdsItemAlmoxarifado.Close;
  dmMProvider.cdsItemAlmoxarifado.ProviderName := 'dspItemAlmoxarifado';

  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Clear;
  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('select italm.*, pro.descricao from item_almoxarifado italm');
  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('join produto pro');
  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('on(pro.produto = italm.produto)');
  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('where italm.almoxarifado = ' + IntToStr(dmMProvider.cdsAlmoxarifadoALMOXARIFADO.Value));
  dmDBEXMaster.fdqItemAlmoxarifado.SQL.Add('order by italm.item_almoxarifado');

  dmMProvider.cdsItemAlmoxarifado.Open;
  dmMProvider.cdsItemAlmoxarifado.ProviderName := '';

end;

procedure TfrmAlmoxarifado.tbsCadastroShow(Sender: TObject);
begin

  RelacionarItensAlmoxarifado;

  case dmMProvider.cdsAlmoxarifadoSTATUS.Value of
    0:imgStatus.Picture := imgAConfirmar.Picture;
    1:imgStatus.Picture := imgConfirmado.Picture;
  end;

end;

{ TDBGrid }

procedure TDBGrid.DrawCellBackground(const ARect: TRect; AColor: TColor;
  AState: TGridDrawState; ACol, ARow: Integer);
begin
  inherited;

  if ACol < 0 then
    inherited DrawCellBackground(ARect, AColor, AState, ACol, ARow)
  else
    inherited DrawCellBackground(ARect, Columns[ACol].Title.Color, AState,
      ACol, ARow)

end;

end.