#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

/*/{Protheus.doc} HELPA02
	Cadastro de SLA Atendimento utilizando MVC
	@type:  User Function
	@author: Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param: Nenhum
	@return Nenhum, sempre nil
	/*/
User Function HELPA02()
Local aAmb, oBrowse

aAmb := getarea() 

// cria objeto browse
oBrowse := FWMBrowse():New()

// define t�tulo
oBrowse:setDescription("SLA de Atendimento")

// associa um alias refer�ncia
oBrowse:setAlias("ZZB")

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
	
Return FwMVCMenu("HELPA02")


/*/{Protheus.doc} ModelDef()
	Defini��o do modelo de dados para manuten��o do cadastro de SLA de Atendimento
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version 1.0
	@param Nenhum
	@return oModel, modelo de dados criado
	/*/
Static Function ModelDef()
Local oModel, oStruZZB

// cria��o do modelo de dados
oModel := MPFormModel():New("HELPA02_M")

// defini��o da estrutura de tabelas utilizadas
oStruZZB := FWFormStruct(1, "ZZB")

// adiciona campos da estrutura de dados ao modelo
oModel:addFields("ZZBMaster", /*cOwner*/, oStruZZB)

// define a chave primaria da tabela 
oModel:setPrimaryKey({"ZZB_FILIAL", "ZZB_COD"})

// define o nome de tela do modelo de dados
oModel:setDescription("SLA de Atendimento")

// define o nome do componente de modelo de dados
oModel:getModel("ZZBMaster"):setDescription("SLA de Atendimento")
	
Return oModel

/*/{Protheus.doc} ViewDef()
	Defini��o da interface de tela para manuten��o do cadastro de SLA de Atendimento
	@type  Static Function
	@author Marcelo de Paula
	@since 15/12/2019
	@version version
	@param param_name, nenhum
	@return oView, objeto com a defini��o da interface de tela
	/*/
Static Function ViewDef()
Local oModel, oStruZZB, oView

// recupera o modelo definido na ModelDef que ser� associado � interface
oModel := FWLoadModel("HELPA02")

// recupera a estrutura da tabela que ser� utilizada
oStruZZB := FWFormStruct(2, "ZZB")

// cria o objeto view que ser� a interface
oView = FWFormView():New()

// associa o modelo de dados � interface criada
oView:setModel(oModel)

// adiciona a estrutura de campos � interface, identificando a qual modelo de dados a estrutura ser� atrelada
oView:addField("ViewZZB", oStruZZB, "ZZBMaster")

// cria um container para apresenta��o das informa��es
oView:createHorizontalBox("TELA", 100)				//nome do container = TELA, ocupando 100% da �rea dispon�vel

// relaciona a interface criada com o objeto de tela para exibi��o
oView:setOwnerView( "ViewZZB", "TELA")
	
Return oView