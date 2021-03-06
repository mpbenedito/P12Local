#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} HELPA03
	Cadastro de Chamados Abertos utilizando MVC
	@type:  User Function
	@author: Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param: Nenhum
	@return Nenhum, sempre nil
	/*/
User Function HELPA04()
Local aAmb, oBrowse

aAmb := getarea() 

// cria objeto browse
oBrowse := FWMBrowse():New()

// define t�tulo
oBrowse:setDescription("Controle de Chamados")

// associa um alias refer�ncia
oBrowse:setAlias("ZZD")

//defini��o de legendas
oBrowse:addLegend("ZZD_STATUS == '1'", "GREEN", "Aberto")
oBrowse:addLegend("ZZD_STATUS == '2'", "BLUE", "Em Atendimento")
oBrowse:addLegend("ZZD_STATUS == '3'", "YELLOW", "Aguardando T�cnico")
oBrowse:addLegend("ZZD_STATUS == '4'", "BLACK", "Encerrado")
oBrowse:addLegend("ZZD_STATUS == '5'", "RED", "Em Atraso")

// ativaca o objeto 
oBrowse:activate()

restarea(aAmb)

Return Nil


/*/{Protheus.doc} MenuDef
	Fun��o padr�o para tratamento de menus. O menu definido � o padr�o para cadastros
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return, array aRotina (padr�o TOTVS)
	/*/
Static Function MenuDef()
	
Return FwMVCMenu("HELPA04")


/*/{Protheus.doc} ModelDef()
	Defini��o do modelo de dados para manuten��o do cadastro de Controle de Chamados
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return oModel, modelo de dados criado
	/*/
Static Function ModelDef()
Local oModel, oStruZZD, aAuxTrig, nI

// cria��o do modelo de dados
oModel := MPFormModel():New("HELPA04_M")

// defini��o da estrutura de tabelas utilizadas
oStruZZD := FWFormStruct(1, "ZZD")

// tratamento dos gatilhos virtuais
// FwStruTrigger( dominio, contra-dom�nio, regra, posiciona, alias, indice, chave, condi��o, sequ�ncia )
aAuxTrig := {}

// prepara a trigger para a descri��o do tipo de chamado
aadd(aAuxTrig, FwStruTrigger( "ZZD_TIPO", "ZZD_TPDESC", "ZZC->ZZC_DESC", .t., "ZZC", 1, 'xfilial("ZZC") + M->ZZD_TIPO', /*condicao*/, '01' ) )

// prepara a trigger para o nome do tecnico
aadd(aAuxTrig, FwStruTrigger( "ZZD_TECNIC", "ZZD_NOMETC", "ZZA->ZZA_NOME", .t., "ZZA", 1, 'xfilial("ZZA") + M->ZZD_TECNIC', /*condicao*/, '01' ) )

// prepara a trigger para a descri��o do SLA de Atendimento
aadd(aAuxTrig, FwStruTrigger( "ZZD_PRIORI", "ZZD_DESCPR", "ZZB->ZZB_DESC", .t., "ZZB", 1, 'xfilial("ZZB") + M->ZZD_PRIORI', /*condicao*/, '01' ) )

// acrescenta as triggers dos campos virtuais
for nI := 1 to len(aAuxTrig)
	oStruZZD:addTrigger(aAuxTrig[nI][1], aAuxTrig[nI][2], aAuxTrig[nI][3], aAuxTrig[nI][4])
next

// adiciona campos da estrutura de dados ao modelo
oModel:addFields("ZZDMaster", /*cOwner*/, oStruZZD)

// define a chave primaria da tabela 
oModel:setPrimaryKey({"ZZD_FILIAL", "ZZD_COD"})

// define o nome de tela do modelo de dados
oModel:setDescription("Controle de Chamado")

// define o nome do componente de modelo de dados
oModel:getModel("ZZDMaster"):setDescription("Controle de Chamado")
	
Return oModel

/*/{Protheus.doc} ViewDef()
	Defini��o da interface de tela para manuten��o do cadastro de Controle de Chamados
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version version
	@param param_name, nenhum
	@return oView, objeto com a defini��o da interface de tela
	/*/
Static Function ViewDef()
Local oModel, oStruZZD, oView

// recupera o modelo definido na ModelDef que ser� associado � interface
oModel := FWLoadModel("HELPA04")

// recupera a estrutura da tabela que ser� utilizada
oStruZZD := FWFormStruct(2, "ZZD")

// cria o objeto view que ser� a interface
oView = FWFormView():New()

// associa o modelo de dados � interface criada
oView:setModel(oModel)

// adiciona a estrutura de campos � interface, identificando a qual modelo de dados a estrutura ser� atrelada
oView:addField("ViewZZD", oStruZZD, "ZZDMaster")

// cria um container para apresenta��o das informa��es
oView:createHorizontalBox("TELA", 100)				//nome do container = TELA, ocupando 100% da �rea dispon�vel

// relaciona a interface criada com o objeto de tela para exibi��o
oView:setOwnerView( "ViewZZD", "TELA")
	
Return oView