-- View

CREATE VIEW v_bem_cultural AS
SELECT IdBem, Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel
FROM Bem_cultural
WITH CHECK OPTION;

-- insert através da view:
INSERT INTO v_bem_cultural (Nome, Descricao, DataOrigem, Seculo, IdCategoria, IdRegiao, IdResponsavel) 
VALUES ('Museu Imperial', 'Museu histórico do Brasil', 'Século XIX', 19, 1, 2, 1);


-- Views robusta 1:
CREATE VIEW v_detalhes_bens AS
SELECT 
    B.IdBem, B.Nome AS "Bem Cultural", B.Descricao, B.DataOrigem, B.Seculo, 
    C.Nome AS "Categoria", 
    R.Nome AS "Região", R.UF, 
    Resp.Nome AS "Responsável", Resp.RazaoSocial
FROM Bem_cultural B
INNER JOIN Categoria C ON B.IdCategoria = C.IdCategoria
INNER JOIN Regiao R ON B.IdRegiao = R.IdRegiao
INNER JOIN Responsavel Resp ON B.IdResponsavel = Resp.IdResponsavel;

-- Ex:
SELECT * FROM v_detalhes_bens WHERE Seculo = 18;

-- Views robusta 2:
CREATE VIEW v_bens_materiais AS
SELECT 
    B.Nome AS "Bem Cultural", B.Descricao, B.DataOrigem, B.Seculo, 
    BM.Endereco, BM.CoordGeog, BM.EstadoConservacao, BM.ProtecaoLegal, 
    R.Nome AS "Região", R.UF
FROM Bem_cultural B
INNER JOIN Bem_cultural_material BM ON B.IdBem = BM.IdBem
INNER JOIN Regiao R ON B.IdRegiao = R.IdRegiao;

-- Ex:
SELECT * FROM v_bens_materiais WHERE EstadoConservacao = 'Bom';

-- Índices (index):

-- index 1:
CREATE INDEX idx_bem_seculo ON Bem_cultural (Seculo);
SELECT * FROM Bem_cultural WHERE Seculo = 18;

-- index 2:
CREATE INDEX idx_bem_categoria ON Bem_cultural (IdCategoria);
SELECT * FROM Bem_cultural WHERE IdCategoria = 1;

-- index 3:
CREATE INDEX idx_bem_regiao ON Bem_cultural (IdRegiao);
SELECT * FROM Bem_cultural WHERE IdRegiao = 2;

SELECT * FROM pg_indexes WHERE tablename = 'bem_cultural';

-- Reescrita de consulta:

-- consulta 1:
SELECT Nome, Seculo
FROM Bem_cultural
WHERE Seculo = ( --  Seleciona apenas os registros cujo Seculo é igual a esse menor valor.
    SELECT MIN(Seculo) FROM Bem_cultural -- Calcula o menor valor presente na coluna Seculo de toda a tabela Bem_cultural.
);
-- reescrita 1:
SELECT Nome, Seculo
FROM Bem_cultural
ORDER BY Seculo ASC -- Organiza todos os registros de Bem_cultural em ordem crescente pelo campo Seculo.
LIMIT 10; -- Retorna apenas os 10 primeiros registros dessa ordenação.

-- consulta 2:
SELECT B.Nome AS "Bem Cultural", C.Nome AS "Categoria"
FROM Bem_cultural B
INNER JOIN Categoria C ON B.IdCategoria = C.IdCategoria;
-- reescrita 2:
SELECT C.Nome AS "Categoria", COUNT(B.IdBem) AS "Quantidade de Bens"
FROM Categoria C
LEFT JOIN Bem_cultural B ON C.IdCategoria = B.IdCategoria
GROUP BY C.Nome
ORDER BY "Quantidade de Bens" DESC;

