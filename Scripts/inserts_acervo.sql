-- Inserção de Regiões
INSERT INTO Regiao (Nome, UF, Tipo) VALUES
('Litoral', 'PB', 'Geográfica'),
('Agreste', 'PB', 'Geográfica'),
('Sertão', 'PB', 'Geográfica'),
('Alagoas', 'AL', 'Estado'),
('Bahia', 'BA', 'Estado'),
('Ceará', 'CE', 'Estado'),
('Maranhão', 'MA', 'Estado'),
('Pernambuco', 'PE', 'Estado'),
('Piauí', 'PI', 'Estado'),
('Rio Grande do Norte', 'RN', 'Estado'),
('Sergipe', 'SE', 'Estado');

-- Inserção de Categorias
INSERT INTO Categoria (Nome, Descricao) VALUES
('Histórico', 'Bens de importância histórica'),
('Religioso', 'Igrejas e construções religiosas'),
('Militar', 'Fortificações e estruturas militares'),
('Arqueológico', 'Vestígios e sítios arqueológicos'),
('Cultural', 'Manifestações culturais e artísticas'),
('Música', 'Manifestações musicais tradicionais'),
('Dança', 'Formas de dança e expressão corporal'),
('Literatura', 'Expressões literárias e orais'),
('Artes Marciais', 'Práticas de lutas e defesa pessoal tradicionais'),
('Teatro', 'Formas teatrais populares');

-- Inserção de Responsáveis
INSERT INTO Responsavel (Nome, Contato, CPF, CNPJ, RazaoSocial) VALUES
('IPHAN', 'contato@iphan.gov.br', NULL, '00394460000160', 'Instituto do Patrimônio Histórico e Artístico Nacional'),
('Governo da Paraíba', 'governo@pb.gov.br', NULL, '00555555000101', 'Secretaria de Cultura da Paraíba');

-- Inserção de Eventos Históricos
INSERT INTO Evento_historico (Nome, Descricao, DataEvento) VALUES
('Invasão Holandesa', 'Conflitos entre portugueses e holandeses no século XVII.', '1634'),
('Revolução Pernambucana', 'Movimento republicano de 1817 que teve apoio na Paraíba.', '1817'),
('Confederação do Equador', 'Tentativa de independência do Nordeste em 1824.', '1824'),
('Fundação da Fazenda Acauã', 'Estabelecimento da Fazenda Acauã, marco da ocupação do sertão paraibano.', '1757'),
('Expulsão dos Jesuítas', 'Retirada dos jesuítas do Brasil por ordem do Marquês de Pombal, afetando propriedades como o Palácio da Redenção.', '1759'),
('Reabertura do Mosteiro de São Bento', 'Reinauguração do Mosteiro após anos de fechamento devido a conflitos e restaurações.', '1995');

-- Inserção de Bens Culturais (Superclasse)
INSERT INTO Bem_cultural (Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel, IdEvento) VALUES
('Forte de Santa Catarina do Cabedelo', 'Fortaleza construída para defesa contra invasões.', '1597', 16, 3, 1, 1, 1),
('Igreja de Nossa Senhora da Misericórdia', 'Uma das primeiras igrejas da Paraíba.', '1586', 16, 2, 1, 1, NULL),
('Mosteiro de São Bento', 'Mosteiro fundado por monges beneditinos.', '1600', 17, 2, 1, 1, NULL),
('Inscrições Rupestres do Ingá', 'Sítio arqueológico com inscrições pré-históricas.', 'Pré-História', NULL, 4, 2, 1, NULL),
('Igreja de Nossa Senhora do Carmo', 'Igreja histórica com arquitetura barroca.', '1592', 16, 2, 1, 1, NULL),
('Teatro Santa Roza', 'Um dos teatros mais antigos do Brasil.', '1889', 19, 5, 1, 1, NULL),
('Literatura de Cordel', 'Expressão literária popular em forma de versos, impressa em folhetos.', 'Século XVIII', 18, 3, 1, 1, NULL),
('Repente', 'Cantoria improvisada em forma de desafio, típica do Nordeste.', 'Século XVIII', 18, 3, 1, 1, NULL),
('Matriz Tradicional do Forró', 'Gênero musical e dança que englobam estilos como xote, baião e xaxado.', 'Século XX', 20, 1, 1, 1, NULL),
('Teatro de Bonecos Popular do Nordeste', 'Manifestação teatral que utiliza bonecos, conhecida por diferentes nomes na região.', 'Século XIX', 19, 5, 1, 1, NULL);

-- Inserção de Bens Culturais Materiais (Especialização)
INSERT INTO Bem_cultural_material (IdBem, Endereco, CoordGeog, EstadoConservacao, ProtecaoLegal) VALUES
(1, 'Cabedelo - PB', 'Latitude -7.0035, Longitude -34.8284', 'Bom', 'Federal'),
(2, 'Centro Histórico de João Pessoa - PB', 'Latitude -7.1195, Longitude -34.8828', 'Restaurado', 'Federal'),
(3, 'João Pessoa - PB', 'Latitude -7.115, Longitude -34.878', 'Bom', 'Federal'),
(4, 'Ingá - PB', 'Latitude -7.2811, Longitude -35.6056', 'Preservado', 'Federal');

-- Inserção de Bens Culturais Imateriais (Especialização)
INSERT INTO Bem_cultural_imaterial (IdBem, EstadoAtual, Periodicidade, ComunidadeAssociada) VALUES
(7, 'Ativo', 'Contínuo', 'Cordelistas do Nordeste'),
(8, 'Ativo', 'Contínuo', 'Repentistas do Nordeste'),
(9, 'Ativo', 'Anual', 'Comunidades Forrozeiras'),
(10, 'Ativo', 'Contínuo', 'Bonequeiros do Nordeste');