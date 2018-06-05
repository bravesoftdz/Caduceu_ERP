unit modSpedFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, DateUtils,
  ACBrEFDBlocos, Db,  math;

procedure Gerar_SPED_Fiscal(sArquivoSPED_Fiscal: string);
function Retornar_versao_SPEDF(pDataI, pDataF: TDateTime)  : ACBrEFDBlocos.TACBrVersaoLeiaute;
procedure Gravar_Bloco_0;
procedure Gravar_Bloco_C100;
procedure Gravar_Bloco_C101;
procedure Gravar_Bloco_C113_114;
procedure Gravar_RegistroC400;
procedure Gravar_Registro0150(pCodigo_Participante:string);
procedure Gravar_Registro0190(pUnidade:string);
procedure Gravar_Registro0200(pOpcao:smallint;pCodigoItem, pUnidade:string);
procedure Gravar_Registro0400(pCfop:string);
procedure Gravar_Bloco_D;
procedure Gravar_Bloco_E;
procedure Gravar_Bloco_G;
procedure Gravar_Bloco_H;
procedure Gravar_Bloco_1;



var
  cTotalICMS_DEB, cTotalICMS_CRED, cVL_OUT_CRED_ST, cVL_TOT_CREDITOS, cVL_TOT_DEBITOS, cTotalICMS_CRED_H20: currency;
  iHoraFinal: TDateTime;
  iCodigo0450, iTotalRegistros, iRegistroAtual:integer;


implementation

uses dataDBEXMaster, dataMProvider, uConstantes_Padrao, uFuncoes, modIntegracao,
  dataSintegraSped, ACBrEFDBloco_0, ACBrEFDBloco_0_Class, ACBrEFDBloco_0_Events;


procedure Gerar_SPED_Fiscal(sArquivoSPED_Fiscal: string);
var
  i, iTotaRegistros,  iTotalReg0_10, iTotalReg0_1 : integer;
begin

  iCodigo0450     := 0 ;
  cTotalICMS_DEB  := 0;

  frmIntegracao.pnlProgresso.Visible        := True;
  frmIntegracao.advMarquueProcesso.Animate  := frmIntegracao.pnlProgresso.Visible;

  frmIntegracao.memConteudoSPEDFiscal.Visible := False;
  frmIntegracao.memConteudoSPEDFiscal.Clear;

  if frmIntegracao.chkBlocosSPEDF.Checked[0] then
  begin

    frmIntegracao.ACBrSPEDFiscal1.DT_INI        := frmIntegracao.dtpSpedFDataInicial.Date;
    frmIntegracao.ACBrSPEDFiscal1.DT_FIN        := frmIntegracao.dtpSpedFDataFinal.Date;

    frmIntegracao.ACBrSPEDFiscal1.IniciaGeracao;

    frmIntegracao.lblMsg.Caption                := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco 0 - Abertura, identifica��o e refer�ncias';
    Application.ProcessMessages;

    Gravar_Bloco_0;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[1] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco C - Documentos Fiscais I - Mercadorias';
    Application.ProcessMessages;

    Gravar_Bloco_C100;
    Gravar_Bloco_C101;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[1] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco C - Equipamento ECF';
    Application.ProcessMessages;

    Gravar_registroc400;

  end;

  frmIntegracao.lblC470.Caption             := '';

  if frmIntegracao.chkBlocosSPEDF.Checked[2] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco D - Documentos Fiscais II - Servi�os';
    Application.ProcessMessages;

    Gravar_Bloco_D;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[5] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco H - Invet�rio F�sico';
    Application.ProcessMessages;

    Gravar_Bloco_H;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[3] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco E - Apura��o do ICMS e do IPI';
    Application.ProcessMessages;

    Gravar_Bloco_E;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[4] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco G - Controle do cr�dito de ICMS - CIAP';
    Application.ProcessMessages;

    Gravar_Bloco_G;

  end;

  if frmIntegracao.chkBlocosSPEDF.Checked[7] then
  begin

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario + MSG_AGUARDE + ' gerando Bloco 1 - Outras informa��es';
    Application.ProcessMessages;

    Gravar_Bloco_1;

  end;

  iTotaRegistros :=  2;

  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_0;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_C(True);
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_D;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_E;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_G;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_H;
//  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_K;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_1;
  frmIntegracao.ACBrSPEDFiscal1.WriteBloco_9;

  iTotaRegistros := iTotaRegistros
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0005Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0015Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0150Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0175Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0190Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0200Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0205Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0206Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0210Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0220Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0300Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0305Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0400Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0450Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0460Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0500Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0600Count
                    //bloco c
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC100Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC105Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC110Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC111Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC112Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC113Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC114Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC115Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC116Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC120Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC130Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC140Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC141Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC160Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC165Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC170Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC171Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC172Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC173Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC174Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC175Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC176Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC177Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC178Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC179Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC190Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC195Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC197Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC300Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC310Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC320Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC321Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC350Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC370Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC390Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC400Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC405Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC410Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC420Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC425Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC460Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC470Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC490Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC495Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC500Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC510Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC590Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC600Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC601Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC690Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC700Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC790Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC791Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC800Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC850Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC860Count
                    + frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC890Count;

  iHoraFinal                                  := Time;

  frmIntegracao.lblMsg.Caption                := '';
  frmIntegracao.lblC470.Caption               := '';
  frmIntegracao.pnlProgresso.Visible          := False;
  frmIntegracao.advMarquueProcesso.Animate    := frmIntegracao.pnlProgresso.Visible;


  Application.ProcessMessages;

  frmIntegracao.memConteudoSPEDFiscal.Visible := False;

  frmIntegracao.memConteudoSPEDFiscal.Clear;
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add(dmDBEXMaster.sNomeUsuario + ', o arquivo:');
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add(sArquivoSPED_Fiscal + ', foi criado com sucesso!');
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('----------------------------| Estat�sticas |----------------------------');
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Tempo gasto---------------------> ' + TimeToStr(iHoraFinal - frmIntegracao.iHoraInicial));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('------------------------------------------------------------------------');
{  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('*** Bloco 0');
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0005  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0005Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0015  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0015Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0150  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0150Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0175  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0175Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0190  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0190Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0200  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0200Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0205  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0205Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0206  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0206Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0210  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0210Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0220  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0220Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0300  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0300Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0305  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0305Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0400  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0400Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0450  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0450Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0460  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0460Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0500  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0500Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros 0600  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0600Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('*** Bloco C');
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C100  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC100Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C105  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC105Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C110  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC110Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C111  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC111Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C112  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC112Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C113  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC113Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C114  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC114Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C115  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC115Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C116  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC116Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C120  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC120Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C130  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC130Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C140  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC140Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C141  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC141Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C160  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC160Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C165  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC165Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C170  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC170Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C171  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC171Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C172  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC172Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C173  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC173Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C174  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC174Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C175  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC175Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C176  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC176Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C177  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC177Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C178  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC178Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C179  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC179Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C190  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC190Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C195  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC195Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C197  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC197Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C300  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC300Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C310  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC310Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C320  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC320Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C321  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC321Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C350  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC350Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C370  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC370Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C390  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC390Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C400  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC400Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C405  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC405Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C410  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC410Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C420  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC420Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C425  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC425Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C460  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC460Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C470  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC470Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C490  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC490Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C495  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC495Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C500  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC500Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C510  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC510Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C590  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC590Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C600  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC600Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C601  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC601Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C690  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC690Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C700  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC700Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C790  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC790Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C791  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC791Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C800  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC800Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C850  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC850Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C860  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC860Count)]));
  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros C890  ----> ' + Format('%-10.10s',[IntToStr(frmIntegracao.ACBrSPEDFiscal1.Bloco_C.RegistroC890Count)]));

  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('------------------------------------------------------------------------');


  frmIntegracao.memConteudoSPEDFiscal.Lines.Add('Total de registros--------------> ' + Format('%-10.10s', [IntToStr(iTotaRegistros)]));
}
  for i := 0 to frmIntegracao.memConteudoSPEDFiscal.Lines.Count - 1 do
    SendMessage(frmIntegracao.memConteudoSPEDFiscal.handle, EM_LINESCROLL, SB_LINEUP, -1);

  frmIntegracao.memConteudoSPEDFiscal.Visible := True;

  frmIntegracao.lblMsg.Caption := '';

  Application.ProcessMessages;

end;

procedure Gravar_Bloco_0;
begin

  dmMProvider.cdsCidades.Close;
  dmMProvider.cdsCidades.ProviderName := 'dspCidades';

  dmDBEXMaster.fdqCidades.SQL.Clear;
  dmDBEXMaster.fdqCidades.SQL.Add('SELECT * FROM CIDADES');
  dmDBEXMaster.fdqCidades.SQL.Add('WHERE CIDADE = ' + IntToStr(dmMProvider.cdsFilialCIDADE.Value));

  dmMProvider.cdsCidades.Open;
  dmMProvider.cdsCidades.ProviderName     := '';

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
  begin
    Application.ProcessMessages;

    // Dados da Empresa
    with Registro0000New do
    begin

      COD_VER       := Retornar_versao_SPEDF(frmIntegracao.dtpSpedFDataInicial.DateTime, frmIntegracao.dtpSpedFDataFinal.DateTime);

      case frmIntegracao.rdgFinalidadeSPEDF.ItemIndex of
        0:COD_FIN       := raOriginal;
        1:COD_FIN       := raSubstituto;
      end;

      NOME          := Trim(dmMProvider.cdsFilialRAZAOSOCIAL.Value);
      CNPJ          := Trim(LimparCpnjInscricao(dmMProvider.cdsFilialCNPJ.Value));
      CPF           := '';
      UF            := Trim(dmMProvider.cdsFilialESTADO.Value);
      IE            := Trim(LimparCpnjInscricao(dmMProvider.cdsFilialINSCRICAO.Value));
      COD_MUN       := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;
      IM            := Trim(dmMProvider.cdsFilialINSCRICAO_MUNICIPAL.Value);
      SUFRAMA       := Trim(dmMProvider.cdsFilialINSCRICAO_SUFRAMA.Value);

      case dmMProvider.cdsFilialPERFIL_SPED.Value of
        0:IND_PERFIL := pfPerfilA;
        1:IND_PERFIL := pfPerfilB;
        2:IND_PERFIL := pfPerfilC;
      end;

      case dmMProvider.cdsFilialTIPO_EMPRESA.Value of
        0:IND_ATIV    := atIndustrial;
      else
        IND_ATIV      := atOutros;
      end;


      with Registro0001New do
      begin

        IND_MOV := imComDados;

        Application.ProcessMessages;

        // FILHO - Dados complementares da Empresa
        with Registro0005New do
        begin

          FANTASIA    := Trim(dmMProvider.cdsFilialFANTASIA.Value);
          CEP         := dmMProvider.cdsFilialCEP.Value;
          ENDERECO    := Trim(dmMProvider.cdsFilialENDERECO.Value);

          if dmMProvider.cdsFilialNUMERO.Value <= 0 then
            NUM       := 'S/N'
          else
            NUM       := IntToStr(dmMProvider.cdsFilialNUMERO.Value);

          COMPL       := Trim(dmMProvider.cdsFilialCOMPLEMENTO.Value);
          BAIRRO      := Trim(dmMProvider.cdsFilialBAIRRO.Value);
          FONE        := Trim(dmMProvider.cdsFilialDDD.Value) + Trim(dmMProvider.cdsFilialTELEFONE1.Value);

          if Length(Trim(dmMProvider.cdsFilialFAX.Value)) > 0 then
            FAX        := Trim(dmMProvider.cdsFilialDDD.Value) + Trim(dmMProvider.cdsFilialFAX.Value)
          else
            FAX        := '';

          EMAIL       := Trim(dmMProvider.cdsFilialEMAIL.Value);


        end;

      end;

      // FILHO - Dados do contador.
      with Registro0100New do
      begin

        Application.ProcessMessages;

        dmMProvider.cdsCidades.Close;
        dmMProvider.cdsCidades.ProviderName := 'dspCidades';

        dmDBEXMaster.fdqCidades.SQL.Clear;
        dmDBEXMaster.fdqCidades.SQL.Add('SELECT * FROM CIDADES');
        dmDBEXMaster.fdqCidades.SQL.Add('WHERE CIDADE = ' + IntToStr(dmMProvider.cdsConfiguracoesCIDADE_CONTADOR.Value));

        dmMProvider.cdsCidades.Open;
        dmMProvider.cdsCidades.ProviderName := '';

        NOME      := Trim(dmMProvider.cdsConfiguracoesNOME_CONTADOR.Value);
        CPF       := Trim(LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCPF_CONTADOR.Value));
        CRC       := Trim(dmMProvider.cdsConfiguracoesCRC_CONTADOR.Value);
        CNPJ      := Trim(LimparCpnjInscricao(dmMProvider.cdsConfiguracoesCNPJ_CONTADOR.Value));
        CEP       := dmMProvider.cdsConfiguracoesCEP_CONTADOR.Value;
        ENDERECO  := Trim(dmMProvider.cdsConfiguracoesENDERECO_CONTADOR.Value);
        NUM       := Trim(dmMProvider.cdsConfiguracoesNUMERO_CONTADOR.Value);
        COMPL     := Trim(dmMProvider.cdsConfiguracoesCOMPLEMENTO_CONTADOR.Value);
        BAIRRO    := Trim(dmMProvider.cdsConfiguracoesBAIRRO_CONTADOR.Value);
        FONE      := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value) + Trim(dmMProvider.cdsConfiguracoesTELEFONE_CONTADOR.Value);
        if Length(Trim(dmMProvider.cdsConfiguracoesFAX_CONTADOR.Value)) > 0 then
          FAX     := Trim(dmMProvider.cdsConfiguracoesDDD_CONTADOR.Value) + Trim(dmMProvider.cdsConfiguracoesFAX_CONTADOR.Value)
        else
          FAX     := '';
        EMAIL     := Trim(dmMProvider.cdsConfiguracoesEMAIL_CONTADOR.Value);
        COD_MUN   := dmMProvider.cdsCidadesCODIGO_MUNICIPIO.Value;

      end;

    end;

  
  end;

