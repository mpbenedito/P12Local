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

// define título
oBrowse:setDescription("Controle de Chamados")

// associa um alias referência
oBrowse:setAlias("ZZD")

//definição de legendas
oBrowse:addLegend("ZZD_STATUS == '1'", "GREEN", "Aberto")
oBrowse:addLegend("ZZD_STATUS == '2'", "BLUE", "Em Atendimento")
oBrowse:addLegend("ZZD_STATUS == '3'", "YELLOW", "Aguardando Técnico")
oBrowse:addLegend("ZZD_STATUS == '4'", "BLACK", "Encerrado")
oBrowse:addLegend("ZZD_STATUS == '5'", "RED", "Em Atraso")

// ativaca o objeto 
oBrowse:activate()

restarea(aAmb)

Return Nil


/*/{Protheus.doc} MenuDef
	Função padrão para tratamento de menus. O menu definido é o padrão para cadastros
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return, array aRotina (padrão TOTVS)
	/*/
Static Function MenuDef()
	
Return FwMVCMenu("HELPA04")


/*/{Protheus.doc} ModelDef()
	Definição do modelo de dados para manutenção do cadastro de Controle de Chamados
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return oModel, modelo de dados criado
	/*/
Static Function ModelDef()
Local oModel, oStruZZD, aAuxTrig, nI

// criação do modelo de dados
oModel := MPFormModel():New("HELPA04_M")

// definição da estrutura de tabelas utilizadas
oStruZZD := FWFormStruct(1, "ZZD")

// tratamento dos gatilhos virtuais
// FwStruTrigger( dominio, contra-domínio, regra, posiciona, alias, indice, chave, condição, sequência )
aAuxTrig := {}

// prepara a trigger para a descrição do tipo de chamado
aadd(aAuxTrig, FwStruTrigger( "ZZD_TIPO", "ZZD_TPDESC", "ZZC->ZZC_DESC", .t., "ZZC", 1, 'xfilial("ZZC") + M->ZZD_TIPO', /*condicao*/, '01' ) )

// prepara a trigger para o nome do tecnico
aadd(aAuxTrig, FwStruTrigger( "ZZD_TECNIC", "ZZD_NOMETC", "ZZA->ZZA_NOME", .t., "ZZA", 1, 'xfilial("ZZA") + M->ZZD_TECNIC', /*condicao*/, '01' ) )

// prepara a trigger para a descrição do SLA de Atendimento
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
	Definição da interface de tela para manutenção do cadastro de Controle de Chamados
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version version
	@param param_name, nenhum
	@return oView, objeto com a definição da interface de tela
	/*/
Static Function ViewDef()
Local oModel, oStruZZD, oView

// recupera o modelo definido na ModelDef que será associado á interface
oModel := FWLoadModel("HELPA04")

// recupera a estrutura da tabela que será utilizada
oStruZZD := FWFormStruct(2, "ZZD")

// cria o objeto view que será a interface
oView = FWFormView():New()

// associa o modelo de dados á interface criada
oView:setModel(oModel)

// adiciona a estrutura de campos á interface, identificando a qual modelo de dados a estrutura será atrelada
oView:addField("ViewZZD", oStruZZD, "ZZDMaster")

// cria um container para apresentação das informações
oView:createHorizontalBox("TELA", 100)				//nome do container = TELA, ocupando 100% da área disponível

// relaciona a interface criada com o objeto de tela para exibição
oView:setOwnerView( "ViewZZD", "TELA")
	
Return oView