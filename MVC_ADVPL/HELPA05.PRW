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

// define t�tulo
oBrowse:setDescription("Follow Up dos Chamados")

// associa um alias refer�ncia
oBrowse:setAlias("ZZE")

// ativaca o objeto 
oBrowse:activate()

restarea(aAmb)

Return Nil


/*/{Protheus.doc} MenuDef
	Fun��o padr�o para tratamento de menus. O menu definido � o padr�o para cadastros
	@type  Static Function
	@author Marcelo de Paula
	@since 26/12/2019
	@version 1.0
	@param Nenhum
	@return, array aRotina (padr�o TOTVS)
	/*/
Static Function MenuDef()
	
Return FwMVCMenu("HELPA05")


/*/{Protheus.doc} ModelDef()
	Defini��o do modelo de dados para manuten��o do cadastro de Tipos de Chamado
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return oModel, modelo de dados criado
	/*/
Static Function ModelDef()
Local oModel, oStruZZE

// cria��o do modelo de dados
oModel := MPFormModel():New("HELPA05_M")

// defini��o da estrutura de tabelas utilizadas
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
	Defini��o da interface de tela para manuten��o do cadastro de Tipos de Chamado
	@type  Static Function
	@author Marcelo de Paula
	@since 26/12/2019
	@version version
	@param param_name, nenhum
	@return oView, objeto com a defini��o da interface de tela
	/*/
Static Function ViewDef()
Local oModel, oStruZZE, oView

// recupera o modelo definido na ModelDef que ser� associado � interface
oModel := FWLoadModel("HELPA05")

// recupera a estrutura da tabela que ser� utilizada
oStruZZC := FWFormStruct(2, "ZZE")

// cria o objeto view que ser� a interface
oView = FWFormView():New()

// associa o modelo de dados � interface criada
oView:setModel(oModel)

// adiciona a estrutura de campos � interface, identificando a qual modelo de dados a estrutura ser� atrelada
oView:addField("ViewZZE", oStruZZE, "ZZEMaster")

// cria um container para apresenta��o das informa��es
oView:createHorizontalBox("TELA", 100)				//nome do container = TELA, ocupando 100% da �rea dispon�vel

// relaciona a interface criada com o objeto de tela para exibi��o
oView:setOwnerView( "ViewZZE", "TELA")
	
Return oView