end;

procedure Gravar_Bloco_C100;
var
  iNum_Item, iCodigoSituacao:integer;
  sCst : string;
  cAliquota, cP_Desconto, cTotalCreditos, cTotalDebitos: currency;
begin

  dmSintegraSPED.cdsSelRC100_SPED.Close;
  dmSintegraSPED.cdsSelRC100_SPED.ProviderName    := 'dspSelRC100_SPED';

  dmSintegraSPED.fdqSelRC100_SPED.Params[0].Value := frmIntegracao.dtpSpedFDataInicial.Date;
  dmSintegraSPED.fdqSelRC100_SPED.Params[1].Value := frmIntegracao.dtpSpedFDataFinal.Date;
  dmSintegraSPED.fdqSelRC100_SPED.Params[2].Value := 0;

  dmSintegraSPED.cdsSelRC100_SPED.Open;
  dmSintegraSPED.cdsSelRC100_SPED.ProviderName    := '';

  iCodigoSituacao                                 := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_SITUACAO.Value;

  iTotalRegistros                                 := dmSintegraSPED.cdsSelRC100_SPED.RecordCount;
  iRegistroAtual                                  := 0;

  while not dmSintegraSPED.cdsSelRC100_SPED.Eof do
  begin

    inc(iRegistroAtual);

    frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco C - Documentos Fiscais I - Mercadorias' + '/NF-'
                                    + FormatFloat('000000', dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value)
                                    + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
    Application.ProcessMessages;

    iCodigoSituacao                               := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_SITUACAO.Value;

    if dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value = 5330 then
      iCodigoSituacao                               := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_SITUACAO.Value;

    if (iCodigoSituacao <> 1) and (iCodigoSituacao <> 4) and (iCodigoSituacao <> 5) then
      Gravar_Registro0150(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value);

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
    begin

      with RegistroC001New do
      begin

        IND_MOV := ACBrEFDBlocos.imComDados;

        with RegistroC100New do
        begin

          if (iCodigoSituacao <> 1) and (iCodigoSituacao <> 4) then
          begin

            if (iCodigoSituacao <> 5) then // 10/01/2017
              COD_PART        := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;

            IND_EMIT        := ACBrEFDBlocos.TACBrEmitente(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_EMITENTE.Value));
            IND_OPER        := ACBrEFDBlocos.TACBrTipoOperacao(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value));
            COD_MOD         := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
            COD_SIT         := ACBrEFDBlocos.TACBrSituacaoDocto(iCodigoSituacao);
            SER             := Trim(dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value);
            NUM_DOC         := InttoStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);
            CHV_NFE         := dmSintegraSPED.cdsSelRC100_SPEDOP_CHAVE_NFE.Value;
            DT_DOC          := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_EMISSAO.Value;
            DT_E_S          := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_ENTRADA_SAIDA.Value;
            VL_DOC          := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_DOCUMENTO.Value;
            IND_PGTO        := ACBrEFDBlocos.TACBrTipoPagamento(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_PAGAMENTO.Value));
            VL_DESC         := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_DESCONTO.Value;
            VL_ABAT_NT      := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_ABATIMENTO_NT.Value;
            VL_MERC         := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_MERCADORIA.Value;

            cP_Desconto     :=0;

            if dmSintegraSPED.cdsSelRC100_SPEDOP_IND_EMITENTE.Value = '0' then
            begin

              if VL_DESC > 0 then
                cP_Desconto := VL_DESC / VL_MERC;

            end;


            IND_FRT     := ACBrEFDBlocos.TACBrTipoFrete(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_FRETE.Value));
            VL_FRT      := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_FRETE.Value;
            VL_DOC      := VL_DOC + VL_FRT;
            VL_SEG      := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_SEGURO.AsCurrency;
            VL_OUT_DA   := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_OUTRAS_DESP.AsCurrency;

            if dmMProvider.cdsFilialPERFIL_SPED.Value = 2 then
            begin//simples nacional

              VL_BC_ICMS  := 0;
              VL_ICMS     := 0;

            end
            else
            begin

              VL_BC_ICMS  := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_BASE_CALCULO.Value;
              VL_ICMS     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_ICMS.Value;

            end;

            if dmMProvider.cdsFilialREGIME_TRIBUTARIO.Value = 2 then
            begin

              VL_BC_ICMS_ST := 0;
              VL_ICMS_ST    := 0;

            end
            else
            begin

              VL_BC_ICMS_ST := 0;
              VL_ICMS_ST    := 0;

            end;

            VL_IPI        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_IPI.Value;
            VL_PIS        := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_PIS.Value;
            VL_COFINS     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_COFINS.Value;
            VL_PIS_ST     := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_PIS_ST.Value;
            VL_COFINS_ST  := dmSintegraSPED.cdsSelRC100_SPEDOP_VALOR_COFINS_ST.Value;

          end
          else if iCodigoSituacao = 1 then //DOCUMENTO CANCELADO
          begin

            IND_OPER    := ACBrEFDBlocos.TACBrTipoOperacao(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value));
            COD_MOD     := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
            COD_SIT     := ACBrEFDBlocos.TACBrSituacaoDocto(iCodigoSituacao + 1);
            NUM_DOC     := InttoStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);
            SER         := Trim(dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value);
            CHV_NFE     := dmSintegraSPED.cdsSelRC100_SPEDOP_CHAVE_NFE.Value;

          end
          else if iCodigoSituacao = 4 then //NFE OU CTE DENEGADA
          begin

            IND_OPER  := ACBrEFDBlocos.TACBrTipoOperacao(StrToInt(dmSintegraSPED.cdsSelRC100_SPEDOP_IND_OPERACAO.Value));
            COD_MOD   := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
            COD_SIT   := ACBrEFDBlocos.TACBrSituacaoDocto(iCodigoSituacao);
            NUM_DOC   := IntToStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);
            SER       := Trim(dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value);
            CHV_NFE   := dmSintegraSPED.cdsSelRC100_SPEDOP_CHAVE_NFE.Value;

          end;

