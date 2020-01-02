#INCLUDE "TOTVS.CH"

#define DEV_ARQUIVO 1
#define DEV_IMIPRESSORA 2
#define DEV_EMAIL 3
#define DEV_PLANILHA 4
#define DEV_HTML 5
#define DEV_PDF 6
 
/*/{Protheus.doc} User Function TREP02
Impressão de linhas longas fazendo a truncagem de textos para que as linhas não quebrem numa impressão em papel
	@type  Function
	@author user
	@since 02/01/2020
	@version version
	@param Nenhum
	@return Sempre nil
	@example
	(examples)
	@see (links_or_references)
	/*/
User Function TREP02()
Local oRelat

lAuto := if( empty( lAuto ), .f., lAuto )
oRelat := DefRel( lAuto )
oRelat:PrintDialog()

return Nil


/*/{Protheus.doc} DefRel
Definição de linhas do relatorio
@author Marcelo de Paula
@since 02/01/2020
@version 1.0
@param lAuto, logical, descricao
@type function
/*/
Static Function DefRel( lAuto )
Local cNome, cDescri, lPaisagem, oRelat, oSecao, cPerg, lPixel, cOrientacao, lQuebraLinha
cNome := "RELAT02"
cDescri := "Relatorio de testes de impressão de linhas longas"
lPaisagem := .T.

cPerg := ""

lPixel := .t.
cOrientacao := "left"

// alterar esta variável fará o relatório imprimir uma linha com ou sem quebra
lQuebraLinha := .T.

oRelat := TReport():New( cNome,"Testes de Quebra de linha.", cPerg, {|oRelat| GeraRel(oRelat, lAuto ) }, cDescri, lPaisagem, /*cTotalText*/,/*lTotalLine*/, /*cTotalPage*/, /*lTotPage*/, /*lPageBreak*/, /*nSpaceCol*/ )
oRelat:nfontbody:=8

oSecao := TrSection():New( oRelat, "Seção Principal", "", /*aOrder*/, /*lLoadCells*/, /*lLoadOrder*/, /*cTotalText*/, /*lTotalLine*/,/*lHeaderPage*/, /*lHeadBreak*/, /*lPageBreak*/, lQuebraLinha, /*nLeftMarg*/, /*lLineStyle*/, /*nColSpace*/, .F.,	/*cCharSep*/,/*nLineBefore*/, /*nCols*/, /*nColorBG*/, /*nColorFG*/, /*nPercentual*/ )
TrCell():New(oSecao, "Texto1",	"",	"Texto 1",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto2",	"",	"Texto 2",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto3",	"",	"Texto 3",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto4",	"",	"Texto 4",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto5",	"",	"Texto 5",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto6",	"",	"Texto 6",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto7",	"",	"Texto 7",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto8",	"",	"Texto 8",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )
TrCell():New(oSecao, "Texto9",	"",	"Texto 9",	/*picture*/, TAMSX3("A2_NOME")[1],	lPixel, /*bCodeBlock*/, cOrientacao, /*lLineBreak*/, /*cHeadAlign*/, /*uCompat*/, /*nColSpace*/, /*lAutoSize*/, /*nColorBG*/, /*nColorFG*/, /*lNegrito*/ )


return oRelat


/*/{Protheus.doc} GeraRel
Preenche as informações do relatório
@author Marcelo de Paula
@since 02/01/2020
@version 1.0
@param oRelat, object, objeto do relatorio 
@param lAuto, logical, Indica se a chamada do relatorio ocorreu a partir de chamada em outros programas ou do menu de usuario
@type function
/*/
Static Function GeraRel( oRelat, lAuto )
Local aAmb, oSecao, lHeader

// inicializa o relatório
aAmb := getarea()                                                                                                                   


// carrega contúdo das perguntas
cPerg := ""

oSecao  := oRelat:Section(1)

oRelat:SetMeter( 2 ) 


// se for em planilha não deverá imprimir o cabeçalho da página
lHeader := .T.
if oRelat:nDevice == DEV_PLANILHA
	lHeader := .F.
endif
oSecao:lHeaderSection := lHeader

oSecao:Init()

// Linha 1
oRelat:incmeter() 
oSecao:Cell("Texto1"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto2"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto3"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto4"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto5"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto6"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto7"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto8"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto9"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:PrintLine()

// Linha 2
oRelat:incmeter() 
oSecao:Cell("Texto1"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto2"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto3"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto4"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto5"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto6"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto7"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto8"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:Cell("Texto9"):Setvalue( "ABCDEF GH IJKLMNOPQ RSTU VWXYZ" )
oSecao:PrintLine()

oSecao:Finish()

// finaliza o relatório
restarea(aAmb)

return Nil


