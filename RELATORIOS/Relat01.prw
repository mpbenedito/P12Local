#INCLUDE "TOTVS.CH"
#include "rwmake.ch"

#define DEV_ARQUIVO 1
#define DEV_IMIPRESSORA 2
#define DEV_EMAIL 3
#define DEV_PLANILHA 4
#define DEV_HTML 5
#define DEV_PDF 6
 
/*/{Protheus.doc} User Function Relat01
Teste de quebra de páginas em relatório TReport sem imprimir os cabeçalhos quando é gerado em excel
	@type  Function
	@author user
	@since 31/12/2019
	@version version
	@param Nenhum
	@return Sempre nil
	@example
	(examples)
	@see (links_or_references)
	/*/
User Function TREP01(param_name)
Local oRelat

lAuto := if( empty( lAuto ), .f., lAuto )
oRelat := DefRel( lAuto )
oRelat:PrintDialog()

return Nil


/*/{Protheus.doc} DefRel
Definição de linhas do relatorio
@author Marcelo de Paula
@since 31/12/2019
@version 1.0
@param lAuto, logical, descricao
@type function
/*/
Static Function DefRel( lAuto )
Local cNome, cDescri, lPaisagem, oRelat, oSecao, cPerg, lPixel
cNome := "RELAT01"
cDescri := "Relatorio de testes de Salto de Página"
lPaisagem := .T.

cPerg := ""

lPixel := .t.

oRelat := TReport():New( cNome,"Testes de Saldo de Página.", cPerg, {|oRelat| GeraRel(oRelat, lAuto ) }, cDescri, lPaisagem, /*cTotalText*/,/*lTotalLine*/, /*cTotalPage*/, /*lTotPage*/, /*lPageBreak*/, /*nSpaceCol*/ )
oRelat:nfontbody:=8

oSecao := TrSection():New( oRelat, "Seção Principal", "", /*aOrder*/, /*lLoadCells*/, /*lLoadOrder*/, /*cTotalText*/, /*lTotalLine*/,/*lHeaderPage*/, /*lHeadBreak*/, /*lPageBreak*/, .F., /*nLeftMarg*/, /*lLineStyle*/, /*nColSpace*/, .F.,	/*cCharSep*/,/*nLineBefore*/, /*nCols*/, /*nColorBG*/, /*nColorFG*/, /*nPercentual*/ )
TrCell():New(oSecao, "Coluna1",	"",	"Coluna1",	"@E 999,999.99", 9,	lPixel, /*bCodeBlock*/, "RIGHT", /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )


return oRelat


/*/{Protheus.doc} GeraRel
Preenche as informações do relatório
@author Marcelo de Paula
@since 23/12/2019
@version 1.0
@param oRelat, object, objeto do relatorio 
@param lAuto, logical, Indica se a chamada do relatorio ocorreu a partir de chamada em outros programas ou do menu de usuario
@type function
/*/
Static Function GeraRel( oRelat, lAuto )
Local aAmb, nI, oSecao, lHeader

// inicializa o relatório
aAmb := getarea()                                                                                                                   


// carrega contúdo das perguntas
cPerg := ""

oSecao  := oRelat:Section(1)

oRelat:SetMeter( 200 ) 


// se for em planilha não deverá imprimir o cabeçalho da página
lHeader := .T.
if oRelat:nDevice == DEV_PLANILHA
	lHeader := .F.
endif
oSecao:lHeaderSection := lHeader

oSecao:Init()


//laço da contagem
for nI := 1 to 200

	if oRelat:cancel()
		exit
	endif

	oRelat:incmeter() 

	oSecao:Cell("Coluna1"):Setvalue( nI )
	oSecao:PrintLine()


next nI

oSecao:Finish()

// finaliza o relatório
restarea(aAmb)

return Nil


