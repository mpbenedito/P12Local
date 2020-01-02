#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} HELPA05
	Cadastro de Follow up dos chamados
	@type:  User Function
	@author: Marcelo de Paula
	@since 26/12/2019
	@version 1.0
	@param: Nenhum
	@return Nenhum, sempre nil
	/*/
User Function HELPA05()
Local aAmb, oBrowse

aAmb := getarea() 

// cria objeto browse
oBrowse := FWMBrowse():New()

// define título
oBrowse:setDescription("Follow Up dos Chamados")

// associa um alias referência
oBrowse:setAlias("ZZE")

// ativaca o objeto 
oBrowse:activate()

restarea(aAmb)

Return Nil


/*/{Protheus.doc} MenuDef
	Função padrão para tratamento de menus. O menu definido é o padrão para cadastros
	@type  Static Function
	@author Marcelo de Paula
	@since 26/12/2019
	@version 1.0
	@param Nenhum
	@return, array aRotina (padrão TOTVS)
	/*/
Static Function MenuDef()
	
Return FwMVCMenu("HELPA05")


/*/{Protheus.doc} ModelDef()
	Definição do modelo de dados para manutenção do cadastro de Tipos de Chamado
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return oModel, modelo de dados criado
	/*/
Static Function ModelDef()
Local oModel, oStruZZE

// criação do modelo de dados
oModel := MPFormModel():New("HELPA05_M")

// definição da estrutura de tabelas utilizadas
oStruZZE := FWFormStruct(1, "ZZE")

// adiciona campos da estrutura de dados ao modelo
oModel:addFields("ZZEMaster", /*cOwner*/, oStruZZE)

// define a chave primaria da tabela 
oModel:setPrimaryKey({"ZZE_FILIAL", "ZZE_CHAMAD", "ZZE_FOLLOW"})

// define o nome de tela do modelo de dados
oModel:setDescription("Follow Up dos Chamados")

// define o nome do componente de modelo de dados
oModel:getModel("ZZEMaster"):setDescription("Follow Up dos Chamados")
	
Return oModel

/*/{Protheus.doc} ViewDef()
	Definição da interface de tela para manutenção do cadastro de Tipos de Chamado
	@type  Static Function
	@author Marcelo de Paula
	@since 26/12/2019
	@version version
	@param param_name, nenhum
	@return oView, objeto com a definição da interface de tela
	/*/
Static Function ViewDef()
Local oModel, oStruZZE, oView

// recupera o modelo definido na ModelDef que será associado á interface
oModel := FWLoadModel("HELPA05")

// recupera a estrutura da tabela que será utilizada
oStruZZC := FWFormStruct(2, "ZZE")

// cria o objeto view que será a interface
oView = FWFormView():New()

// associa o modelo de dados á interface criada
oView:setModel(oModel)

// adiciona a estrutura de campos á interface, identificando a qual modelo de dados a estrutura será atrelada
oView:addField("ViewZZE", oStruZZE, "ZZEMaster")

// cria um container para apresentação das informações
oView:createHorizontalBox("TELA", 100)				//nome do container = TELA, ocupando 100% da área disponível

// relaciona a interface criada com o objeto de tela para exibição
oView:setOwnerView( "ViewZZE", "TELA")
	
Return oView