{ em 26/04/2016 realocado para a procedure gravar_bloco_c113_c114

          //DOCUMENTO FISCAL EMITIDO COM BASE EM REGIME ESPECIAL OU NOTA ESPECIFICA
          if (iCodigoSituacao = 8 ) and (dmMProvider.cdsFilialPERFIL_SPED.Value <> 2) then
          begin

            with RegistroC110New do
            begin

              with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
              begin

                inc(iCodigo0450);

                with Registro0450New do
                begin

                  COD_INF :=  IntToStr(iCodigo0450);
                  TXT     := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

                end;

              end;

              COD_INF   := IntToStr(iCodigo0450);
              TXT_COMPL := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

            end;

          end;
}
          if (iCodigoSituacao <> 1) and (iCodigoSituacao <> 4) and (iCodigoSituacao <> 5) and (dmMProvider.cdsFilialPERFIL_SPED.Value <> 2) then
          begin

            dmSintegraSPED.cdsSelRC140_SPED.Close;
            dmSintegraSPED.cdsSelRC140_SPED.ProviderName := 'dspSelRC140_SPED';

            dmSintegraSPED.fdqSelRC140_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
            dmSintegraSPED.fdqSelRC140_SPED.Params[1].Value := IntToStr(dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value);

            dmSintegraSPED.cdsSelRC140_SPED.Open;
            dmSintegraSPED.cdsSelRC140_SPED.ProviderName := '';

            while not dmSintegraSPED.cdsSelRC140_SPED.Eof do
            begin

              with RegistroC140New do // Inicio Adicionar os Itens:
              begin

                IND_EMIT        := ACBrEFDBlocos.TACBrEmitente(StrToInt(dmSintegraSPED.cdsSelRC140_SPEDOP_IND_EMITENTE.Value));
                IND_TIT         := ACBrEFDBlocos.TACBrTipoTitulo(StrToInt(dmSintegraSPED.cdsSelRC140_SPEDOP_IND_TIPO_TITULO.Value));
                DESC_TIT        := dmSintegraSPED.cdsSelRC140_SPEDOP_DESCRICAO_TITULO.Value;
                NUM_TIT         := dmSintegraSPED.cdsSelRC140_SPEDOP_NUMERO_TITULO.Value;
                QTD_PARC        := dmSintegraSPED.cdsSelRC140_SPEDOP_QTD_PARCELAS.Value;
                VL_TIT          := dmSintegraSPED.cdsSelRC140_SPEDOP_VALOR_TITULO.Value;

                dmSintegraSPED.cdsSelRC141_SPED.Close;
                dmSintegraSPED.cdsSelRC141_SPED.ProviderName := 'dspSelRC141_SPED';

                dmSintegraSPED.fdqSelRC141_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                dmSintegraSPED.fdqSelRC141_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC140_SPEDOP_NOTA_FISCAL.Value;
                dmSintegraSPED.fdqSelRC141_SPED.Params[2].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
                dmSintegraSPED.fdqSelRC141_SPED.Params[3].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value;

                dmSintegraSPED.cdsSelRC141_SPED.Open;
                dmSintegraSPED.cdsSelRC141_SPED.ProviderName := '';

                while not dmSintegraSPED.cdsSelRC141_SPED.Eof do
                begin

                  with RegistroC141New do // Inicio Adicionar os Itens:
                  begin

                    NUM_PARC  := InttoStr(dmSintegraSPED.cdsSelRC141_SPEDOP_NUMERO_PARCELA.Value);
                    DT_VCTO   := dmSintegraSPED.cdsSelRC141_SPEDOP_DATA_VENCIMENTO.Value;
                    VL_PARC   := dmSintegraSPED.cdsSelRC141_SPEDOP_VALOR_PARCELA.Value;

                  end;

                  dmSintegraSPED.cdsSelRC141_SPED.Next;

                end; // Fim dos Itens;

                dmSintegraSPED.cdsSelRC140_SPED.Next;

              end;

            end;

            if dmSintegraSPED.cdsSelRC100_SPEDOP_IND_EMITENTE.Value = '1' then
            begin

              dmSintegraSPED.cdsSelRC170_SPED.Close;
              dmSintegraSPED.cdsSelRC170_SPED.ProviderName := 'dspSelRC170_SPED';

              dmSintegraSPED.fdqSelRC170_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_ENTRADA_SAIDA.Value;
              dmSintegraSPED.fdqSelRC170_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value;
              dmSintegraSPED.fdqSelRC170_SPED.Params[2].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
              dmSintegraSPED.fdqSelRC170_SPED.Params[3].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value;
              dmSintegraSPED.fdqSelRC170_SPED.Params[4].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
              dmSintegraSPED.fdqSelRC170_SPED.Params[5].Value := 0;

              dmSintegraSPED.cdsSelRC170_SPED.Open;
              dmSintegraSPED.cdsSelRC170_SPED.ProviderName := '';

              iNum_Item := 0;

              // c170
              while not dmSintegraSPED.cdsSelRC170_SPED.Eof do
              begin

                inc(iNum_Item);
                with RegistroC170New do // Inicio Adicionar os Itens:
                begin

                  Gravar_Registro0200(0, Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_COD_ITEM.Value), dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value);
                  Gravar_Registro0400(dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value);

                  NUM_ITEM          := IntToStr(iNum_Item);
                  COD_ITEM          := Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_COD_ITEM.Value);
                  DESCR_COMPL       := Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_DESCRICAO_COMPLEMENTAR.Value);
                  QTD               := dmSintegraSPED.cdsSelRC170_SPEDOP_QUANTIDADE.Value;
                  UNID              := dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value;
                  VL_ITEM           := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ITEM.Value;
                  VL_DESC           := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_DESCONTO.Value;
                  IND_MOV           := ACBrEFDBlocos.TACBrMovimentacaoFisica(StrToInt(dmSintegraSPED.cdsSelRC170_SPEDOP_IND_MOVIMENTACAO.Value));
                  CST_ICMS          := FormatFloat('000',dmSintegraSPED.cdsSelRC170_SPEDOP_CST_ICMS.Value);
                  CFOP              := dmSintegraSPED.cdsSelRC170_SPEDOP_CFOP.Value;
                  COD_NAT           := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_NATUREZA.Value;
                  VL_BC_ICMS        := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_ICMS.Value;
                  ALIQ_ICMS         := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_ICMS.Value;
                  VL_ICMS           := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_ICMS.Value;

                  if dmMProvider.cdsFilialREGIME_TRIBUTARIO.Value = 2 then
                  begin

                    VL_BC_ICMS_ST := 0;
                    // dmSintegraSPED.sqqRC170_SPED.FieldByName('VALOR_BASE_CALCULO_ST').Value;
                    ALIQ_ST       := 0;
                    // dmSintegraSPED.sqqRC170_SPED.FieldByName('ALIQUOTA_ST').Value;
                    VL_ICMS_ST    := 0;
                    // dmSintegraSPED.sqqRC170_SPED.FieldByName('VALOR_ICMS_ST').Value;

                  end
                  else
                  begin

                    VL_BC_ICMS_ST := 0;
                    ALIQ_ST       := 0;
                    VL_ICMS_ST    := 0;

                  end;

                  IND_APUR := ACBrEFDBlocos.iaMensal;

                  if dmMProvider.cdsFilialCONTRIBUINTEDOIPI.Value = 1 then
                    CST_IPI := FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_IPI.Value))
                  else
                    CST_IPI := '';

                  COD_ENQ           := '';
                  VL_BC_IPI         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_CALC_IPI.Value;
                  ALIQ_IPI          := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_IPI.Value;
                  VL_IPI            := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_IPI.Value;
                  CST_PIS           := FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_PIS.Value));
                  VL_BC_PIS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BASE_PIS.Value;
                  ALIQ_PIS_PERC     := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_PIS.Value;
                  QUANT_BC_PIS      := dmSintegraSPED.cdsSelRC170_SPEDOP_QUANT_BC_PIS.Value;
                  ALIQ_PIS_R        := dmSintegraSPED.cdsSelRC170_SPEDOP_V_ALIQ_PIS.Value;
                  VL_PIS            := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_PIS.Value;
                  CST_COFINS        := FormatFloat('00', StrToFloat(dmSintegraSPED.cdsSelRC170_SPEDOP_CST_COFINS.Value));
                  VL_BC_COFINS      := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_BC_COFINS.Value;
                  ALIQ_COFINS_PERC  := dmSintegraSPED.cdsSelRC170_SPEDOP_P_ALIQUOTA_COFINS.Value;
                  QUANT_BC_COFINS   := dmSintegraSPED.cdsSelRC170_SPEDOP_QUANTIDADE_BC_COFINS.Value;
                  ALIQ_COFINS_R     := dmSintegraSPED.cdsSelRC170_SPEDOP_V_ALIQUOTA_COFINS.Value;
                  VL_COFINS         := dmSintegraSPED.cdsSelRC170_SPEDOP_VALOR_COFINS.Value;
                  COD_CTA           := dmSintegraSPED.cdsSelRC170_SPEDOP_COD_CONTA_ANALITICA.Value;

                end; // Fim dos Itens;

                dmSintegraSPED.cdsSelRC170_SPED.Next;

              end;

            end;

          end;

          if (iCodigoSituacao <> 1) and (iCodigoSituacao <> 4) and (iCodigoSituacao <> 5) then
          begin

            dmSintegraSPED.cdsSelRC190_SPED.Close;
            dmSintegraSPED.cdsSelRC190_SPED.ProviderName := 'dspSelRC190_SPED';

            if dmSintegraSPED.cdsSelRC100_SPEDOP_IND_EMITENTE.Value = '1' then
              dmSintegraSPED.fdqSelRC190_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_ENTRADA_SAIDA.Value
            else
              dmSintegraSPED.fdqSelRC190_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_DATA_EMISSAO.Value;

            dmSintegraSPED.fdqSelRC190_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value;
            dmSintegraSPED.fdqSelRC190_SPED.Params[2].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;
            dmSintegraSPED.fdqSelRC190_SPED.Params[3].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_SERIE.Value;
            dmSintegraSPED.fdqSelRC190_SPED.Params[4].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;

            dmSintegraSPED.cdsSelRC190_SPED.Open;
            dmSintegraSPED.cdsSelRC190_SPED.ProviderName := '';


            while not dmSintegraSPED.cdsSelRC190_SPED.Eof do
            begin
              Application.ProcessMessages;

              with RegistroC190New do
              begin

                CST_ICMS    := FormatFloat('000',dmSintegraSPED.cdsSelRC190_SPEDOP_CST_ICMS.Value);
                CFOP        := dmSintegraSPED.cdsSelRC190_SPEDOP_CFOP.Value;
                ALIQ_ICMS   := dmSintegraSPED.cdsSelRC190_SPEDOP_ALIQUOTA_ICMS.Value;
                VL_OPR      := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_OPERACAO.Value;

                if cP_Desconto > 0 then
                  VL_OPR := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_OPERACAO.Value - (dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_OPERACAO .Value * cP_Desconto);

                if dmMProvider.cdsFilialPERFIL_SPED.Value = 2 then
                begin//simples nacional

                  //regra para simples nacional
                  if (CFOP[1] = '5') or (CFOP[1] = '6') then
                    cTotalICMS_DEB := cTotalICMS_DEB + Trunc((dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_ICMS.Value * (ALIQ_ICMS / 100)) *100) / 100;

                  VL_BC_ICMS  := 0;
                  VL_ICMS     := 0;

                end
                else
                begin

                  VL_BC_ICMS  := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_BC_ICMS.Value;
                  VL_ICMS     := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_ICMS.Value;

                end;

                if dmMProvider.cdsFilialREGISTROJUNTACOMERCIAL.Value = '2' then
                begin

                  VL_BC_ICMS_ST := 0;
                  // dmSintegraSPED.sqqRC190_SPED.FieldByName('VALOR_BC_ICMS_ST').Value;
                  VL_ICMS_ST    := 0;
                  // dmSintegraSPED.sqqRC190_SPED.FieldByName('VALOR_ICMS_ST').Value;

                end
                else
                begin

                  VL_BC_ICMS_ST := 0;
                  VL_ICMS_ST    := 0;

                end;

                if (CFOP <> '1410') or (CFOP <> '1411') or (CFOP <> '1414') or
                  (CFOP <> '1415') or (CFOP <> '1660') or (CFOP <> '1661') or
                  (CFOP <> '1662') or (CFOP <> '2410') or (CFOP <> '2411') or
                  (CFOP <> '2414') or (CFOP <> '2415') or (CFOP <> '2660') or
                  (CFOP <> '2661') or (CFOP <> '2662') then
                  cVL_OUT_CRED_ST := cVL_OUT_CRED_ST + VL_ICMS_ST;

                if (CFOP[1] = '5') or (CFOP[1] = '6') or (CFOP[1] = '7') then
                  cTotalICMS_DEB := cTotalICMS_DEB + VL_ICMS
                else if CFOP = '1605' then
                  cTotalICMS_DEB := cTotalICMS_DEB + VL_ICMS;

                if (CFOP[1] = '1') or (CFOP[1] = '2') or (CFOP[3] = '7') and (CFOP <> '1605') then
                  cTotalICMS_CRED := cTotalICMS_CRED + VL_ICMS
                else if CFOP = '5605' then
                  cTotalICMS_CRED := cTotalICMS_CRED + VL_ICMS;

                if dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_RED_BC.Value < 0 then
                  VL_RED_BC := 0
                else
                  VL_RED_BC := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_RED_BC.Value;

                VL_IPI  := dmSintegraSPED.cdsSelRC190_SPEDOP_VALOR_IPI.Value;
                COD_OBS := dmSintegraSPED.cdsSelRC190_SPEDOP_CODIGO_OBSERVACAO.Value;

              end; // Fim dos Itens;

              dmSintegraSPED.cdsSelRC190_SPED.Next;
            end;

          end;

        end;

      end;

    end;

    if iCodigoSituacao = 0 then
      Gravar_Bloco_C113_114;

    dmSintegraSPED.cdsSelRC100_SPED.Next;
  end;

end;

procedure Gravar_Bloco_C101;
begin

end;

