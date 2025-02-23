-- TRUNCATE TABLE Regiao CASCADE;
-- TRUNCATE TABLE Categoria CASCADE;
-- TRUNCATE TABLE Bem_cultural CASCADE;


-- Inserção de Regiões
INSERT INTO Regiao (IdRegiao, Nome, UF, Tipo) VALUES
(1, 'Litoral', 'PB', 'Geográfica'),
(2, 'Agreste', 'PB', 'Geográfica'),
(3, 'Sertão', 'PB', 'Geográfica'),
(4, 'Alagoas', 'AL', 'Estado'),
(5, 'Bahia', 'BA', 'Estado'),
(6, 'Ceará', 'CE', 'Estado'),
(7, 'Maranhão', 'MA', 'Estado'),
(8, 'Pernambuco', 'PE', 'Estado'),
(9, 'Piauí', 'PI', 'Estado'),
(10, 'Rio Grande do Norte', 'RN', 'Estado'),
(11, 'Sergipe', 'SE', 'Estado');


-- Inserção de Categorias
INSERT INTO Categoria (IdCategoria, Nome, Descricao) VALUES
(1, 'Histórico', 'Bens de importância histórica'),
(2, 'Religioso', 'Igrejas e construções religiosas'),
(3, 'Militar', 'Fortificações e estruturas militares'),
(4, 'Arqueológico', 'Vestígios e sítios arqueológicos'),
(5, 'Cultural', 'Manifestações culturais e artísticas'),
(6, 'Música', 'Manifestações musicais tradicionais'),
(7, 'Dança', 'Formas de dança e expressão corporal'),
(8, 'Literatura', 'Expressões literárias e orais'),
(9, 'Artes Marciais', 'Práticas de lutas e defesa pessoal tradicionais'),
(10, 'Teatro', 'Formas teatrais populares');

-- Inserção de Responsáveis
INSERT INTO Responsavel (IdResponsavel, Nome, Contato, CPF, CNPJ, RazaoSocial) VALUES
(DEFAULT, 'IPHAN', 'contato@iphan.gov.br', NULL, '00394460000160', 'Instituto do Patrimônio Histórico e Artístico Nacional'),
(DEFAULT, 'Governo da Paraíba', 'governo@pb.gov.br', NULL, '00555555000101', 'Secretaria de Cultura da Paraíba');

-- Inserção de Eventos Históricos
INSERT INTO Evento_historico (Nome, Descricao, DataEvento) VALUES
('Invasão Holandesa', 'Conflitos entre portugueses e holandeses no século XVII.', '1634'),
('Revolução Pernambucana', 'Movimento republicano de 1817 que teve apoio na Paraíba.', '1817'),
('Confederação do Equador', 'Tentativa de independência do Nordeste em 1824.', '1824'),
('Fundação da Fazenda Acauã', 'Estabelecimento da Fazenda Acauã, marco da ocupação do sertão paraibano.', '1757'),
('Expulsão dos Jesuítas', 'Retirada dos jesuítas do Brasil por ordem do Marquês de Pombal, afetando propriedades como o Palácio da Redenção.', '1759'),
('Reabertura do Mosteiro de São Bento', 'Reinauguração do Mosteiro após anos de fechamento devido a conflitos e restaurações.', '1995');

-- Inserção de Bens Culturais (Superclasse) com IDs explícitos
-- o postgre gerou o id 
INSERT INTO Bem_cultural (IdBem, Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel, IdEvento) VALUES
(1, 'Forte de Santa Catarina do Cabedelo', 'Fortaleza construída para defesa contra invasões.', '1597', 16, 3, 1, 1, 1),
(2, 'Igreja de Nossa Senhora da Misericórdia', 'Uma das primeiras igrejas da Paraíba.', '1586', 16, 2, 1, 1, NULL),
(3, 'Mosteiro de São Bento', 'Mosteiro fundado por monges beneditinos.', '1600', 17, 2, 1, 1, NULL),
(4, 'Inscrições Rupestres do Ingá', 'Sítio arqueológico com inscrições pré-históricas.', 'Pré-História', NULL, 4, 2, 1, NULL),
(5, 'Igreja de Nossa Senhora do Carmo', 'Igreja histórica com arquitetura barroca.', '1592', 16, 2, 1, 1, NULL),
(6, 'Teatro Santa Roza', 'Um dos teatros mais antigos do Brasil.', '1889', 19, 5, 1, 1, NULL),
(7, 'Literatura de Cordel', 'Expressão literária popular em forma de versos, impressa em folhetos.', 'Século XVIII', 18, 3, 1, 1, NULL),
(8, 'Repente', 'Cantoria improvisada em forma de desafio, típica do Nordeste.', 'Século XVIII', 18, 3, 1, 1, NULL),
(9, 'Matriz Tradicional do Forró', 'Gênero musical e dança que englobam estilos como xote, baião e xaxado.', 'Século XX', 20, 1, 1, 1, NULL),
(10, 'Teatro de Bonecos Popular do Nordeste', 'Manifestação teatral que utiliza bonecos, conhecida por diferentes nomes na região.', 'Século XIX', 19, 5, 1, 1, NULL);

-- Inserção de Bens Culturais Materiais (Especialização)
-- Neste exemplo, mantive a coluna única de coordenadas, mas você pode ajustar se tiver colunas separadas para latitude e longitude.
INSERT INTO Bem_cultural_material (IdBem, Endereco, CoordGeog, EstadoConservacao, ProtecaoLegal) VALUES
(1, 'Cabedelo - PB', 'Latitude -7.0035, Longitude -34.8284', 'Bom', 'Federal'),
(2, 'Centro Histórico de João Pessoa - PB, Latitude -7.1195', 'Longitude -34.8828', 'Restaurado', 'Federal'),
(3, 'João Pessoa - PB', 'Latitude -7.115, Longitude -34.878', 'Bom', 'Federal'),
(4, 'Ingá - PB', 'Latitude -7.2811, Longitude -35.6056', 'Preservado', 'Federal');

-- Inserção de Bens Culturais Imateriais (Especialização)
INSERT INTO Bem_cultural_imaterial (IdBem, EstadoAtual, Periodicidade, ComunidadeAssociada) VALUES
(7, 'Ativo', 'Contínuo', 'Cordelistas do Nordeste'),
(8, 'Ativo', 'Contínuo', 'Repentistas do Nordeste'),
(9, 'Ativo', 'Anual', 'Comunidades Forrozeiras'),
(10, 'Ativo', 'Contínuo', 'Bonequeiros do Nordeste');

SELECT * FROM Regiao;
SELECT * FROM Categoria;
SELECT * FROM Responsavel;
SELECT * FROM Evento_historico;
SELECT * FROM Bem_cultural;
SELECT * FROM Bem_cultural_material;
SELECT * FROM Bem_cultural_imaterial;
