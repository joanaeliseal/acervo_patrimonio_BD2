-- Criação das tabelas e objetos básicos

CREATE TABLE Bem_cultural (              -- Superclasse
	IdBem			SERIAL NOT NULL, --PK
	Nome			VARCHAR(25) NOT NULL,
	Descricao		TEXT,
	DataOrigem		VARCHAR(20) NOT NULL -- algumas datas não são exatas, e.g.: século XVIII
	Seculo 			INT); -- campo para armazenar séculos (e.g., 17, 18, 19, 20)

CREATE TABLE Bem_cultural_material (	-- subclasse
	IdBem				INT NOT NULL, --PK (herdado de Bem_Cultural)
	Endereco			TEXT,
	CoordGeog			TEXT,
	EstadoConservacao	VARCHAR(15),
	ProtecaoLegal		VARCHAR(15)); -- Esfera federal, estadual ou municipal

CREATE TABLE Bem_cultural_imaterial (		-- subclasse
	IdBem					INT NOT NULL, --PK (herdado de Bem_Cultural)
	EstadoAtual				TEXT,
	Periodicidade			VARCHAR(15),
	ComunidadeAssociada		VARCHAR(15));

CREATE TABLE Categoria (
	IdCategoria		SERIAL NOT NULL, --PK
	Nome 			VARCHAR(15) UNIQUE NOT NULL,
	Descricao		TEXT);

CREATE TABLE Evento_historico (
	IdEvento		SERIAL NOT NULL, --PK
	Nome			VARCHAR(25) NOT NULL,
	Descricao		TEXT,
	DataEvento		VARCHAR(20));

CREATE TABLE Regiao (
	IdRegiao		SERIAL NOT NULL, --PK
	Nome 			VARCHAR(25) NOT NULL,
	UF				CHAR(2) NOT NULL,
	Tipo			VARCHAR(45));

CREATE TABLE Responsavel (
	IdResponsavel		SERIAL NOT NULL, --PK
	Nome 				VARCHAR(45),
	Tipo				TEXT,
	Contato				TEXT,
	CPF					CHAR(11) UNIQUE,
	CNPJ				CHAR(14) UNIQUE,
	RazaoSocial			VARCHAR(45) NOT NULL);

-- Configurando PKs, FK, UNIQUE e CHECK de validação

ALTER TABLE Bem_cultural ADD CONSTRAINT PKBem_cultural PRIMARY KEY(IDBem); 

ALTER TABLE Bem_cultural_material ADD CONSTRAINT PKBem_cultural_material PRIMARY KEY (IdBem);
ALTER TABLE Bem_cultural_material ADD CONSTRAINT FK_bem_material FOREIGN KEY (IdBem) 
REFERENCES Bem_Cultural(IdBem) ON DELETE CASCADE; -- FK

ALTER TABLE Bem_cultural_imaterial ADD CONSTRAINT PKBem_cultural_imaterial PRIMARY KEY (IdBem);
ALTER TABLE Bem_cultural_imaterial ADD CONSTRAINT FK_bem_imaterial FOREIGN KEY (IdBem) 
REFERENCES Bem_Cultural(IdBem) ON DELETE CASCADE; -- FK

ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(IdCategoria);

ALTER TABLE Evento_historico ADD CONSTRAINT PKEvento_historico PRIMARY KEY(IdEvento);

ALTER TABLE Regiao ADD CONSTRAINT PKRegiao PRIMARY KEY(IdRegiao);

ALTER TABLE Responsavel ADD CONSTRAINT PKResponsavel PRIMARY KEY (IdResponsavel);

-- Check Constraint para CPF e CNPJ
ALTER TABLE Responsavel ADD CONSTRAINT check_cpf_cnpj 
CHECK (
    (CPF IS NOT NULL AND CNPJ IS NULL) 
    OR 
    (CNPJ IS NOT NULL AND CPF IS NULL));

ALTER TABLE Bem_cultural ADD CONSTRAINT FKBem_cultural1Categ FOREIGN KEY (IdCategoria) 
REFERENCES Categoria(IdCategoria);

ALTER TABLE Bem_cultural ADD CONSTRAINT FKBem_cultural2Regiao FOREIGN KEY (IdRegiao)
REFERENCES Regiao(IdRegiao);

ALTER TABLE Bem_cultural ADD CONSTRAINT FKBem_cultural3Responsavel FOREIGN KEY(IdResponsavel)
REFERENCES Responsavel(IdResponsavel);

ALTER TABLE Bem_cultural ADD CONSTRAINT FKBem_cultural4Evento FOREIGN KEY(IdEvento)
REFERENCES Evento_historico(IdEvento);

-- Adição de colunas para relacionamentos

ALTER TABLE Bem_cultural ADD COLUMN IdCategoria INT;
ALTER TABLE Bem_cultural ADD COLUMN IdRegiao INT;
ALTER TABLE Bem_cultural ADD COLUMN IdResponsavel INT;
ALTER TABLE Bem_cultural ADD COLUMN IdEvento INT;

-- Alteração do tamanho de variáveis:
ALTER TABLE Bem_cultural ALTER COLUMN Nome TYPE VARCHAR(50);
ALTER TABLE Bem_cultural_material ALTER COLUMN Nome TYPE VARCHAR(50);
ALTER TABLE Bem_cultural_imaterial ALTER COLUMN Nome TYPE VARCHAR(50);

ALTER TABLE Evento_historico ALTER COLUMN Nome TYPE VARCHAR(50);

ALTER TABLE Responsavel ALTER COLUMN RazaoSocial TYPE VARCHAR(60);

ALTER TABLE Bem_cultural_imaterial ALTER COLUMN ComunidadeAssociada TYPE VARCHAR(40)

/* Atualização de Bens Culturais com Eventos Históricos
UPDATE Bem_cultural
SET IdEvento = (SELECT IdEvento FROM Evento_historico WHERE Nome = 'Fundação da Fazenda Acauã')
WHERE Nome = 'Casa, Capela e Sobrado da Fazenda Acauã';

UPDATE Bem_cultural
SET IdEvento = (SELECT IdEvento FROM Evento_historico WHERE Nome = 'Expulsão dos Jesuítas')
WHERE Nome = 'Palácio da Redenção';

UPDATE Bem_cultural
SET IdEvento = (SELECT IdEvento FROM Evento_historico WHERE Nome = 'Reabertura do Mosteiro de São Bento')
WHERE Nome = 'Mosteiro de São Bento';
*/