procedure Gravar_Bloco_C113_114;
begin

  dmSintegraSPED.cdsSelDoc_NFS_Ref.Close;
  dmSintegraSPED.cdsSelDoc_NFS_Ref.ProviderName := 'dspSelDoc_NFS_Ref';

  dmSintegraSPED.fdqSelDoc_NFS_Ref.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_NUM_DOCUMENTO.Value;
  dmSintegraSPED.fdqSelDoc_NFS_Ref.Params[1].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
  dmSintegraSPED.fdqSelDoc_NFS_Ref.Params[2].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_MODELO.Value;

  dmSintegraSPED.cdsSelDoc_NFS_Ref.Open;
  dmSintegraSPED.cdsSelDoc_NFS_Ref.ProviderName := '';

  while not dmSintegraSPED.cdsSelDoc_NFS_Ref.Eof do
  begin

    Gravar_Registro0150(dmSintegraSPED.cdsSelDoc_NFS_RefCNPJ_FORNECEDOR_REF.Value);

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
    begin

      with RegistroC110New do
      begin

        with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
        begin

          inc(iCodigo0450);

          with Registro0450New do
          begin

            case  dmSintegraSPED.cdsSelDoc_NFS_RefTIPO_DOCUMENTO.Value of
              0,2:begin //NFE

                  COD_INF :=  IntToStr(iCodigo0450);
                  TXT     := 'NF REFERENCIADA ' + dmSintegraSPED.cdsSelDoc_NFS_RefDOCUMENTO_REF.Value;

                end;
              4:begin //CUPOM FISCAL

                  COD_INF :=  IntToStr(iCodigo0450);
                  TXT     := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

                end;
            end;

          end;

        end;

        case  dmSintegraSPED.cdsSelDoc_NFS_RefTIPO_DOCUMENTO.Value of
          0,2:begin //NFE

              COD_INF   := IntToStr(iCodigo0450);
              TXT_COMPL := 'NF REFERENCIADA ' + dmSintegraSPED.cdsSelDoc_NFS_RefDOCUMENTO_REF.Value;

              with RegistroC113New do
              begin

                IND_OPER    := ACBrEFDBlocos.StrToIndOper(IntToStr(dmSintegraSPED.cdsSelDoc_NFS_RefINDICADOR_OPERACAO.Value));
                //inclu�do tratamento em 10/01/17
                if dmSintegraSPED.cdsSelDoc_NFS_RefCNPJ_FORNECEDOR_REF.Value <> dmMProvider.cdsFilialCNPJ.Value then
                  IND_EMIT    := ACBrEFDBlocos.StrToIndEmit(IntToStr(1))
                else
                  IND_EMIT    := ACBrEFDBlocos.StrToIndEmit(IntToStr(0));

//                IND_EMIT    := ACBrEFDBlocos.StrToIndEmit(IntToStr(dmSintegraSPED.cdsSelDoc_NFS_RefINDICADOR_EMITENTE.Value)); 10/01/2017
                COD_PART    := dmSintegraSPED.cdsSelDoc_NFS_RefCNPJ_FORNECEDOR_REF.Value;
                COD_MOD     := dmSintegraSPED.cdsSelDoc_NFS_RefMODELO_DOC_REF.Value;

                if dmSintegraSPED.cdsSelDoc_NFS_RefSERIE_DOC_REF.Value >= 0 then
                  SER       := IntToStr(dmSintegraSPED.cdsSelDoc_NFS_RefSERIE_DOC_REF.Value)
                else
                  SER       := '';

                SUB         := '';
                NUM_DOC     := dmSintegraSPED.cdsSelDoc_NFS_RefDOCUMENTO_REF.Value;
                DT_DOC      := dmSintegraSPED.cdsSelDoc_NFS_RefEMISSAO_DOCUMENTO_REF.Value;

                if COD_MOD = '55' then
                  CHV_DOCe    := dmSintegraSPED.cdsSelDoc_NFS_RefCHAVE_DOCUMENTO_REF.Value;

              end;

            end;
          4:begin //CUPOM FISCAL

              COD_INF   :=  IntToStr(iCodigo0450);
              TXT_COMPL := 'DOCUMENTO EMITIDO EM CONFORMIDADE COM CUPOM FISCAL';

              with RegistroC114New do
              begin

                COD_MOD     := dmSintegraSPED.cdsSelDoc_NFS_RefMODELO_DOC_REF.Value;;
                ECF_FAB     := dmSintegraSPED.cdsSelDoc_NFS_RefCHAVE_DOCUMENTO_REF.Value;
                ECF_CX      := dmSintegraSPED.cdsSelDoc_NFS_RefSERIE_NF_SAIDA.Value;
                NUM_DOC     := dmSintegraSPED.cdsSelDoc_NFS_RefDOCUMENTO_REF.Value;
                DT_DOC      := dmSintegraSPED.cdsSelDoc_NFS_RefEMISSAO_DOCUMENTO_REF.Value;

              end;

            end;

        end;

      end;

    end;

    dmSintegraSPED.cdsSelDoc_NFS_Ref.Next;

  end;

end;

procedure Gravar_RegistroC400;
var
  iNum_Item, iC490, iT_C470, iA_C470 :integer;
  sCst: string;
  cAliquota, cP_Desconto, cTotalCreditos, cTotalDebitos: currency;
  bC490:boolean;
begin

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
  begin

    with RegistroC001 do
    begin

      dmMProvider.cdsConfigECF.Close;
      dmMProvider.cdsConfigECF.ProviderName := 'dspConfigECF';

      dmDBEXMaster.fdqConfigECF.SQL.Clear;
      dmDBEXMaster.fdqConfigECF.SQL.Add('SELECT * FROM CONFIG_CAIXAS');
      dmDBEXMaster.fdqConfigECF.SQL.Add('ORDER BY NUMERO_CAIXA');

      dmMProvider.cdsConfigECF.Open;
      dmMProvider.cdsConfigECF.ProviderName := '';

      iTotalRegistros                       := dmMProvider.cdsConfigECF.RecordCount;
      iRegistroAtual                        := 0;

      while not dmMProvider.cdsConfigECF.Eof do
      begin

        inc(iRegistroAtual);

        dmSintegraSPED.cdsSelRC405_SPED.Close;
        dmSintegraSPED.cdsSelRC405_SPED.ProviderName := 'dspSelRC405_Sped';

        dmSintegraSPED.fdqSelRC405_SPED.Params[0].Value := frmIntegracao.dtpSpedFDataInicial.Date;
        dmSintegraSPED.fdqSelRC405_SPED.Params[1].Value := frmIntegracao.dtpSpedFDataFinal.Date;
        dmSintegraSPED.fdqSelRC405_SPED.Params[2].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

        dmSintegraSPED.cdsSelRC405_SPED.Open;
        dmSintegraSPED.cdsSelRC405_SPED.ProviderName := '';

        if not dmSintegraSPED.cdsSelRC405_SPED.IsEmpty then
        begin

          with RegistroC400New do
          begin

            COD_MOD       := dmMProvider.cdsConfigECFCODIGO_MODELO_DOCUMENTO.Value;
            ECF_MOD       := dmMProvider.cdsConfigECFMODELO_ECF.Value;
            ECF_FAB       := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;
            ECF_CX        := IntToStr(dmMProvider.cdsConfigECFNUMERO_CAIXA.Value);

            while not dmSintegraSPED.cdsSelRC405_SPED.eof do
            begin

              frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando  - Redu��es Z ECF-'
                                              + dmSintegraSPED.cdsSelRC405_SPEDOP_SERIE_ECF.Value
                                              + ' * ' + FormatDateTime('dd/mm/yyyy',dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value)
                                              + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
              Application.ProcessMessages;

              with RegistroC405New do
              begin

                DT_DOC      := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                CRO         := dmSintegraSPED.cdsSelRC405_SPEDOP_CRO.Value;
                CRZ         := dmSintegraSPED.cdsSelRC405_SPEDOP_CRZ.Value;
                NUM_COO_FIN := dmSintegraSPED.cdsSelRC405_SPEDOP_NUM_COO_FINAL.Value;
                GT_FIN      := dmSintegraSPED.cdsSelRC405_SPEDOP_GT_FINAL.Value;
                VL_BRT      := dmSintegraSPED.cdsSelRC405_SPEDOP_VALOR_VENDA_BRUTA.Value;

                if dmSintegraSPED.cdsSelRC405_SPEDOP_VALOR_VENDA_BRUTA.Value > 0 then
                begin

                  if dmMProvider.cdsFilialREGIME_TRIBUTARIO.Value < 2 then
                  begin

                    dmSintegraSPED.cdsSelRC410_SPED.Close;
                    dmSintegraSPED.cdsSelRC410_SPED.ProviderName := 'dspSelRC410_SPED';

                    dmSintegraSPED.fdqSelRC410_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                    dmSintegraSPED.fdqSelRC410_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_SERIE_ECF.Value;

                    dmSintegraSPED.cdsSelRC410_SPED.Open;
                    dmSintegraSPED.cdsSelRC410_SPED.ProviderName := '';

                    while not dmSintegraSPED.cdsSelRC410_SPED.Eof do
                    begin

                      with RegistroC410New do
                      begin

                        VL_PIS    := dmSintegraSPED.cdsSelRC410_SPEDOP_VALOR_PIS.Value;
                        VL_COFINS := dmSintegraSPED.cdsSelRC410_SPEDOP_VALOR_COFINS.Value;


                      end;

                      dmSintegraSPED.cdsSelRC410_SPED.Next;

                    end;

                  end;

                  dmSintegraSPED.cdsSelRC420_SPED.Close;
                  dmSintegraSPED.cdsSelRC420_SPED.ProviderName    := 'dspSelRC420_SPED';

                  dmSintegraSPED.fdqSelRC420_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                  dmSintegraSPED.fdqSelRC420_SPED.Params[1].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

                  dmSintegraSPED.cdsSelRC420_SPED.Open;
                  dmSintegraSPED.cdsSelRC420_SPED.ProviderName := '';

                  while not dmSintegraSPED.cdsSelRC420_SPED.Eof do
                  begin

                    with RegistroC420New do
                    begin

                      COD_TOT_PAR     := dmSintegraSPED.cdsSelRC420_SPEDOP_COD_TOTALIZADOR.Value;
                      VLR_ACUM_TOT    := dmSintegraSPED.cdsSelRC420_SPEDOP_VALOR_ACUMULADO.Value;
                      NR_TOT          := dmSintegraSPED.cdsSelRC420_SPEDOP_NUMERO_TOTALIZADOR.Value;
                      DESCR_NR_TOT    := dmSintegraSPED.cdsSelRC420_SPEDOP_DESCRICAO_TOTALIZADOR.Value;


                      if dmMProvider.cdsFilialPERFIL_SPED.Value = 1 then
                      begin

                        dmSintegraSPED.cdsSelRC425_SPED.Close;
                        dmSintegraSPED.cdsSelRC425_SPED.ProviderName    := 'dspSelRC425_SPED';

                        dmSintegraSPED.fdqSelRC425_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                        dmSintegraSPED.fdqSelRC425_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC420_SPEDOP_COD_TOTALIZADOR.Value;
                        dmSintegraSPED.fdqSelRC425_SPED.Params[2].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

                        dmSintegraSPED.cdsSelRC425_SPED.Open;
                        dmSintegraSPED.cdsSelRC425_SPED.ProviderName    := '';

                        while not dmSintegraSPED.cdsSelRC425_SPED.Eof do
                        begin

                          Gravar_Registro0200(1, dmSintegraSPED.cdsSelRC425_SPEDOP_CODIGO_ITEM.Value, dmSintegraSPED.cdsSelRC425_SPEDOP_UNIDADE.Value);

                          with RegistroC425New do
                          begin

                            COD_ITEM    := dmSintegraSPED.cdsSelRC425_SPEDOP_CODIGO_ITEM.Value;
                            QTD         := dmSintegraSPED.cdsSelRC425_SPEDOP_QUANTIDADE.Value;
                            UNID        := dmSintegraSPED.cdsSelRC425_SPEDOP_UNIDADE.Value;
                            VL_ITEM     := dmSintegraSPED.cdsSelRC425_SPEDOP_VALOR_ITEM.Value;
                            VL_PIS      := dmSintegraSPED.cdsSelRC425_SPEDOP_VALOR_PIS.Value;
                            VL_COFINS   := dmSintegraSPED.cdsSelRC425_SPEDOP_VALOR_COFINS.Value;

                          end;

                          dmSintegraSPED.cdsSelRC425_SPED.Next;

                        end;

                      end;

                    end;

                    dmSintegraSPED.cdsSelRC420_SPED.Next;

                  end;

                  if dmMProvider.cdsFilialPERFIL_SPED.Value = 0  then
                  begin

                    dmSintegraSPED.cdsSelRC460_SPED.Close;
                    dmSintegraSPED.cdsSelRC460_SPED.ProviderName    := 'dspSelRC460_SPED';

                    dmSintegraSPED.fdqSelRC460_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                    dmSintegraSPED.fdqSelRC460_SPED.Params[1].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;

                    dmSintegraSPED.cdsSelRC460_SPED.Open;
                    dmSintegraSPED.cdsSelRC460_SPED.ProviderName    := '';

                    iT_C470 := dmSintegraSPED.cdsSelRC460_SPED.RecordCount;
                    iA_C470 := 0;

                    while not dmSintegraSPED.cdsSelRC460_SPED.eof do
                    begin

                      inc(iA_C470);

                      frmIntegracao.lblC470.Caption := '  Item ' + IntToStr(iA_C470)+ '/' + IntToStr(iT_C470) + '  ';
                      Application.ProcessMessages;

                      with RegistroC460New do
                      begin

                        COD_MOD     := dmSintegraSPED.cdsSelRC460_SPEDOP_CODIGO_MODELO.Value;
                        COD_SIT     := ACBrEFDBlocos.TACBrSituacaoDocto(dmSintegraSPED.cdsSelRC460_SPEDOP_SITUACAO_DOCUMENTO.Value);
                        NUM_DOC     := dmSintegraSPED.cdsSelRC460_SPEDOP_NUMERO_DOCUMENTO.Value;

                        if dmSintegraSPED.cdsSelRC460_SPEDOP_SITUACAO_DOCUMENTO.Value = 0 then
                        begin

                          DT_DOC      := dmSintegraSPED.cdsSelRC460_SPEDOP_DATA_DOCUMENTO.Value;
                          VL_DOC      := dmSintegraSPED.cdsSelRC460_SPEDOP_VALOR_DOCUMENTO.Value;
                          VL_PIS      := dmSintegraSPED.cdsSelRC460_SPEDOP_VALOR_PIS.Value;
                          VL_COFINS   := dmSintegraSPED.cdsSelRC460_SPEDOP_VALOR_COFINS.Value;
                          NOM_ADQ     := dmSintegraSPED.cdsSelRC460_SPEDOP_NOME_ADQUIRENTE.Value;
                          CPF_CNPJ    := Trim(dmSintegraSPED.cdsSelRC460_SPEDOP_CNPJ.Value);

                          dmSintegraSPED.cdsSelRC470_SPED.Close;
                          dmSintegraSPED.cdsSelRC470_SPED.ProviderName    := 'dspSelRC470_SPED';

                          dmSintegraSPED.fdqSelRC470_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                          dmSintegraSPED.fdqSelRC470_SPED.Params[1].Value := dmMProvider.cdsConfigECFNUMERO_SERIE_ECF.Value;
                          dmSintegraSPED.fdqSelRC470_SPED.Params[2].Value := dmSintegraSPED.cdsSelRC460_SPEDOP_NUMERO_DOCUMENTO.Value;

                          dmSintegraSPED.cdsSelRC470_SPED.Open;
                          dmSintegraSPED.cdsSelRC470_SPED.ProviderName    := '';

                          while not dmSintegraSPED.cdsSelRC470_SPED.Eof do
                          begin

                            Gravar_Registro0200(1, dmSintegraSPED.cdsSelRC470_SPEDOP_CODIGO_ITEM.Value, dmSintegraSPED.cdsSelRC470_SPEDOP_UNIDADE.Value);

                            with RegistroC470New do
                            begin

                              COD_ITEM      := dmSintegraSPED.cdsSelRC470_SPEDOP_CODIGO_ITEM.Value;
                              QTD           := dmSintegraSPED.cdsSelRC470_SPEDOP_QUANTIDADE.Value;
                              QTD_CANC      := dmSintegraSPED.cdsSelRC470_SPEDOP_QUANTIDADE_CANCELADA.Value;
                              UNID          := dmSintegraSPED.cdsSelRC470_SPEDOP_UNIDADE.Value;
                              VL_ITEM       := dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value;
                              CST_ICMS      := FormatFloat('000',dmSintegraSPED.cdsSelRC470_SPEDOP_CST_ICMS.Value);
                              CFOP          := dmSintegraSPED.cdsSelRC470_SPEDOP_CFOP.Value;
                              ALIQ_ICMS     := dmSintegraSPED.cdsSelRC470_SPEDOP_ALIQUOTA_ICMS.Value;
                              VL_PIS        := dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_PIS.Value;
                              VL_COFINS     := dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_COFINS.Value;

                              if dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value > 0 then
                              begin

                                if (CFOP[1] = '5') or (CFOP[1] = '6') or (CFOP[1] = '7') then
                                  cTotalICMS_DEB := cTotalICMS_DEB + Trunc((dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value * (ALIQ_ICMS / 100)) * 100) /100
                                else if CFOP = '1605' then
                                  cTotalICMS_DEB := cTotalICMS_DEB + Trunc((dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value * (ALIQ_ICMS / 100)) * 100) /100;

                              end;

                            end;

                            if dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value > 0 then
                            begin


                              with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
                              begin


                                bC490 := False;

                                for iC490 := 0 to RegistroC490.Count - 1 do
                                begin

                                  if (RegistroC490.Items[iC490].CST_ICMS = FormatFloat('000',dmSintegraSPED.cdsSelRC470_SPEDOP_CST_ICMS.Value))
                                    and (RegistroC490.Items[iC490].CFOP = dmSintegraSPED.cdsSelRC470_SPEDOP_CFOP.Value)
                                    and (RegistroC490.Items[iC490].ALIQ_ICMS = dmSintegraSPED.cdsSelRC470_SPEDOP_ALIQUOTA_ICMS.Value )then
                                  begin

                                      bC490 := True;
                                      break;

                                  end;

                                end;

                              end;

                              if not bC490 then
                              begin

                                with RegistroC490New do
                                begin

                                  CST_ICMS      := FormatFloat('000',dmSintegraSPED.cdsSelRC470_SPEDOP_CST_ICMS.Value);
                                  CFOP          := dmSintegraSPED.cdsSelRC470_SPEDOP_CFOP.Value;
                                  ALIQ_ICMS     := dmSintegraSPED.cdsSelRC470_SPEDOP_ALIQUOTA_ICMS.Value;
                                  VL_OPR        := dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value;

                                  if ALIQ_ICMS > 0 then
                                  begin

                                    VL_BC_ICMS  := dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value;
                                    VL_ICMS     := Trunc((dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value * (ALIQ_ICMS / 100)) *100 ) / 100;

                                  end
                                  else
                                  begin

                                    VL_BC_ICMS  := 0;
                                    VL_ICMS     := 0;

                                  end;

                                  COD_OBS       := '';

                                end;

                              end
                              else
                              begin

                                with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
                                begin

                                  RegistroC490.Items[iC490].CST_ICMS      := FormatFloat('000',dmSintegraSPED.cdsSelRC470_SPEDOP_CST_ICMS.Value);
                                  RegistroC490.Items[iC490].CFOP          := dmSintegraSPED.cdsSelRC470_SPEDOP_CFOP.Value;
                                  RegistroC490.Items[iC490].ALIQ_ICMS     := dmSintegraSPED.cdsSelRC470_SPEDOP_ALIQUOTA_ICMS.Value;
                                  RegistroC490.Items[iC490].VL_OPR        := RegistroC490.Items[iC490].VL_OPR + dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value;

                                  if RegistroC490.Items[iC490].ALIQ_ICMS > 0 then
                                  begin

                                    RegistroC490.Items[iC490].VL_BC_ICMS  := RegistroC490.Items[iC490].VL_BC_ICMS + dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value;
                                    RegistroC490.Items[iC490].VL_ICMS     := RegistroC490.Items[iC490].VL_ICMS    + dmSintegraSPED.cdsSelRC470_SPEDOP_VALOR_ITEM.Value * (RegistroC490.Items[iC490].ALIQ_ICMS / 100);

                                  end
                                  else
                                  begin

                                    RegistroC490.Items[iC490].VL_BC_ICMS  := RegistroC490.Items[iC490].VL_BC_ICMS + 0;
                                    RegistroC490.Items[iC490].VL_ICMS     := RegistroC490.Items[iC490].VL_ICMS    + 0;

                                  end;

                                  RegistroC490.Items[iC490].COD_OBS       := '';

                                end;

                              end;

                            end;

                            dmSintegraSPED.cdsSelRC470_SPED.Next;

                          end;
                        end
                        else
                        begin

                          VL_DOC      := 0;
                          VL_PIS      := 0;
                          VL_COFINS   := 0;
                          NOM_ADQ     := '';
                          CPF_CNPJ    := '';

                        end;

                      end;

                      dmSintegraSPED.cdsSelRC460_SPED.Next;

                    end;

                  end;

                end;

              end;

              if dmMProvider.cdsFilialPERFIL_SPED.Value = 2  then
              begin

                with RegistroC400.Items[(RegistroC400.Count -1 )] do
                begin

                  dmSintegraSPED.cdsSelRC490_SPED.Close;
                  dmSintegraSPED.cdsSelRC490_SPED.ProviderName    := 'dspSelRC490_SPED';

                  dmSintegraSPED.fdqSelRC490_SPED.Params[0].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_DATA_EMISSAO.Value;
                  dmSintegraSPED.fdqSelRC490_SPED.Params[1].Value := dmSintegraSPED.cdsSelRC405_SPEDOP_SERIE_ECF.Value;

                  dmSintegraSPED.cdsSelRC490_SPED.Open;
                  dmSintegraSPED.cdsSelRC490_SPED.ProviderName    := '';

                  iTotalRegistros              := dmSintegraSPED.cdsSelRC490_SPED.RecordCount;
                  iRegistroAtual               := 0;
                  frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando C490 - Anal�tico do mov. di�rio ECF';

                  while not dmSintegraSPED.cdsSelRC490_SPED.Eof do
                  begin

                    inc(iRegistroAtual);

                    frmIntegracao.lblC470.Caption := '  Item ' + IntToStr(iRegistroAtual)+ '/' + IntToStr(iTotalRegistros) + '  ';
                    Application.ProcessMessages;

                    if dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value > 0 then
                    begin

                      with RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490  do

                      for iC490 := 0 to RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Count - 1 do
                      begin

                        if (RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].CST_ICMS = FormatFloat('000',dmSintegraSPED.cdsSelRC490_SPEDOP_CST_ICMS.Value))
                          and (RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].CFOP = dmSintegraSPED.cdsSelRC490_SPEDOP_CFOP.Value)
                          and (RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].ALIQ_ICMS = dmSintegraSPED.cdsSelRC490_SPEDOP_ALIQUOTA_ICMS.Value )then
                        begin

                            bC490 := True;
                            break;

                        end;

                      end;

                    end;

                    if not bC490 then
                    begin

                      with RegistroC490New do
                      begin

                        CST_ICMS      := FormatFloat('000',dmSintegraSPED.cdsSelRC490_SPEDOP_CST_ICMS.Value);
                        CFOP          := dmSintegraSPED.cdsSelRC490_SPEDOP_CFOP.Value;
                        ALIQ_ICMS     := dmSintegraSPED.cdsSelRC490_SPEDOP_ALIQUOTA_ICMS.Value;
                        VL_OPR        := dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value;

                        //regra para simples nacional
                        if (CFOP[1] = '5') or (CFOP[1] = '6') then
                          cTotalICMS_DEB := cTotalICMS_DEB + Trunc((dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value * (ALIQ_ICMS / 100)) * 100) / 100;

                        if ALIQ_ICMS > 0 then
                        begin

                          VL_BC_ICMS  := dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value;
                          VL_ICMS     := Trunc((dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value * (ALIQ_ICMS / 100)) *100) / 100;

                        end
                        else
                        begin

                          VL_BC_ICMS  := 0;
                          VL_ICMS     := 0;

                        end;

                        COD_OBS       := '';

                      end;

                    end
                    else
                    begin

                      with frmIntegracao.ACBrSPEDFiscal1.Bloco_C do
                      begin

                        RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].CST_ICMS      := FormatFloat('000',dmSintegraSPED.cdsSelRC490_SPEDOP_CST_ICMS.Value);
                        RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].CFOP          := dmSintegraSPED.cdsSelRC490_SPEDOP_CFOP.Value;
                        RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].ALIQ_ICMS     := dmSintegraSPED.cdsSelRC490_SPEDOP_ALIQUOTA_ICMS.Value;
                        RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_OPR        := RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_OPR + dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value;

                        if RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].ALIQ_ICMS > 0 then
                        begin

                          RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_BC_ICMS  := RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_BC_ICMS + dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value;
                          RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_ICMS     := RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_ICMS    + dmSintegraSPED.cdsSelRC490_SPEDOP_VALOR_ITEM.Value * (RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].ALIQ_ICMS / 100);

                        end
                        else
                        begin

                          RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_BC_ICMS  := RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_BC_ICMS + 0;
                          RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_ICMS     := RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].VL_ICMS    + 0;

                        end;

                        RegistroC405.Items[(RegistroC405.Count - 1)].RegistroC490.Items[iC490].COD_OBS       := '';

                      end;

                    end;

                    dmSintegraSPED.cdsSelRC490_SPED.Next;

                  end;

                end;

              end;

              dmSintegraSPED.cdsSelRC405_SPED.Next

            end;

          end;

        end;

        dmMProvider.cdsConfigECF.Next;

      end;

    end;

  end;

end;
procedure Gravar_Bloco_D;
begin

  dmSintegraSPED.cdsSelRD100_SPED.Close;
  dmSintegraSPED.cdsSelRD100_SPED.ProviderName    := 'dspSelRD100_SPED';

  dmSintegraSPED.fdqSelRD100_SPED.Params[0].Value := frmIntegracao.dtpSpedFDataInicial.Date;
  dmSintegraSPED.fdqSelRD100_SPED.Params[1].Value := frmIntegracao.dtpSpedFDataFinal.Date;

  dmSintegraSPED.cdsSelRD100_SPED.Open;
  dmSintegraSPED.cdsSelRD100_SPED.ProviderName    := '';

  iTotalRegistros                                 := dmSintegraSPED.cdsSelRD100_SPED.RecordCount;
  iRegistroAtual                                  := 0;

  if not dmSintegraSPED.cdsSelRD100_SPED.IsEmpty then
  begin

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_D do
    begin

      with RegistroD001New do
      begin

        IND_MOV := ACBrEFDBlocos.imComDados;

        while not dmSintegraSPED.cdsSelRD100_SPED.Eof do
        begin

          inc(iRegistroAtual);

          frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco D - Documentos Fiscais II - Servi�os)'
                                          + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
          Application.ProcessMessages;

          Gravar_Registro0150(dmSintegraSPED.cdsSelRD100_SPEDOP_CODIGO_PARTICIPANTE.Value);

          with RegistroD100New do
          begin

            IND_OPER      := ACBrEFDBlocos.tpEntradaAquisicao;
            IND_EMIT      := ACBrEFDBlocos.edTerceiros;
            COD_PART      := dmSintegraSPED.cdsSelRD100_SPEDOP_CODIGO_PARTICIPANTE.Value;
            COD_MOD       := dmSintegraSPED.cdsSelRD100_SPEDOP_CODIGO_MODELO.Value;
            COD_SIT       := ACBrEFDBlocos.sdRegular;
            SER           := dmSintegraSPED.cdsSelRD100_SPEDOP_SERIE.Value;
            SUB           := Trim(dmSintegraSPED.cdsSelRD100_SPEDOP_SUB_SERIE.Value);
            NUM_DOC       := dmSintegraSPED.cdsSelRD100_SPEDOP_NUM_DOCUMENTO.Value;
            CHV_CTE       := dmSintegraSPED.cdsSelRD100_SPEDOP_CHAVE_CTE.Value;
            DT_DOC        := dmSintegraSPED.cdsSelRD100_SPEDOP_DATA_DOCUMENTO.Value;
            DT_A_P        := dmSintegraSPED.cdsSelRD100_SPEDOP_DATA_AQUISICAO.Value;
            TP_CT_e       := '';
            CHV_CTE_REF   := dmSintegraSPED.cdsSelRD100_SPEDOP_CHAVE_REFERENCIA.Value;
            VL_DOC        := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_DOCUMENTO.Value;
            VL_DESC       := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_DESCONTO.Value;
            IND_FRT       := ACBrEFDBlocos.TACBrTipoFrete(dmSintegraSPED.cdsSelRD100_SPEDOP_INDICE_FRETE.Value);
            VL_SERV       := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_SERVICO.Value;
            VL_BC_ICMS    := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_BC_ICMS.Value;
            VL_ICMS       := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_ICMS.Value;
            VL_NT         := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_NT.Value;
            COD_INF       := '';
            COD_CTA       := dmSintegraSPED.cdsSelRD100_SPEDOP_CODIGO_CONTA_ANALITICA.Value;

            with RegistroD190New do
            begin

              CST_ICMS          := '000';
              CFOP              := dmSintegraSPED.cdsSelRD100_SPEDOP_CODIGO_INFORMACAO.Value;

              if (dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_ICMS.Value > 0) and (dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_BC_ICMS.Value > 0) then
                ALIQ_ICMS       := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_ICMS.Value / (dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_BC_ICMS.Value / 100)
              else
                ALIQ_ICMS       := 0;

              VL_OPR            := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_SERVICO.Value;
              VL_BC_ICMS        := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_BC_ICMS.Value;
              VL_ICMS           := dmSintegraSPED.cdsSelRD100_SPEDOP_VALOR_ICMS.Value;

              cVL_TOT_CREDITOS  := cVL_TOT_CREDITOS + VL_ICMS;

              VL_RED_BC         := 0;
              COD_OBS           := '';

              if (CFOP[1] = '1') or (CFOP[1] = '2') or (CFOP[3] = '7') and (CFOP <> '1605') then
                cTotalICMS_CRED := cTotalICMS_CRED + VL_ICMS
              else if CFOP = '5605' then
                cTotalICMS_CRED := cTotalICMS_CRED + VL_ICMS;

            end;

          end;

          dmSintegraSPED.cdsSelRD100_SPED.Next;

        end;

      end;

    end;

  end
  else
  begin

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_D do
      with RegistroD001New do
        IND_MOV := ACBrEFDBlocos.imSemDados;

  end;

end;
procedure Gravar_Bloco_E;
begin

  frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco E - Apura��o do ICMS e do IPI';
  Application.ProcessMessages;

  with frmIntegracao. ACBrSPEDFiscal1.Bloco_E do
  begin

    with RegistroE001New do
    begin

      IND_MOV := ACBrEFDBlocos.imComDados;

      with RegistroE100New do
      begin

        DT_INI := frmIntegracao.dtpSpedFDataInicial.Date;
        DT_FIN := frmIntegracao.dtpSpedFDataFinal.Date;

        with RegistroE110New do
        begin

          VL_TOT_DEBITOS        := cTotalICMS_DEB; //cVL_TOT_DEBITOS; 05/04/15
          VL_AJ_DEBITOS         := 0;
          VL_TOT_AJ_DEBITOS     := 0;
          VL_ESTORNOS_CRED      := 0;
          VL_TOT_CREDITOS       := cTotalICMS_CRED; //cVL_TOT_CREDITOS; 05/04/15
          VL_AJ_CREDITOS        := 0;
          VL_TOT_AJ_CREDITOS    := 0;
          VL_ESTORNOS_DEB       := 0;
          VL_SLD_CREDOR_ANT     := 0;

          if cTotalICMS_CRED > cTotalICMS_DEB then
          begin

            VL_SLD_APURADO            := 0;
            VL_SLD_CREDOR_TRANSPORTAR := Trunc((cTotalICMS_CRED - cTotalICMS_DEB) * 100) / 100;
            VL_ICMS_RECOLHER          := 0;

          end
          else if cTotalICMS_CRED < cTotalICMS_DEB then
          begin

            VL_SLD_APURADO            := cTotalICMS_DEB - cTotalICMS_CRED;//cTotalICMS_CRED - cTotalICMS_DEB; //(cVL_TOT_DEBITOS - cVL_TOT_CREDITOS); 05/04/15
            VL_SLD_CREDOR_TRANSPORTAR := 0;//cTotalICMS_CRED; //0;
            VL_ICMS_RECOLHER          := VL_SLD_APURADO;// - VL_TOT_DED; 05/04/15

          end
          else//simples nacional
          begin

            VL_SLD_APURADO            := cTotalICMS_DEB;
            VL_SLD_CREDOR_TRANSPORTAR := 0;
            VL_ICMS_RECOLHER          := VL_SLD_APURADO;

          end;


          VL_TOT_DED := 0;


          if VL_ICMS_RECOLHER > 0 then
          begin

            with RegistroE116New do
            begin

              COD_OR    := '000';

              if cTotalICMS_CRED > cTotalICMS_DEB then
                VL_OR     := cTotalICMS_CRED - cTotalICMS_DEB
              else if cTotalICMS_CRED < cTotalICMS_DEB then
                VL_OR     := cTotalICMS_DEB - cTotalICMS_CRED
              else
                VL_OR     := 0;

              if VL_OR < 0 then
                VL_OR := 0;

              DT_VCTO   := Date;
              COD_REC   := '121-0';
//              NUM_PROC  := null;
              IND_PROC  := ACBrEFDBlocos.opNenhum;
//              PROC      := null;
//              TXT_COMPL := null;
              MES_REF   := FormatDateTime('mmyyyy', frmIntegracao.dtpSpedFDataInicial.Date);


            end;

          end;
          DEB_ESP := 0;

        end;

      end;

      if cTotalICMS_CRED_H20 > 0 then
      begin

        with RegistroE200New do
        begin

          UF      := dmMProvider.cdsFilialESTADO.Value;
          DT_INI := frmIntegracao.dtpSpedFDataInicial.Date;
          DT_FIN := frmIntegracao.dtpSpedFDataFinal.Date;

          with RegistroE210New do
          begin

            IND_MOV_ST                  := ACBrEFDBlocos.mstComOperacaoST;
            VL_SLD_CRED_ANT_ST          := 0;
            VL_DEVOL_ST                 := 0;
            VL_RESSARC_ST               := 0;
            VL_OUT_CRED_ST              := cTotalICMS_CRED_H20;
            VL_AJ_CREDITOS_ST           := 0;
            VL_RETENCAO_ST              := 0;
            VL_OUT_DEB_ST               := 0;
            VL_DEDUCOES_ST              := 0;
            VL_AJ_DEBITOS_ST            := 0;
            VL_SLD_DEV_ANT_ST           := 0;
            VL_DEDUCOES_ST              := 0;
            VL_ICMS_RECOL_ST            := 0;
            VL_SLD_CRED_ST_TRANSPORTAR  := cTotalICMS_CRED_H20;
            DEB_ESP_ST                  := 0;

            with RegistroE220New do
            begin

              COD_AJ_APUR     := dmSintegraSPED.fdqSelInventario.FieldByName('CODIGO_AJUSTE_APURACAO').AsString;
              DESCR_COMPL_AJ  := dmSintegraSPED.fdqSelInventario.FieldByName('DESCRICAO_COMPLEMENTAR_AJUSTE').AsString;
              VL_AJ_APUR      := cTotalICMS_CRED_H20;

            end;

          end;

        end;

      end;


    end;

  end;

end;

procedure Gravar_Bloco_G;
begin

end;

procedure Gravar_Bloco_H;
var
  iInventario: integer;
  dData, dDataAno: TDateTime;
  wAno, wMes, wDia: Word;
  cValor: currency;
begin

  cTotalICMS_CRED_H20 := 0;

  DecodeDate(frmIntegracao.dtpSpedFDataFinal.Date, wAno, wMes, wDia);

  dmSintegraSPED.fdqSelInventario.Close;
  dmSintegraSPED.fdqSelInventario.SQL.Clear;
  dmSintegraSPED.fdqSelInventario.SQL.Add('select * from inventario');
  dmSintegraSPED.fdqSelInventario.SQL.Add('where inventario = ' + IntToStr(dmMProvider.cdsInventarioINVENTARIO.AsInteger));
  dmSintegraSPED.fdqSelInventario.Open;

  if dmSintegraSPED.fdqSelInventarioVALORLIQUIDODOINVENTARIO.Value > 0 then
  begin

    iInventario := dmSintegraSPED.fdqSelInventarioINVENTARIO.Value;
    dData       := dmSintegraSPED.fdqSelInventarioDATA.Value;
    cValor      := dmSintegraSPED.fdqSelInventarioVALORLIQUIDODOINVENTARIO.Value;

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_H do
    begin

      with RegistroH001New do
      begin

        IND_MOV := ACBrEFDBlocos.imComDados;

        with RegistroH005New do
        begin

          DT_INV    := dData;
          VL_INV    := cValor;
          MOT_INV   := ACBrEFDBlocos.TACBrMotivoInventario(dmSintegraSPED.fdqSelInventarioMOTIVO_INVENTARIO.Value - 1);
          // FILHO

          dmSintegraSPED.cdsSelItemInventario.Close;
          dmSintegraSPED.cdsSelItemInventario.ProviderName := 'dspSelItemInventario';

          dmSintegraSPED.fdqSelItemInventario.Params[0].Value := dmSintegraSPED.fdqSelInventarioINVENTARIO.Value;

          dmSintegraSPED.cdsSelItemInventario.Open;
          dmSintegraSPED.cdsSelItemInventario.ProviderName := '';

          iTotalRegistros                                  := dmSintegraSPED.cdsSelItemInventario.RecordCount;
          iRegistroAtual                                   := 0;

          while not dmSintegraSPED.cdsSelItemInventario.Eof do
          begin

              inc(iRegistroAtual);

              frmIntegracao.lblMsg.Caption := dmDBEXMaster.sNomeUsuario +  MSG_AGUARDE + 'gerando Bloco H - Invet�rio F�sico'
                                              + ' * ' + IntToStr(iRegistroAtual) + '/'+ IntToStr(iTotalRegistros);
              Application.ProcessMessages;

              Gravar_Registro0200(2,IntToStr(dmSintegraSPED.cdsSelItemInventarioPRODUTO.Value), dmSintegraSPED.cdsSelItemInventarioUNIDADE.Value);
              Application.ProcessMessages;

              with RegistroH010New do
              begin

                COD_ITEM    := IntToStr(dmSintegraSPED.cdsSelItemInventarioPRODUTO.Value);
                UNID        := dmSintegraSPED.cdsSelItemInventarioUNIDADE.Value;
                QTD         := dmSintegraSPED.cdsSelItemInventarioQUANTIDADE.Value;
                VL_UNIT     := dmSintegraSPED.cdsSelItemInventarioPRECODECUSTO.Value;
                VL_ITEM     := (dmSintegraSPED.cdsSelItemInventarioQUANTIDADE.Value * dmSintegraSPED.cdsSelItemInventarioPRECODECUSTO.Value);
                IND_PROP    := ACBrEFDBlocos.piInformante;
                COD_PART    := '';
                TXT_COMPL   := '';
                COD_CTA     := '0';

                if dmSintegraSPED.fdqSelInventarioMOTIVO_INVENTARIO.Value = 2 then
                begin

                  with RegistroH020New do
                  begin

                    CST_ICMS  := IntToStr(dmSintegraSPED.cdsSelItemInventarioORIGEM_MERCADORIA.Value) + dmSintegraSPED.cdsSelItemInventarioCST_ICMS.Value;
                    BC_ICMS   := dmSintegraSPED.cdsSelItemInventarioPRECODECUSTO.Value;
                    VL_ICMS   := SimpleRoundTo(dmSintegraSPED.cdsSelItemInventarioPRECODECUSTO.Value  * (dmSintegraSPED.cdsSelItemInventarioALIQUOTA_ICMS.Value / 100));

                    cTotalICMS_CRED_H20 := cTotalICMS_CRED_H20 + (VL_ICMS * dmSintegraSPED.cdsSelItemInventarioQUANTIDADE.Value);

                  end;

                end;

              end;

              dmSintegraSPED.cdsSelItemInventario.Next;

          end;

        end;

      end;

    end;

  end
  else
  begin

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_H do
    begin

      with RegistroH001New do
      begin

        IND_MOV := ACBrEFDBlocos.imSemDados;

        with RegistroH005New do
        begin

          DT_INV := frmIntegracao.dtpSpedFDataFinal.DateTime;
          VL_INV := 0;
          MOT_INV := ACBrEFDBlocos.TACBrMotivoInventario(4); // + 1;

        end;

      end;

    end;

  end;

end;

procedure Gravar_Bloco_1;
var
  sMovimentoCartao: string;
  cTotalCreditos, cTotalDebitos: currency;
begin

  sMovimentoCartao  := 'N';
  cTotalCreditos    := 0;
  cTotalDebitos     := 0;

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_1 do
  begin

    dmSintegraSPED.fdqSelAdmCartao.Close;
    dmSintegraSPED.fdqSelAdmCartao.Params[0].Value := frmIntegracao.dtpSpedFDataInicial.Date;
    dmSintegraSPED.fdqSelAdmCartao.Params[1].Value := frmIntegracao.dtpSpedFDataFinal.Date;
    dmSintegraSPED.fdqSelAdmCartao.Open;

    if dmSintegraSPED.fdqSelAdmCartao.IsEmpty  then
    begin

      with frmIntegracao.ACBrSPEDFiscal1.Bloco_1 do
      begin

        with Registro1001New do
        begin

          IND_MOV := imSemDados;

        end;


      end;

    end
    else
    begin



    end;

    dmSintegraSPED.fdqSelAdmCartao.Close;

    with Registro1001New do
    begin

      IND_MOV := imComDados;

      with Registro1010New do
      begin

        IND_EXP     := 'N';
        IND_CCRF    := 'N';
        IND_COMB    := 'N';
        IND_USINA   := 'N';
        IND_VA      := 'N';
        IND_EE      := 'N';
        IND_CART    := sMovimentoCartao;
        IND_FORM    := 'N';
        IND_AER     := 'N';

      end;

    end;

  end;

end;

procedure Gravar_Registro0150(pCodigo_Participante:string);
begin

  dmSintegraSPED.fdqSelFornecedor.Close;
  dmSintegraSPED.fdqSelFornecedor.Params[0].Value := pCodigo_Participante;
  dmSintegraSPED.fdqSelFornecedor.open;

  if not dmSintegraSPED.fdqSelFornecedor.IsEmpty then
  begin

    with frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0001 do
    begin

      if not registro0150.LocalizaRegistro(pCodigo_Participante) then
      begin

        with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
        begin

          with Registro0150New do
          begin

            COD_PART      := pCodigo_Participante;
            NOME          := Trim(RetirarAcentuacaoString(dmSintegraSPED.fdqSelFornecedorRAZAOSOCIAL.Value));
            COD_PAIS      := IntToStr(dmSintegraSPED.fdqSelFornecedorPAIS.Value);

            if dmSintegraSPED.fdqSelFornecedorPAIS.Value <> dmMProvider.cdsFilialPAIS.Value then
            begin

              CNPJ        := '';
              CPF         := '';

            end
            else
            begin

              case dmSintegraSPED.fdqSelFornecedorTIPO.Value of
                0:begin

                    CNPJ  := '';
                    CPF   := LimparCpnjInscricao(pCodigo_Participante);

                  end;
                1:begin

                    CNPJ  := LimparCpnjInscricao(pCodigo_Participante);
                    CPF   := '';

                  end;

              end;

            end;

            if dmSintegraSPED.fdqSelFornecedorINSCRICAO.Value = 'ISENTO' then
              IE := ''
            else
              IE := LimparCpnjInscricao(dmSintegraSPED.fdqSelFornecedorINSCRICAO.Value);

            COD_MUN   := dmSintegraSPED.fdqSelFornecedorCODIGO_MUNICIPIO.Value;
            SUFRAMA   := Trim(dmSintegraSPED.fdqSelFornecedorINSCRICAO_SUFRAMA.Value);
            ENDERECO  := Trim(dmSintegraSPED.fdqSelFornecedorENDERECO.Value);

            if dmSintegraSPED.fdqSelFornecedorNUMERO.Value <= 0 then
              NUM := ''
            else
              NUM := InttoStr(dmSintegraSPED.fdqSelFornecedorNUMERO.Value);

            COMPL   := Trim(dmSintegraSPED.fdqSelFornecedorCOMPLEMENTO.Value);
            BAIRRO  := Trim(dmSintegraSPED.fdqSelFornecedorBAIRRO.Value);

          end;

        end;

      end;

    end;

  end
  else
  begin

    dmSintegraSPED.fdqSelFornecedor.Close;

    dmSintegraSPED.fdqSelClientes.Close;
    dmSintegraSPED.fdqSelClientes.Params[0].Value := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
    dmSintegraSPED.fdqSelClientes.Open;

    if not dmSintegraSPED.fdqSelClientes.Isempty then
    begin

      with frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0001 do
      begin

        if not registro0150.LocalizaRegistro(dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value) then
        begin

          with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
          begin

            with Registro0150New do
            begin

              COD_PART      := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
              NOME          := Trim(RetirarAcentuacaoString(dmSintegraSPED.fdqSelClientesRAZAOSOCIAL.Value));
              COD_PAIS      := IntToStr(dmSintegraSPED.fdqSelClientesPAIS.Value);

              if dmSintegraSPED.fdqSelClientesPAIS.Value <> dmMProvider.cdsFilialPAIS.Value then
              begin

                CNPJ        := '';
                CPF         := '';

              end
              else
              begin

                case dmSintegraSPED.fdqSelClientesTIPO.Value of
                  0:begin

                      CNPJ  := '';
                      CPF   := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;

                    end;
                  1:begin

                      CNPJ  := dmSintegraSPED.cdsSelRC100_SPEDOP_COD_PARTICIPANTE.Value;
                      CPF   := '';

                    end;

                end;

              end;

              if dmSintegraSPED.fdqSelClientesINSCRICAO.Value = 'ISENTO' then
                IE := ''
              else
                IE := dmSintegraSPED.fdqSelClientesINSCRICAO.Value;

              COD_MUN   := dmSintegraSPED.fdqSelClientesCODIGO_MUNICIPIO.Value;
              SUFRAMA   := Trim(dmSintegraSPED.fdqSelClientesINSCRICAO_SUFRAMA.Value);
              ENDERECO  := Trim(dmSintegraSPED.fdqSelClientesENDERECOENTREGA.Value);

              if dmSintegraSPED.fdqSelClientesNUMEROENTREGA.Value <= 0 then
                NUM := ''
              else
                NUM := InttoStr(dmSintegraSPED.fdqSelClientesNUMEROENTREGA.Value);

              COMPL   := Trim(dmSintegraSPED.fdqSelClientesCOMPLEMENTO.Value);
              BAIRRO  := Trim(dmSintegraSPED.fdqSelClientesBAIRROENTREGA.Value);

            end;

          end;

        end;

      end;

    end;

  end;

end;


procedure Gravar_Registro0190(pUnidade:string);
begin

  dmMProvider.cdsUndMedida.Close;
  dmMProvider.cdsUndMedida.ProviderName := 'dspUndMedida';

  dmDBEXMaster.fdqUnidadeMedida.SQL.Clear;
  dmDBEXMaster.fdqUnidadeMedida.SQL.Add('select * from unidade_medida');
  dmDBEXMaster.fdqUnidadeMedida.SQL.Add('where unidade = ' + QuotedStr(pUnidade));

  dmMProvider.cdsUndMedida.Open;
  dmMProvider.cdsUndMedida.ProviderName := '';

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0001 do
  begin

    if not Registro0190.LocalizaRegistro(pUnidade) then
    begin

      with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
      begin

        with Registro0190New do
        begin

          UNID    := pUnidade;
          if pUnidade = Trim(dmMProvider.cdsUndMedidaDESCRICAO.Value) then
            DESCR   := 'UNIDADE ' + Trim(dmMProvider.cdsUndMedidaDESCRICAO.Value)
          else
            DESCR   := Trim(dmMProvider.cdsUndMedidaDESCRICAO.Value);

        end;

      end;

    end;

  end;

end;

procedure Gravar_Registro0200(pOpcao:smallint;pCodigoItem, pUnidade:string);
begin

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0001 do
  begin

    if not Registro0200.LocalizaRegistro(pCodigoItem) then
    begin

      with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
      begin

        dmMProvider.cdsBarras.Close;
        dmMProvider.cdsBarras.ProviderName := 'dspBarras';

        dmDBEXMaster.fdqBarras.SQL.Clear;
        dmDBEXMaster.fdqBarras.SQL.Add('select * from barras');
        dmDBEXMaster.fdqBarras.SQL.Add('where produto = ' + IntToStr(StrToInt(pCodigoItem)));

        dmMProvider.cdsBarras.Open;
        dmMProvider.cdsBarras.ProviderName := '';

        with Registro0200New do
        begin

          Gravar_Registro0190(pUnidade);

          case pOpcao of
            0:begin//C170

                COD_ITEM    := pCodigoItem;
                DESCR_ITEM  := Trim(dmSintegraSPED.cdsSelRC170_SPEDOP_DESCRICAO_COMPLEMENTAR.Value);

                if dmMProvider.cdsBarrasGERADO.Value = 0 then
                  COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                else
                  COD_BARRA   := '';

                UNID_INV    := dmSintegraSPED.cdsSelRC170_SPEDOP_UNIDADE.Value;
                TIPO_ITEM   := ACBrEFDBlocos.TACBrTipoItem(dmSintegraSPED.cdsSelRC170_SPEDOP_TIPO_ITEM.Value);
                COD_NCM     := dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value;

                if dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value <> '' then
                  COD_GEN := Copy(dmSintegraSPED.cdsSelRC170_SPEDOP_NCM.Value,1,2);

                ALIQ_ICMS   := dmSintegraSPED.cdsSelRC170_SPEDOP_ALIQUOTA_ICMS.Value;
                CEST        := Trim(Format('%-9.9s',[dmSintegraSPED.cdsSelRC170_SPEDOP_CEST.Value]));

              end;

            1:begin//C425

                dmDBEXMaster.fdqMasterPesquisa.Close;
                dmDBEXMaster.fdqMasterPesquisa.SQL.Clear;
                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('SELECT PRO.DESCRICAO, PRO.UNIDADE, PRO.TIPO_ITEM, PRO.NCM, ALIQ.ALIQUOTA, NCM.TABELA_CEST');
                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('FROM PRODUTO PRO');

                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('JOIN ALIQUOTAS ALIQ');
                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('ON(ALIQ.TRIBUTACAO = PRO.TRIBUTACAO)');

                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('JOIN NBM_NCM NCM');
                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('ON(NCM.COD_NCM = PRO.NCM)');

                dmDBEXMaster.fdqMasterPesquisa.SQL.Add('WHERE PRO.PRODUTO = ' +IntToStr(StrToInt(pCodigoItem)));
                dmDBEXMaster.fdqMasterPesquisa.Open;

                COD_ITEM    := pCodigoItem;
                DESCR_ITEM  := Trim(dmDBEXMaster.fdqMasterPesquisa.FieldByName('DESCRICAO').Value);

                if dmMProvider.cdsBarrasGERADO.Value = 0 then
                  COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                else
                  COD_BARRA   := '';

                UNID_INV    := pUnidade;
                TIPO_ITEM   := ACBrEFDBlocos.TACBrTipoItem(dmDBEXMaster.fdqMasterPesquisa.FieldByName('TIPO_ITEM').Value);
                COD_NCM     := dmDBEXMaster.fdqMasterPesquisa.FieldByName('NCM').Value;

                if COD_NCM <> '' then
                  COD_GEN := Copy(COD_NCM,1,2);

                ALIQ_ICMS   := dmDBEXMaster.fdqMasterPesquisa.FieldByName('ALIQUOTA').Value;
                CEST        := dmDBEXMaster.fdqMasterPesquisa.FieldByName('TABELA_CEST').AsString;

              end;
            2:begin//H

                COD_ITEM    := pCodigoItem;
                DESCR_ITEM  := Trim(dmSintegraSPED.cdsSelItemInventarioDESCRICAO.Value);

                if dmMProvider.cdsBarrasGERADO.Value = 0 then
                  COD_BARRA := dmMProvider.cdsBarrasBARRAS.Value
                else
                  COD_BARRA   := '';

                UNID_INV    := pUnidade;
                TIPO_ITEM   := ACBrEFDBlocos.TACBrTipoItem(dmSintegraSPED.cdsSelItemInventarioTIPO_ITEM.Value);
                COD_NCM     := dmSintegraSPED.cdsSelItemInventarioNCM.Value;

                if COD_NCM <> '' then
                  COD_GEN := Copy(COD_NCM,1,2);

                ALIQ_ICMS   := dmSintegraSPED.cdsSelItemInventarioALIQUOTA_ICMS.Value;
                CEST        := dmSintegraSPED.cdsSelItemInventarioCEST.Value;

              end;

          end;

        end;

        //REGISTRO 0206: C�DIGO DE PRODUTO CONFORME TABELA PUBLICADA PELA ANP (COMBUST�VEIS)
       //        With Registro0206New do
       //        begin
       //          COD_COMB := '910101001';
       //        end;

      end;

    end;

  end;

end;

procedure Gravar_Registro0400(pCfop:string);
begin

  with frmIntegracao.ACBrSPEDFiscal1.Bloco_0.Registro0001 do
  begin

    if not Registro0400.LocalizaRegistro(pCFOP) then
    begin

      with frmIntegracao.ACBrSPEDFiscal1.Bloco_0 do
      begin

        dmMProvider.cdsCFOP_CFPS.Close;
        dmMProvider.cdsCFOP_CFPS.ProviderName := 'dspCFOP_CFPS';

        dmDBEXMaster.fdqCFOP_CFPS.SQL.Clear;
        dmDBEXMaster.fdqCFOP_CFPS.SQL.Add('select * from cfop');
        dmDBEXMaster.fdqCFOP_CFPS.SQL.Add('where cfop = ' + QuotedStr(pCfop));

        dmMProvider.cdsCFOP_CFPS.Open;
        dmMProvider.cdsCFOP_CFPS.ProviderName := '';

        with Registro0400New do
        begin

          COD_NAT   := pCfop;
          DESCR_NAT := dmMProvider.cdsCFOP_CFPSDESCRICAO.Value;

        end;

      end;

    end;

  end;

end;



function Retornar_versao_SPEDF(pDataI, pDataF: TDateTime)  : ACBrEFDBlocos.TACBrVersaoLeiaute;
begin

  if (pDataF < StrToDate('01/01/09')) then
      Result := ACBrEFDBlocos.vlVersao100
  else if (pDataI >= StrToDate('01/01/09')) and (pDataF < StrToDate('01/01/10')) then
    Result := ACBrEFDBlocos.vlVersao101
  else if (pDataI >= StrToDate('01/01/10')) and (pDataF < StrToDate('01/01/11')) then
    Result := ACBrEFDBlocos.vlVersao102
  else if (pDataI >= StrToDate('01/01/11')) and (pDataF < StrToDate('01/01/12')) then
    Result := ACBrEFDBlocos.vlVersao103
  else if (pDataI >= StrToDate('01/01/12')) and (pDataF < StrToDate('01/07/12')) then
    Result := ACBrEFDBlocos.vlVersao104
  else if (pDataI >= StrToDate('01/07/12')) and (pDataF < StrToDate('01/01/13')) then
    Result := ACBrEFDBlocos.vlVersao105
  else if (pDataI >= StrToDate('01/01/13')) and (pDataF < StrToDate('01/01/14')) then
    Result := ACBrEFDBlocos.vlVersao106
  else if (pDataI >= StrToDate('01/01/14')) and (pDataF < StrToDate('01/01/15')) then
    Result := ACBrEFDBlocos.vlVersao107
  else if (pDataI >= StrToDate('01/01/15')) and (pDataF < StrToDate('01/01/16')) then
    Result := ACBrEFDBlocos.vlVersao108
  else if (pDataI >= StrToDate('01/01/16')) and (pDataF < StrToDate('01/01/17')) then
    Result := ACBrEFDBlocos.vlVersao109
  else
    Result := ACBrEFDBlocos.vlVersao110;

end;

end.



